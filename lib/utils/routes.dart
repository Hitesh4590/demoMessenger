import 'package:demo_messenger/screens/chat/chat_profile_screen.dart';
import 'package:demo_messenger/screens/chat/chat_screen.dart';
import 'package:demo_messenger/screens/home_screen.dart';
import 'package:demo_messenger/screens/login/login_screen.dart';
import 'package:demo_messenger/screens/login/unlock_view.dart';
import 'package:demo_messenger/screens/registration/registration_screen.dart';
import 'package:demo_messenger/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';


// Enum for route names
enum AppRoute {
  home('/'),
  details('/details'),
  settings('/settings'),
  login('/login'),
  unlockView('/unlock'),
  splashScreen('/splash'),
  register('/register'),
  chatScreen('/chatScreen'),
  chatProfileScreen('/chatProfileScreen');

  final String path;
  const AppRoute(this.path);
}

// Manually set user IDs for testing on two devices
const bool isDevice1 = false; // Set to false for the second device
const String user1Id = 'user1';
const String user2Id = 'user2';
final String currentUserId = isDevice1 ? user1Id : user2Id;
final String receiverId = isDevice1 ? user2Id : user1Id;
// Define named routes for the app
Map<String, WidgetBuilder> appRoutes = {
  AppRoute.home.path: (context) => HomeScreen(),
  AppRoute.details.path: (context) => Placeholder(),
  AppRoute.settings.path: (context) => Placeholder(),
  AppRoute.login.path: (context) => LoginScreen(),
  AppRoute.unlockView.path: (context) => UnlockView(),
  AppRoute.splashScreen.path: (context) => SplashScreen(),
  AppRoute.register.path: (context) => RegistrationScreen(),
  AppRoute.chatScreen.path: (context) => ChatScreen(currentUserId: currentUserId, receiverId: receiverId),
  AppRoute.chatProfileScreen.path: (context) => ChatProfileScreen(),
};

// Navigation helper functions
void navigateTo(BuildContext context, AppRoute route, {Object? arguments}) {
  Navigator.pushNamed(context, route.path, arguments: arguments);
}

void navigateAndReplace(BuildContext context, AppRoute route, {Object? arguments}) {
  Navigator.pushReplacementNamed(context, route.path, arguments: arguments);
}

void navigateAndRemoveUntil(BuildContext context, AppRoute route, {Object? arguments}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route.path,
        (Route<dynamic> route) => false,
    arguments: arguments,
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}