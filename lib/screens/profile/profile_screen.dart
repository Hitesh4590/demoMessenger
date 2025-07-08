import 'package:demo_messenger/models/register_model.dart';
import 'package:demo_messenger/providers/profile_provider.dart';
import 'package:demo_messenger/screens/profile/edit_screen.dart';
import 'package:demo_messenger/widgets/action_btn_widget.dart';
import 'package:demo_messenger/widgets/displaytext_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _selectedImagePath;

  Widget _buildProfileImage() {
    final user = ref.watch(profileProvider);

    // Priority: Selected image > Network image > Default asset
    if (_selectedImagePath != null) {
      return Image.asset(
        _selectedImagePath!,
        fit: BoxFit.cover,
        width: 100,
        height: 100,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultAvatar();
        },
      );
    } else if (user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty) {
      // Check if it's a network URL
      if (user.profileImageUrl!.startsWith('http')) {
        return Image.network(
          user.profileImageUrl!,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultAvatar();
          },
        );
      } else {
        // It's an asset path
        return Image.asset(
          user.profileImageUrl!,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
          errorBuilder: (context, error, stackTrace) {
            return _buildDefaultAvatar();
          },
        );
      }
    } else {
      return _buildDefaultAvatar();
    }
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.lightBlue.shade100,
      child: const Icon(
        Icons.person,
        size: 50,
        color: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(isEditingProvider);
    final user = ref.watch(profileProvider);
    final userAuth = FirebaseAuth.instance.currentUser;

    // Check if user is authenticated
    if (userAuth == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Text(
              'Please sign in to view your profile',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ),
        ),
      );
    }

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
                        GestureDetector(
                          onTap: () {
                            // Handle image selection if needed
                            // You can implement image picker here
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.lightBlue.shade100,
                              border: Border.all(
                                color: Colors.blue.shade200,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: _buildProfileImage(),
                            ),
                          ),
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
                      value: user.phoneNumber.isNotEmpty
                          ? '(+44) ${user.phoneNumber}'
                          : 'Not specified',
                    ),
                    DisplayText(
                      label: 'Gender',
                      value: user.gender ?? 'Not specified',
                    ),
                    DisplayText(
                      label: 'Birthday',
                      value: user.birthdate != null
                          ? DateFormat('dd/MM/yyyy').format(user.birthdate!)
                          : 'Not specified',
                    ),
                    DisplayText(
                      label: 'Email',
                      value: user.email.isNotEmpty ? user.email : 'Not specified',
                    ),
                    const SizedBox(height: 2),

                    // Edit Profile Button
                    ProfileActionButton(
                      label: 'Edit Profile',
                      icon: Icons.edit,
                      onPressed: () {
                        ref.read(isEditingProvider.notifier).state = true;
                      },
                      foregroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    ProfileActionButton(
                      label: 'Logout',
                      onPressed: () async {
                        // Sign out from Firebase
                        await FirebaseAuth.instance.signOut();

                        // Reset profile state to default values
                        ref.read(profileProvider.notifier).state = UserModel(
                          username: 'Guest',
                          email: '',
                          phoneNumber: '',
                        );

                        // Navigate to login screen or show appropriate message
                        if (context.mounted) {
                          // You can add navigation logic here if needed
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Logged out successfully'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
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