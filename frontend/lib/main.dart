import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/app/app_providers.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/routes/app_router.dart';
import 'package:frontend/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  runApp(ProviderScope(child: const SafeHandsApp()));
}

class SafeHandsApp extends ConsumerWidget {
  const SafeHandsApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return _AppStartup(
      child: MaterialApp.router(
        title: 'SafeHands',
        theme: AppTheme.light(),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _AppStartup extends ConsumerWidget {
  const _AppStartup({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(remoteStartupProvider);

    return child;
  }
}

