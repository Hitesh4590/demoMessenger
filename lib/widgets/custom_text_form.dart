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
                labelStyle: TextStyle(
                  color: theme.primaryColor, // Set label text color
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: theme.hintColor, // Set hint text color
                ),
                prefixIcon: Icon(icon, color: theme.primaryColor),
                suffixIcon: obscureText
                    ? IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          ref
                                  .read(
                                    obscureTextProvider((
                                      key: key,
                                      initialObscure: obscureText,
                                    )).notifier,
                                  )
                                  .state =
                              !isObscured;
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: theme.primaryColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: theme.primaryColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2.0),
                ),
                filled: false,
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
