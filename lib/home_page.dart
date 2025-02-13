import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:project_t/models/chat_message.dart';
import 'package:project_t/openai_service.dart';
import 'package:project_t/widgets/chat_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables and stuff..
  File? _image;
  String? _description;
  bool _isLoading = false;
  final _picker = ImagePicker();
  final _chatController = TextEditingController();
  final List<ChatMessage> _chatMessages = [];

  // pick image method
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 84, // Reduce quality to decrease file size
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final imageSize = await imageFile.length();
        debugPrint('Image size: ${imageSize / 1024 / 1024} MB');

        // Check if image is not too large (e.g., 10MB limit)
        if (imageSize > 10 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Image is too large. Please choose a smaller image.')),
            );
          }
          return;
        }

        setState(() {
          _image = imageFile;
          _description = null;
          _chatMessages.clear(); // Clear chat messages when new image is uploaded
        });
        await _analyzeImage();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  //analyse image method
  Future<void> _analyzeImage() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
      _description = null;
    });

    try {
      debugPrint('Starting image analysis...');
      final description = await OpenAIService().analyzeImage(_image!);
      debugPrint('Received description: $description');

      if (mounted) {
        setState(() {
          _description = description;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error analyzing image: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error analyzing image: $e'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Future<void> _sendQuestion() async {
    if (_image == null || _chatController.text.trim().isEmpty) return;

    final question = _chatController.text.trim();
    _chatController.clear();

    setState(() {
      _chatMessages.add(ChatMessage(
        text: question,
        isUser: true,
      ));
      _isLoading = true;
    });

    try {
      final answer =
          await OpenAIService().askQuestionAboutImage(_image!, question);

      if (mounted) {
        setState(() {
          _chatMessages.add(ChatMessage(
            text: answer,
            isUser: false,
          ));
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error getting answer: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "AI VISION APP",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image Container
                  Container(
                    height: 300,
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Choose image..",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                  ),

                  // Image Selection Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _pickImage(ImageSource.camera),
                            child: const Text("Take Photo"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _pickImage(ImageSource.gallery),
                            child: const Text("Pick from gallery"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Initial Description
                  if (_description != null)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Initial Analysis:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _description!,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Chat Section
                  if (_image != null) ChatSection(messages: _chatMessages),
                ],
              ),
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),

          // Chat Input
          if (_image != null)
            ChatInput(
              controller: _chatController,
              isLoading: _isLoading,
              onSend: _sendQuestion,
            ),
        ],
      ),
    );
  }
}
