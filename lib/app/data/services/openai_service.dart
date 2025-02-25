import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class OpenAIService {
  final String _baseUrl =
      'https://models.inference.ai.azure.com/chat/completions';
  late final String _token;

  OpenAIService() {
    _token = dotenv.env['GITHUB_TOKEN'] ?? '';
    if (_token.isEmpty) {
      Get.snackbar(
        'Configuration Error',
        'GitHub token not found. Please check your .env file.',
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<String> analyzeImage(File imageFile) async {
    if (_token.isEmpty) {
      throw Exception('GitHub token not configured');
    }

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'model': 'gpt-4o',
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text': 'What is in this image? Describe in detail.'
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                    'details': 'low'
                  }
                }
              ]
            }
          ],
          'temperature': 1.0,
          'top_p': 1.0,
          'max_tokens': 300
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('API Response: ${response.body}');
        return data['choices'][0]['message']['content'] ??
            'No description available';
      } else {
        debugPrint('API Error: ${response.body}');
        final error = jsonDecode(response.body);
        throw Exception(error['error']['message']);
      }
    } catch (e) {
      debugPrint('Exception: $e');
      throw Exception('Error analyzing image: $e');
    }
  }

  Future<String> askQuestionAboutImage(File imageFile, String question) async {
    if (_token.isEmpty) {
      throw Exception('GitHub token not configured');
    }

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          'model': 'gpt-4o',
          'messages': [
            {
              'role': 'user',
              'content': [
                {'type': 'text', 'text': question},
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                    'details': 'low'
                  }
                }
              ]
            }
          ],
          'temperature': 1.0,
          'top_p': 1.0,
          'max_tokens': 300
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('API Response: ${response.body}');
        return data['choices'][0]['message']['content'] ??
            'No response available';
      } else {
        debugPrint('API Error: ${response.body}');
        final error = jsonDecode(response.body);
        throw Exception(error['error']['message']);
      }
    } catch (e) {
      debugPrint('Exception: $e');
      throw Exception('Error getting response: $e');
    }
  }
}
