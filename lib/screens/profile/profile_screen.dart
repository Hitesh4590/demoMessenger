import 'package:demo_messenger/providers/profile_provider.dart';
import 'package:demo_messenger/screens/profile/edit_screen.dart';
import 'package:demo_messenger/widgets/action_btn_widget.dart';
import 'package:demo_messenger/widgets/displaytext_widget.dart';
import 'package:flutter/material.dart';
import 'package:demo_messenger/widgets/profileavatar_widget.dart';
import 'package:demo_messenger/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _selectedImagePath;
  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(isEditingProvider);
    final user = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isEditing
            ? EditProfileScreen()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 40),
                          Stack(
                            children: [
                              //profile image
                              ProfileAvatar(
                                imagePath: user.profileImageUrl ?? (_selectedImagePath ?? 'assets/images/profile.png'),
                                radius: 50,
                                isFile: _selectedImagePath != null,
                                backgroundColor: Colors.lightBlue.shade100,
                                onImageSelected: (String? imagePath) {
                                  setState(() {
                                    _selectedImagePath = imagePath;
                                  });
                                },
                              ),
                              Positioned(
                                bottom: 3,
                                right: 6,
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
                          const SizedBox(height: 24),
                          //Name
                          Text(
                            (user.username.isNotEmpty)
                                ? user.username
                                : "First name",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                          const SizedBox(height: 32),

                          //profile details of the user
                          //phone
                          DisplayText(
                            label: 'Phone',
                            value: '(+44) ${user.phoneNumber}',
                          ),
                          DisplayText(
                            label: 'Gender',
                            value: user.gender ?? 'Not specified',
                            // value: 'male',
                          ),
                          DisplayText(
                            label: 'Birthday',
                            value: user.birthdate != null
                                ? DateFormat('dd/MM/yyyy').format(user.birthdate!)
                                : 'Not specified',
                            // value: 'Dob',
                          ),
                          DisplayText(
                            label: 'Email',
                            value: user.email,
                            // value: "ak@gmail.com",
                          ),
                          const SizedBox(height: 2),

                          // Edit Profile Button
                          ProfileActionButton(
                            label: 'Edit Profile',
                            icon: Icons.edit,
                            onPressed: () {
                              ref.read(isEditingProvider.notifier).state = true;
                            },
                            // backgroundColor: CustomColors.getColor(context, AppColor.success),
                            foregroundColor: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          ProfileActionButton(
                            label: 'Logout',
                            onPressed: () {},
                            icon: Icons.logout,
                            backgroundColor: const Color(0xFFFFEBEE),
                            foregroundColor: const Color(0xFFE57373),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
