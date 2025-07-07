import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  final double radius;
  final String? imagePath;
  final bool isFile;
  final Color backgroundColor;
  final double? height;
  final double? width;
  final Function(String?) onImageSelected; // Changed to String?

  const ProfileAvatar({
    super.key,
    this.radius = 50,
    this.imagePath,
    this.isFile = false,
    this.backgroundColor = Colors.blue,
    this.height,
    this.width,
    required this.onImageSelected,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImagePath = picked.path;
        widget.onImageSelected(_selectedImagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.radius * 2;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: widget.height ?? size,
          width: widget.width ?? size,
          child: ClipOval(
            child: CircleAvatar(
              radius: widget.radius,
              backgroundColor: widget.backgroundColor,
              backgroundImage: _selectedImagePath != null
                  ? FileImage(File(_selectedImagePath!))
                  : widget.imagePath != null
                  ? (widget.isFile
                  ? FileImage(File(widget.imagePath!))
                  : AssetImage(widget.imagePath!)) as ImageProvider
                  : const AssetImage('assets/images/profile.png') as ImageProvider,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: InkWell(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: const Icon(Icons.camera_alt, size: 18, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}