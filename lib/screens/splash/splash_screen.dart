import 'dart:async';

import 'package:demo_messenger/utils/routes.dart';
import 'package:demo_messenger/utils/shared_prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  String _imagePath = 'assets/images/splash1.png';

  @override
  void initState() {
    super.initState();

    // Change image after 1 second
    Timer(Duration(seconds: 1), () {
      setState(() {
        _imagePath = 'assets/images/splash2.png';
      });
    });

    // Navigate to RegistrationScreen after 3 seconds
    Timer(Duration(seconds: 3), () async {
      final isFirstLogin = SharedPrefsHelper.getFirstLogin();
      if (context.mounted) {
        navigateAndRemoveUntil(
          context,
          await isFirstLogin ? AppRoute.login : AppRoute.unlockView,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(_imagePath)));
  }
}
