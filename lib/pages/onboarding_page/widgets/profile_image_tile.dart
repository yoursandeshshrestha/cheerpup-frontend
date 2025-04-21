// File: lib/pages/widgets/profile_image_tile.dart

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileImageTile extends StatelessWidget {
  final File? profileImage;
  final Function(File?) onImageSelected;
  final VoidCallback onSkip;

  const ProfileImageTile({
    super.key,
    required this.profileImage,
    required this.onImageSelected,
    required this.onSkip,
  });

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      onImageSelected(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose your profile picture',
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: profileImage != null
                    ? DecorationImage(
                        image: FileImage(profileImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: profileImage == null
                  ? Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey[600],
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tap to select an image',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Optional: You can skip this step',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.grey[700], size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}