import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/app/app_providers.dart';
import 'package:frontend/routes/app_router.dart';

void main() {
  runApp(ProviderScope(child: SafeHandsApp()));

}

class SafeHandsApp extends ConsumerWidget {
  const SafeHandsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return _AppStartup(
      child: MaterialApp.router(
        key: navigatorKey,
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