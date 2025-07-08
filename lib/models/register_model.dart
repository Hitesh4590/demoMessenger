import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String phoneNumber;
  final String? gender;
  final DateTime? birthdate;
  final String? profileImageUrl;

  UserModel({
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.gender,
    this.birthdate,
    this.profileImageUrl,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? phoneNumber,
    String? gender,
    DateTime? birthdate,
    String? profileImageUrl,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  //converting the user model to json for the use in the firestore
  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'phoneNumber': phoneNumber,
    'gender': gender,
    'birthdate': birthdate != null ? Timestamp.fromDate(birthdate!) : null,
    'profileImageUrl': profileImageUrl,
  };

  // Create UserModel from Firestore document
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json['username'] ?? 'Unknown',
    email: json['email'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    gender: json['gender'],
    birthdate: json['birthdate'] != null
        ? (json['birthdate'] as Timestamp).toDate()
        : null,
    profileImageUrl: json['profileImageUrl'],
  );

}
