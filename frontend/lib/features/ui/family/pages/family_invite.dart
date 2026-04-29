import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/family/family_providers.dart';
import 'package:frontend/models/models.dart';

class InviteView extends ConsumerWidget {
  const InviteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteAsync = ref.watch(invitationsProvider);

    return Scaffold(
      body: switch (inviteAsync) {
        AsyncLoading() => const Scaffold(body: LoadingCard()),
        AsyncError(:final error) => Scaffold(body: ErrorCard(message: error.toString())),
        AsyncData(:final value) => FamilyInviteView(invite: value)
      },
    );
  }
}

class FamilyInviteView extends ConsumerWidget {
  const FamilyInviteView({super.key, required this.invite});

  final Invitation invite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final String code = invite.token;

    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(),
        gradient: context.palette.header,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Share this invite code with people to join your family group",
                        style: tt.labelLarge?.copyWith(
                          color: cs.onInverseSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(child: codeChip(value: code[0])),
                          Expanded(child: codeChip(value: code[1])),
                          Expanded(child: codeChip(value: code[2])),
                          SizedBox(
                            width: 20,
                            child: Text(
                              '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                          ),
                          Expanded(child: codeChip(value: code[3])),
                          Expanded(child: codeChip(value: code[4])),
                          Expanded(child: codeChip(value: code[5])),
                        ],
                      ),
                      SizedBox(height: 35),
                      SizedBox(
                        height: 60,
                        width: 110,
                        child: TextButton.icon(
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: code),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Copied to clipboard")),
                            );
                          },
                          icon: Icon(
                            Icons.copy_outlined,
                            color: cs.onInverseSurface,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: cs.onInverseSurface.withValues(
                              alpha: 0.2,
                            ),
                            side: BorderSide(
                              color: cs.onInverseSurface.withValues(alpha: 0.2),
                            ),
                          ),
                          label: Text(
                            'Copy',
                            style: tt.bodyLarge?.copyWith(
                              color: cs.onInverseSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget codeChip({required String value}){
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 3, right: 3),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white, height: 1.1),
      ),
    );
  }
}