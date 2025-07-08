import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  /// Optional colors that override the theme if provided
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ProfileActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle? baseStyle = Theme.of(context).elevatedButtonTheme.style;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: baseStyle?.copyWith(
          backgroundColor: backgroundColor != null
              ? WidgetStateProperty.all(backgroundColor)
              : null,
          foregroundColor: foregroundColor != null
              ? WidgetStateProperty.all(foregroundColor)
              : null,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
