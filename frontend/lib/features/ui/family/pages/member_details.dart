import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/state_widget.dart';
import 'package:frontend/features/providers/providers.dart';
import 'package:frontend/features/ui/family/widgets/member_section.dart';

class MemberView extends ConsumerWidget {
  const MemberView({super.key, required this.fmid});

  final String fmid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(aggregateMemberProvider(fmid));

    return switch (familyAsync) {
      AsyncLoading() => const TemplateStatePage(body: LoadingCard()),
      AsyncError() => TemplateStatePage(body: ErrorBody(callback: () async => ref.refresh(aggregateMemberProvider(fmid)))),
      AsyncData(:final value) => MemberProfileSection(member: value),
    };
  }
}