import 'package:demo_messenger/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../providers/login_provider.dart';

class UnlockView extends ConsumerStatefulWidget {
  const UnlockView({super.key});

  @override
  ConsumerState<UnlockView> createState() => _UnlockViewState();
}

class _UnlockViewState extends ConsumerState<UnlockView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !ref.read(authStateProvider).isAuthenticating) {
        _startAuth();
      }
    });
  }

  Future<void> _startAuth() async {
    final auth = ref.read(localAuthProvider);

    try {
      final canUseBiometrics = await auth.canCheckBiometrics;
      final isSupported = await auth.isDeviceSupported();

      if (!canUseBiometrics && !isSupported) {
        ref.read(authStateProvider.notifier).state = AuthState(
          message: 'Biometric authentication not available',
          isAuthenticating: false,
        );
        return;
      }

      ref.read(authStateProvider.notifier).state = AuthState(
        message: 'Authenticating...',
        isAuthenticating: true,
      );

      final authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      ref.read(authStateProvider.notifier).state = AuthState(
        message: authenticated ? 'Authenticated!' : 'Authentication failed',
        isAuthenticating: false,
      );

      if (authenticated && mounted) {
        navigateAndReplace(context, AppRoute.home);
      }
    } catch (e) {
      ref.read(authStateProvider.notifier).state = AuthState(
        message: 'Error: $e',
        isAuthenticating: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Unlock App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              authState.message,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: authState.isAuthenticating ? null : _startAuth,
              child: const Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}
