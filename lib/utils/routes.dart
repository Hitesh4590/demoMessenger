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
  register('/register');

  final String path;
  const AppRoute(this.path);
}

// Define named routes for the app
Map<String, WidgetBuilder> appRoutes = {
  AppRoute.home.path: (context) => Placeholder(),
  AppRoute.details.path: (context) => Placeholder(),
  AppRoute.settings.path: (context) => Placeholder(),
  AppRoute.login.path: (context) => LoginScreen(),
  AppRoute.unlockView.path: (context) => UnlockView(),
  AppRoute.splashScreen.path: (context) => SplashScreen(),
  AppRoute.register.path: (context) => RegistrationScreen(),
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