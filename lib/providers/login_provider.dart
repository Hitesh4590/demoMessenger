import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

// Provider for LocalAuthentication instance
final localAuthProvider = Provider<LocalAuthentication>((ref) {
  return LocalAuthentication();
});

// Provider for authentication state
final authStateProvider = StateProvider<AuthState>((ref) {
  return AuthState(
    message: 'Please authenticate to proceed',
    isAuthenticating: false,
  );
});

// Data class to hold authentication state
class AuthState {
  final String message;
  final bool isAuthenticating;

  AuthState({required this.message, required this.isAuthenticating});

  AuthState copyWith({String? message, bool? isAuthenticating}) {
    return AuthState(
      message: message ?? this.message,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
    );
  }
}
