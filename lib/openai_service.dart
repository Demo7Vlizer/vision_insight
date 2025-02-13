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

    // Convert image to base64 string
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    // Send request to OpenAI API
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',  // Using your specified model
        'store': true,
        'messages': [
          {
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text': 'Please describe what you see in this image.'
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
} 