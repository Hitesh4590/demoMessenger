import 'package:demo_messenger/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constants.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 126,
                        width: double.infinity,
                        color: Colors.lightBlue,
                      ),
                      Container(
                        height: 54,
                        width: double.infinity,
                        color: Colors.lightBlue.shade100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  CustomTextForm(
                    labelText: Messages.emailHint,
                    hintText: Messages.emailLabel,
                    icon: Icons.mail,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    paddingValue: 16,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                  ),
                  CustomTextForm(
                    labelText: Messages.passwordLabel,
                    hintText: Messages.passwordHint,
                    icon: Icons.lock,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    paddingValue: 16,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: theme.primaryColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: const Text(
                        Messages.loginButton,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: RichText(
                        text: TextSpan(
                          text: Messages.loginToSignUpPrompt,
                          style: theme.textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: Messages.loginToSignUpLink,
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
