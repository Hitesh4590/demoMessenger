import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:demo_messenger/models/register_model.dart';
import 'dart:io';

class RegisterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CloudinaryPublic _cloudinary = CloudinaryPublic('duvfpk82p', 'unsigned_upload');

  RegisterService() {
    _firestore.settings = const Settings(persistenceEnabled: true);
  }

  Future<bool> isUsernameTaken(String username) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('username', isEqualTo: username.trim())
          .get();
      return query.docs.isNotEmpty;
    } catch (e) {
      print('Error checking username: $e');
      rethrow;
    }
  }

  Future<String?> _uploadProfileImage(String userId, String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) {
      print('No profile image path provided');
      return null;
    }

    try {
      print('Uploading image to Cloudinary: profile_images/$userId.jpg');
      final file = File(imagePath); // Convert path to File
      if (!await file.exists()) {
        throw Exception('Image file does not exist at path: $imagePath');
      }
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          resourceType: CloudinaryResourceType.Image,
          folder: 'profile_images',
          publicId: userId,
        ),
      );
      final url = response.secureUrl;
      print('Image uploaded successfully: $url');
      return url;
    } catch (e) {
      print('Cloudinary upload error: $e');
      throw Exception('Failed to upload profile image to Cloudinary: $e');
    }
  }

  Future<User?> registerUser(UserModel user, String password, String? imagePath) async {
    try {
      print('Starting user registration for: ${user.email}');
      if (await isUsernameTaken(user.username)) {
        throw FirebaseException(
          plugin: 'auth',
          code: 'username-already-exists',
          message: 'The username is already taken',
        );
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email.trim(),
        password: password.trim(),
      );

      final profileImageUrl = await _uploadProfileImage(userCredential.user!.uid, imagePath);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': user.username.trim(),
        'email': user.email.trim(),
        'phoneNumber': user.phoneNumber.trim(),
        'gender': user.gender,
        'birthdate': user.birthdate != null ? Timestamp.fromDate(user.birthdate!) : null,
        'profileImageUrl': profileImageUrl,
        'createdAt': Timestamp.now(),
      });

      print('User registered successfully: ${userCredential.user!.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Auth error: ${e.code} - ${e.message}');
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  Exception _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return Exception('The email address is already in use');
      case 'invalid-email':
        return Exception('The email address is invalid');
      case 'weak-password':
        return Exception('The password is too weak');
      default:
        return Exception('An error occurred during registration: ${e.message}');
    }
  }
}