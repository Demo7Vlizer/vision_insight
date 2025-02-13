import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:project_t/openai_service.dart';

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

  // pick image method
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 84,  // Reduce quality to decrease file size
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
              const SnackBar(content: Text('Image is too large. Please choose a smaller image.')),
            );
          }
          return;
        }

        setState(() {
          _image = imageFile;
          _description = null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "AI VISION APP",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // DISPLAY IMAGE 
            Container(
              height: 400,
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

            // BUTTONS 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

            const SizedBox(height: 24),

            // DESCRIPTION 
            Padding(
              padding: const EdgeInsets.all(16),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _description != null
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _description!,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        )
                      : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
