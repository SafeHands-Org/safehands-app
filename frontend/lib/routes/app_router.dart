import 'package:flutter/material.dart';
import '../features/auth/pages/auth_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AuthPage.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AuthPage(),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
        );
    }
  }
}