import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/register_model.dart';
import '../services/register_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Define ProfileNotifier to manage UserModel state
class ProfileNotifier extends StateNotifier<UserModel> {
  final RegisterService _registerService = RegisterService();

  ProfileNotifier()
      : super(UserModel(
    username: 'Guest',
    email: '',
    phoneNumber: '',
  )) {
    _loadUserData();
  }

  // Load user data from Firestore
  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        state = UserModel.fromJson(doc.data()!);
      } else {
        state = UserModel(
          username: user.displayName ?? 'Unknown',
          email: user.email ?? '',
          phoneNumber: user.phoneNumber ?? '',
          profileImageUrl: user.photoURL,
        );
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  // Update user profile in Firestore
  Future<void> updateProfile({
    required String username,
    required String email,
    required String phoneNumber,
    String? gender,
    DateTime? birthdate,
    String? imagePath,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user signed in');
    }

    try {
      // Check if username is taken (excluding current user)
      if (username != state.username) {
        if (await _registerService.isUsernameTaken(username)) {
          throw Exception('The username is already taken');
        }
      }

      // Upload profile image if provided
      String? profileImageUrl = state.profileImageUrl;
      if (imagePath != null && imagePath.isNotEmpty) {
        profileImageUrl = await _registerService.uploadProfileImage(user.uid, imagePath);
      }

      // Update Firebase Authentication profile
      await user.updateDisplayName(username);
      await user.verifyBeforeUpdateEmail(email);

      // Update Firestore document
      final updatedUser = UserModel(
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        birthdate: birthdate,
        profileImageUrl: profileImageUrl,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(updatedUser.toJson());

      state = updatedUser;
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }
}

// Providers
final profileProvider = StateNotifierProvider<ProfileNotifier, UserModel>(
        (ref) => ProfileNotifier());

final isEditingProvider = StateProvider<bool>((ref) => false);