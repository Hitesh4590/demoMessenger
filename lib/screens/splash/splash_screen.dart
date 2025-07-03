import 'dart:async';
import 'package:demo_messenger/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import '../registration/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(_imagePath),
      ),
    );
  }
}
