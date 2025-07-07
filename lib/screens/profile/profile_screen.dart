import 'package:demo_messenger/widgets/action_btn_widget.dart';
import 'package:demo_messenger/widgets/displaytext_widget.dart';
import 'package:flutter/material.dart';
import 'package:demo_messenger/widgets/profileavatar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _selectedImagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        ProfileAvatar(
                          imagePath:
                              _selectedImagePath ?? 'assets/images/profile.png',
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
                    const SizedBox(height: 24,),
                    //Name
                    Text("First name", style: const TextStyle(
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
                      // value: '(+44) ${user.phoneNumber}',
                      value: '+91 783748784',
                    ),
                    DisplayText(
                      label: 'Gender',
                      // value: user.gender ?? 'Not specified',
                      value: 'male',
                    ),
                    DisplayText(
                      label: 'Birthday',
                      // value: user.birthdate != null
                      //     ? DateFormat('dd/MM/yyyy').format(user.birthdate!)
                      //     : 'Not specified',
                      value: 'Dob',
                    ),
                    DisplayText(
                      label: 'Email',
                      // value: user.email,
                      value: "ak@gmail.com",
                    ),
                    const SizedBox(height: 32),

                    // Edit Profile Button
                    ProfileActionButton(
                      label: 'Edit Profile',
                      icon: Icons.edit,
                      onPressed: () {

                      },
                      backgroundColor: Colors.lightBlue.shade500,
                      foregroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    ProfileActionButton(label: 'Logout', onPressed: () {

                    },
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
