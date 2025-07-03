import 'package:demo_messenger/widgets/profileavatar_widget.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 126,
                        width: double.infinity,
                        color: Colors.lightBlue,
                      ),
                      Container(
                        height: 54,
                        width: double.infinity,
                        color: Colors.lightBlue.shade100,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 76, // 126 - radius (for vertical center overlap)
                    child: const ProfileAvatar(
                      imagePath: 'assets/images/profile.png',
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 10,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                
              ),
            ),

          ],
        ),
      )
    );
  }
}
