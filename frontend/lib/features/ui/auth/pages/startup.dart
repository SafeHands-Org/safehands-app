import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:go_router/go_router.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = context.palette;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: palette.header),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SafeHands',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                          ,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Caring For Every Hand in Your Family',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.white,
                            height: 1.4
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                          onPressed: () => context.push('/auth/login'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cs.surface,
                              shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusLg, side: BorderSide(color: cs.surface)),
                            ),
                            child: Text(
                              'Log In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: cs.primary
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => context.push('/auth/register'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(alpha: 0.1),
                              shape: RoundedRectangleBorder(borderRadius: AppRadius.borderRadiusLg, side: BorderSide(color: cs.surface))
                            ),
                            child: Text(
                              'Create Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

