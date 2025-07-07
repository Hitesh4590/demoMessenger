import 'package:flutter/material.dart';

class CurvedBottomContainer extends StatelessWidget {
  final double height;
  final double curveHeight;
  final double curveDepth; // New parameter for smooth transitions
  final Color color;
  final Widget? child;

  const CurvedBottomContainer({
    super.key,
    this.height = 200,
    this.curveHeight = 10, // Increase this for a more dramatic curve
    this.curveDepth = 100, // Controls the curve depth for transitions
    this.color = Colors.blue,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CurvedBottomClipper(
        curveHeight: curveHeight,
        curveDepth: curveDepth,
      ),
      child: Container(
        height: height,
        color: color,
        child: child,
      ),
    );
  }
}

class _CurvedBottomClipper extends CustomClipper<Path> {
  final double curveHeight;
  final double curveDepth;

  _CurvedBottomClipper({
    required this.curveHeight,
    required this.curveDepth,
  });

  @override
  Path getClip(Size size) {
    final curveStart = size.height - curveDepth;

    Path path = Path();
    path.lineTo(0, curveStart);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + curveHeight, // More curve depth here
      size.width,
      curveStart,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper is _CurvedBottomClipper &&
        (oldClipper.curveHeight != curveHeight ||
            oldClipper.curveDepth != curveDepth);
  }
}