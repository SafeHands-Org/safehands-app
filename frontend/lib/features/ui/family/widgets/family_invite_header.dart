import 'package:flutter/material.dart';
import 'package:frontend/features/components/styles/styles.dart';
import 'package:go_router/go_router.dart';

class InviteHeader extends StatelessWidget {
  final double minHeight = 100;

  const InviteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: context.palette.header),
      child: SafeArea(
        bottom: false,
        child: _ToolBar(
          ctxHeight: 48.0,
          leading: const Icon(Icons.arrow_back),
          leadingCallback: () => context.pop(),
        ),
      ),
    );
  }
}

class _ToolBar extends StatelessWidget {
  const _ToolBar({
    required this.ctxHeight,
    required this.leading,
    required this.leadingCallback,
  });

  final double ctxHeight;
  final Widget leading;
  final VoidCallback leadingCallback;

  @override
  Widget build(BuildContext context) {
    final cs = ColorScheme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: ctxHeight,
        maxHeight: ctxHeight
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            color: cs.surface,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: leading,
            onPressed: leadingCallback
          ),
        ],
      )
    );
  }
}