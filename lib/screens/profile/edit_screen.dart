import 'package:demo_messenger/providers/profile_provider.dart';
import 'package:demo_messenger/widgets/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);
    final TextEditingController nameController = TextEditingController(text: user.username);
    final TextEditingController phoneController = TextEditingController(text: user.phoneNumber);
    final TextEditingController emailController = TextEditingController(text: user.email);
    final TextEditingController birthdayController = TextEditingController(
      text: user.birthdate != null ? DateFormat('dd/MM/yyyy').format(user.birthdate!) : '',
    );

    // Focus nodes for each field
    final nameFocusNode = FocusNode();
    final phoneFocusNode = FocusNode();
    final emailFocusNode = FocusNode();
    final birthdayFocusNode = FocusNode();

    return Container(
      color: Colors.black.withAlpha(128),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C2C2C),
                  ),
                ),

                const SizedBox(height: 24),

                // Name Field
                CustomTextForm(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  paddingValue: 16,
                  focusNode: nameFocusNode,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => phoneFocusNode.unfocus(),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4,),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 1.0,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 16,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              image: DecorationImage(
                                image: AssetImage('assets/icons/flag.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: Color(0xFF666666),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            '(+91)',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              focusNode: phoneFocusNode,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) => emailFocusNode.unfocus(),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '20 1234 5629',
                                hintStyle: TextStyle(
                                  color: Color(0xFF666666),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2C2C2C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Gender Dropdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 1.0,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.gender ?? 'Not specified',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2C2C2C),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Color(0xFF666666),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                // Birthday Field
                CustomTextForm(
                  labelText: 'Birthday',
                  hintText: '12/01/1997',
                  icon: Icons.calendar_today,
                  keyboardType: TextInputType.datetime,
                  obscureText: false,
                  paddingValue: 16,
                  focusNode: birthdayFocusNode,
                  controller: birthdayController,
                  textInputAction: TextInputAction.next,
                  onSubmitted: () => emailFocusNode.unfocus(),
                ),

                // Email Field
                CustomTextForm(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  paddingValue: 32,
                  focusNode: emailFocusNode,
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: () => emailFocusNode.unfocus(),
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          ref.read(isEditingProvider.notifier).state = false;
                          nameController.dispose();
                          phoneController.dispose();
                          emailController.dispose();
                          birthdayController.dispose();
                          nameFocusNode.dispose();
                          phoneFocusNode.dispose();
                          emailFocusNode.dispose();
                          birthdayFocusNode.dispose();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade50,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          DateTime? parsedDate;
                          try {
                            parsedDate = DateFormat('dd/MM/yyyy').parse(birthdayController.text);
                          } catch (e) {
                            // Handle invalid date format if needed
                          }
                          ref.read(profileProvider.notifier).updateProfile(
                            username: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            birthdate: parsedDate,
                            gender: user.gender, // Update this if gender changes
                          );
                          ref.read(isEditingProvider.notifier).state = false;
                          nameController.dispose();
                          phoneController.dispose();
                          emailController.dispose();
                          birthdayController.dispose();
                          nameFocusNode.dispose();
                          phoneFocusNode.dispose();
                          emailFocusNode.dispose();
                          birthdayFocusNode.dispose();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}