import 'package:demo_messenger/screens/chat/chat_screen.dart';
import 'package:demo_messenger/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Manually set user IDs for testing on two devices
    const bool isDevice1 = false; // Set to false for the second device
    const String user1Id = 'user1';
    const String user2Id = 'user2';
    final String currentUserId = isDevice1 ? user1Id : user2Id;
    final String receiverId = isDevice1 ? user2Id : user1Id;

    return MaterialApp(
      title: 'Chat Messenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChatScreen(currentUserId: currentUserId, receiverId: receiverId),
    );
  }
}