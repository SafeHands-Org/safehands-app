import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/components/shared/avatar_profile.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:frontend/features/providers/utils/collection_providers.dart';
import 'package:go_router/go_router.dart';

class FamilyOverviewHeader extends ConsumerWidget {
  const FamilyOverviewHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(aggregateFamilyProvider);
    final cs = Theme.of(context).colorScheme;
    final familyName = familyAsync.maybeWhen(
      data: (fc) => fc.family.name,
      orElse: () => 'Your Family',
    );

    final memberCount = familyAsync.maybeWhen(
      data: (fc) => '${fc.totalMembers}',
      orElse: () => '--',
    );

    List<String> memberNames = <String>[];

    familyAsync.maybeWhen(
      data: (fc) => memberNames = fc.members.map((v) => v.name).toList(),
      orElse: () => memberNames = <String>[],
    );

    final activeMeds = familyAsync.maybeWhen(
      data: (fc) => '${fc.activeMeds}',
      orElse: () => '--',
    );

    final fid = familyAsync.maybeWhen(
      data: (fc) => fc.family.id,
      orElse: () => '--',
    );
    //final adherencePct = familyAsync.maybeWhen(
    //  data: (fc) => '${fc.adherencePercentage}%',
    //  orElse: () => '--',
    //);

    return Container(
      decoration: BoxDecoration(gradient: context.palette.header),
      height: 215,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ToolBar(
              ctxHeight: 48.0,
              headerBody: Row(
                children: [
                  FamilyAvatar(radius: 40),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(familyName,
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        AvatarStack(names: memberNames),
                        Text("$memberCount members • $activeMeds medications",
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              leading: BackButton(
                color: cs.onInverseSurface,
                onPressed: () => context.canPop() ? context.pop() : context.go('/')
              ),
              trailing: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(Icons.edit_square, color: cs.onInverseSurface),
                onPressed: () => context.push('/family/edit/$fid/$familyName'),
              ),
              title: familyName,
            ),
          ],
        ),
      ),
    );
  }
}

class EditFamilyHeader extends ConsumerWidget {
  const EditFamilyHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(aggregateFamilyProvider);
    final cs = Theme.of(context).colorScheme;

    final familyName = familyAsync.maybeWhen(
      data: (fc) => fc.family.name,
      orElse: () => null,
    );

    return Container(
      decoration: BoxDecoration(gradient: context.palette.header),
      height: 215,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ToolBar(
              ctxHeight: 48.0,
              leading: BackButton(
                color: cs.onInverseSurface,
                onPressed: () => context.canPop() ? context.pop() : context.go('/family')
              ),
              title: familyName,
            ),
          ],
        ),
      ),
    );
  }
}

class MemberOverviewHeader extends ConsumerWidget {
  const MemberOverviewHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyAsync = ref.watch(aggregateFamilyProvider);
    final cs = Theme.of(context).colorScheme;
    final familyName = familyAsync.maybeWhen(
      data: (fc) => fc.family.name,
      orElse: () => 'Your Family',
    );

    final memberCount = familyAsync.maybeWhen(
      data: (fc) => '${fc.totalMembers}',
      orElse: () => '--',
    );

    List<String> memberNames = <String>[];

    return Container(
      decoration: BoxDecoration(gradient: context.palette.header),
      height: 215,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ToolBar(
              ctxHeight: 48.0,
              headerBody: Row(
                children: [
                  FamilyAvatar(radius: 40),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(familyName,
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        AvatarStack(names: memberNames),
                        Text("$memberCount members",
                        style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              leading: BackButton(
                color: cs.onInverseSurface,
                onPressed: () => context.canPop() ? context.pop() : context.go('/')
              ),
              title: familyName,
            ),
          ],
        ),
      ),
    );
  }
}


class _ToolBar extends StatelessWidget {
  const _ToolBar({
    this.ctxHeight = 48,
    required this.leading,
    this.trailing,
    this.title,
    this.headerBody
  });

  final double ctxHeight;
  final Widget leading;
  final Widget? trailing;
  final String? title;
  final Widget? headerBody;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    final tt = TextTheme.of(context);
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: ctxHeight,
            maxHeight: ctxHeight
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              leading,
              if (title != null)...[
                Expanded(
                  child: Text(
                    title!,
                    style: tt.titleMedium!.copyWith(color: cs.surface),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              if (trailing != null)...[
                trailing!
              ]
            ],
          )
        ),
        if (headerBody != null)...[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerBody!,
              ],
            )
          ),
        ]
      ]
    );
  }
}