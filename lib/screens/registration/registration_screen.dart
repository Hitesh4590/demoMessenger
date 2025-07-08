import 'package:demo_messenger/screens/profile/profile_screen.dart';
import 'package:demo_messenger/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:demo_messenger/widgets/custom_text_form.dart';
import 'package:demo_messenger/widgets/profileavatar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:demo_messenger/widgets/gender_widget.dart';
import 'package:demo_messenger/services/register_service.dart';
import 'package:demo_messenger/models/register_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/curved_bottom_container_widget.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final usernameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final phoneFocus = FocusNode();

  double _completionProgress = 0.0;
  Gender? _selectedGender;
  DateTime? _selectedBirthdate;
  String? _selectedImagePath;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  void _updateCompletionProgress() {
    int completed = 0;
    if (phoneNumberController.text.trim().isNotEmpty) completed++;
    if (usernameController.text.trim().isNotEmpty) completed++;
    if (emailController.text.trim().isNotEmpty) completed++;
    if (passwordController.text.trim().isNotEmpty) completed++;
    if (confirmPasswordController.text.trim().isNotEmpty) completed++;
    if (_selectedGender != null) completed++;
    if (_selectedBirthdate != null) completed++;
    if (_selectedImagePath != null && _selectedImagePath!.isNotEmpty) completed++;

    setState(() {
      _completionProgress = completed / 8;
    });
  }

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_updateCompletionProgress);
    emailController.addListener(_updateCompletionProgress);
    passwordController.addListener(_updateCompletionProgress);
    confirmPasswordController.addListener(_updateCompletionProgress);
    phoneNumberController.addListener(_updateCompletionProgress);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    usernameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImagePath = pickedFile.path;
          _updateCompletionProgress();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final password = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your gender')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final userModel = UserModel(
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          gender: _selectedGender.toString().split('.').last,
          birthdate: _selectedBirthdate,
          profileImageUrl: null, // Will be set in FirebaseService
        );

        final firebaseService = RegisterService();
        await firebaseService.registerUser(userModel, password, _selectedImagePath);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registered successfully')),
          );
          navigateAndRemoveUntil(context, AppRoute.login);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  String? _validatePhonenumber(String? value){
      if (value == null || value.trim().isEmpty) {
        return 'Phone number is required';
      }
      if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
        return 'Enter a valid 10-digit phone number';
      }
      return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Stack(
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(
                                begin: isKeyboardOpen ? 0 : 30,
                                end: isKeyboardOpen ? 0 : 30,
                              ),
                              duration: const Duration(milliseconds: 300),
                              builder: (context, curveValue, child) {
                                return CurvedBottomContainer(
                                  height: 200,
                                  color: Colors.lightBlue.shade100,
                                  curveDepth: curveValue,
                                );
                              },
                            ),
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(
                                begin: isKeyboardOpen ? 0 : 30,
                                end: isKeyboardOpen ? 0 : 30,
                              ),
                              duration: const Duration(milliseconds: 300),
                              builder: (context, curveValue, child) {
                                return CurvedBottomContainer(
                                  height: 150,
                                  color: Colors.lightBlue,
                                  curveDepth: curveValue,
                                );
                              },
                            ),
                          ],
                        ),
                        Positioned(
                          top: 80,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                ProfileAvatar(
                                  imagePath: _selectedImagePath ?? 'assets/images/profile.png',
                                  radius: 50,
                                  isFile: _selectedImagePath != null,
                                  backgroundColor: Colors.grey.shade200,
                                  onImageSelected: (String? imagePath) {
                                    setState(() {
                                      _selectedImagePath = imagePath;
                                      _updateCompletionProgress();
                                    });
                                  },
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextForm(
                            labelText: "Phone Number",
                            hintText: "Enter your phone number",
                            icon: Icons.phone,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            obscureText: false,
                            paddingValue: 16,
                            controller: phoneNumberController,
                            focusNode: phoneFocus,
                            validator: _validatePhonenumber,
                            onSubmitted: () {
                              FocusScope.of(context).requestFocus(usernameFocus);
                            },
                          ),
                          CustomTextForm(
                            labelText: "Username",
                            hintText: "Enter your username",
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            paddingValue: 16,
                            controller: usernameController,
                            focusNode: usernameFocus,
                            validator: _validateUsername,
                            onSubmitted: () {
                              FocusScope.of(context).requestFocus(emailFocus);
                            },
                          ),
                          CustomTextForm(
                            labelText: "Email",
                            hintText: "Enter your email",
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            paddingValue: 16,
                            controller: emailController,
                            focusNode: emailFocus,
                            validator: _validateEmail,
                            onSubmitted: () {
                              FocusScope.of(context).requestFocus(passwordFocus);
                            },
                          ),
                          CustomTextForm(
                            labelText: "Password",
                            hintText: "Enter your password",
                            icon: Icons.lock,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            paddingValue: 16,
                            controller: passwordController,
                            focusNode: passwordFocus,
                            validator: _validatePassword,
                            onSubmitted: () {
                              FocusScope.of(context).requestFocus(confirmPasswordFocus);
                            },
                          ),
                          CustomTextForm(
                            labelText: "Confirm Password",
                            hintText: "Confirm your password",
                            icon: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            paddingValue: 32,
                            controller: confirmPasswordController,
                            focusNode: confirmPasswordFocus,
                            validator: _validatePassword,
                            onSubmitted: () {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _selectedBirthdate = picked;
                                  _updateCompletionProgress();
                                });
                              }
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Birthdate',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedBirthdate != null
                                        ? "${_selectedBirthdate!.day}/${_selectedBirthdate!.month}/${_selectedBirthdate!.year}"
                                        : "Select your birthdate",
                                    style: TextStyle(
                                      color: _selectedBirthdate != null ? Colors.black87 : Colors.grey,
                                    ),
                                  ),
                                  const Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GenderDropdown(
                            selectedGender: _selectedGender,
                            onChanged: (gender) {
                              setState(() {
                                _selectedGender = gender;
                                _updateCompletionProgress();
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(
                                begin: 0,
                                end: _completionProgress,
                              ),
                              duration: const Duration(milliseconds: 500),
                              builder: (context, value, child) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 5,
                                        backgroundColor: Colors.lightBlue.shade100,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          value == 1.0
                                              ? Colors.blue.shade900
                                              : Colors.lightBlue,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: (value == 1.0 && !_isLoading)
                                          ? _handleRegister
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(16),
                                        backgroundColor: value == 1.0
                                            ? Colors.blue.shade400
                                            : Colors.lightBlue.shade100,
                                        foregroundColor: Colors.white,
                                        elevation: 4,
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                          : const Icon(Icons.arrow_forward),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}