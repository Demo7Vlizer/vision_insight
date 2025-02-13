import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String _baseUrl = 'https://api.openai.com/v1/chat/completions';
  // Get API key from environment variables
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  Future<String> analyzeImage(File image) async {
    if (_apiKey.isEmpty) {
      throw Exception('OpenAI API key not found in environment variables');
    }

    final bytes = await image.readAsBytes();
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
                'text': 'What is in this image?'
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
        'max_tokens': 300
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      debugPrint('API Response: ${response.body}');
      return data['choices'][0]['message']['content'] ?? 'No description available';
    } else {
      debugPrint('API Error: ${response.body}');
      throw Exception(
          'Failed to analyze image: ${response.statusCode} - ${response.body}');
    }
  }

  Future<String> askQuestionAboutImage(File image, String question) async {
    if (_apiKey.isEmpty) {
      throw Exception('OpenAI API key not found in environment variables');
    }

    final bytes = await image.readAsBytes();
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
        'max_tokens': 300
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'] ?? 'No response available';
    } else {
      throw Exception('Failed to get answer: ${response.statusCode} - ${response.body}');
    }
  }
} 