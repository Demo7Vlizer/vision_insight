import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class OpenAIService {
  final String _baseUrl = 'https://api.openai.com/v1/chat/completions';
  late final String _apiKey;

  OpenAIService() {
    _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    if (_apiKey.isEmpty) {
      Get.snackbar(
        'Configuration Error',
        'OpenAI API key not found. Please check your .env file.',
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<String> analyzeImage(File imageFile) async {
    if (_apiKey.isEmpty) {
      throw Exception('OpenAI API key not configured');
    }

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
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
                    'url': 'data:image/jpeg;base64,$base64Image'
                  }
                }
              ]
            }
          ],
          'max_tokens': 300,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('API Response: ${response.body}');
        return data['choices'][0]['message']['content'] ?? 'No description available';
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
    if (_apiKey.isEmpty) {
      throw Exception('OpenAI API key not configured');
    }

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text': question
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image'
                  }
                }
              ]
            }
          ],
          'max_tokens': 300,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('API Response: ${response.body}');
        return data['choices'][0]['message']['content'] ?? 'No response available';
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