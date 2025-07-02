import 'package:flutter/material.dart';


// Enum for route names
enum AppRoute {
  home('/'),
  details('/details'),
  settings('/settings');

  final String path;
  const AppRoute(this.path);
}

// Define named routes for the app
Map<String, WidgetBuilder> appRoutes = {
  AppRoute.home.path: (context) => Placeholder(),
  AppRoute.details.path: (context) => Placeholder(),
  AppRoute.settings.path: (context) => Placeholder(),
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