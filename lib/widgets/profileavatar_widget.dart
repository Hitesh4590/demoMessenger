import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final String imagePath;
  final Color backgroundColor;

  const ProfileAvatar({
    super.key,
    this.radius = 50,
    required this.imagePath,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: AssetImage(imagePath),
    );
  }
}
