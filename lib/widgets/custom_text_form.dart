// Define a StateProvider for password visibility, initialized with obscureText
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final obscureTextProvider =
    StateProvider.family<bool, ({Key? key, bool initialObscure})>(
      (ref, params) => params.initialObscure,
    );

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    required this.obscureText,
    required this.paddingValue,
    required this.focusNode, // Add FocusNode
    this.textInputAction = TextInputAction.next, // Default to next
    this.onSubmitted, // Optional callback for next action
    this.controller,
    this.validator,
  });

  final String labelText;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final double? paddingValue;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        final isObscured = ref.watch(
          obscureTextProvider((key: key, initialObscure: obscureText)),
        );

        return Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              validator: validator,
              focusNode: focusNode,
              textInputAction: textInputAction,
              onFieldSubmitted: (_) => onSubmitted?.call(),
              // Call onSubmitted when Next/Done is pressed
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                prefixIcon: Icon(icon, color: Colors.blue.shade700),
                suffixIcon: obscureText
                    ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue.shade700,
                  ),
                  onPressed: () {
                    ref
                        .read(
                      obscureTextProvider((
                      key: key,
                      initialObscure: obscureText,
                      )).notifier,
                    )
                        .state = !isObscured;
                  },
                )
                    : null,
                labelStyle: TextStyle(
                  color: Colors.grey.shade600, // Default label color
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.blue.shade700, // Label color when focused
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue.shade200, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue.shade200, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.red.shade400, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              obscureText: obscureText ? isObscured : false,
              keyboardType: keyboardType,
            ),
            SizedBox(height: paddingValue),
          ],
        );
      },
    );
  }
}
