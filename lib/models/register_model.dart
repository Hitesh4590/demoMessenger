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


}