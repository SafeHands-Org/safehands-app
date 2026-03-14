import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/routes/app_router.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final authController = AuthController(authService)..restoreSession();

  final router = createRouter(authController);

  runApp(
    ChangeNotifierProvider.value(
      value: authController,
      child: SafeHandsApp(router: router),
    ),
  );
}

class SafeHandsApp extends StatelessWidget {
  final GoRouter router;

  const SafeHandsApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SafeHands',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}