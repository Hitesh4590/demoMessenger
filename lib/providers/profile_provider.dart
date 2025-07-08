import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/register_model.dart';

// Define ProfileNotifier to manage UserModel state
class ProfileNotifier extends StateNotifier<UserModel> {
  ProfileNotifier()
      : super(UserModel(
    username: 'John Lennon',
    email: 'john.lennon@mail.com',
    phoneNumber: '20 1234 5629',
    gender: 'Male',
    birthdate: DateTime(1997, 1, 12),
    profileImageUrl: 'assets/images/profile.png',
  ));

  void setEditing(bool isEditing) {
    state = state.copyWith();
  }

  void updateProfile({
    String? username,
    String? email,
    String? phoneNumber,
    String? gender,
    DateTime? birthdate,
    String? profileImageUrl,
  }) {
    state = state.copyWith(
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      birthdate: birthdate,
      profileImageUrl: profileImageUrl,
    );
  }
}


// Create a provider for ProfileNotifier
final profileProvider = StateNotifierProvider<ProfileNotifier, UserModel>((ref) {
  return ProfileNotifier();
});

// Provider to manage editing state separately
final isEditingProvider = StateProvider<bool>((ref) => false);