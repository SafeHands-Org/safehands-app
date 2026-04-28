import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.name,
    this.radius = 28,
  });

  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: cs.secondaryContainer,
      child: Text(
        UserAvatar._initials(name),
        style: TextStyle(
          fontSize: radius * 0.45,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  static String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

class FamilyAvatar extends StatelessWidget {
  const FamilyAvatar({
    super.key,
    this.radius = 30,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: cs.outlineVariant,
        child: Icon(
          Icons.groups_2,
          size: 50,
          color: Colors.grey[600],
        )
      ),
    );
  }
}

class StackAvatar extends StatelessWidget {
  const StackAvatar({
    super.key,
    this.radius = 28,
    required this.name
  });

  final double radius;
  final String name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: colorScheme.secondaryContainer,
        child: Text(
          UserAvatar._initials(name),
          style: TextStyle(
            fontSize: radius * 0.25,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

class AvatarStack extends StatelessWidget {
  const AvatarStack({
    super.key,
    required this.names
  });

  final List<String> names;
  final int overflow = 2;
  final double size = 40;

  @override
  Widget build(BuildContext context) {
    const overlap = 30.0;
    final count = names.length + (overflow > 0 ? 1 : 0);
    final width = size + (count - 3) * (size - overlap);
    return SizedBox(
      width: width,
      height: size,
      child: Stack(alignment:AlignmentGeometry.center, children: [
        for (var i = 0; i < names.length; i++)
          Positioned(
            left: i * (size - overlap),
            child: StackAvatar(name: names[i], radius: size),
          ),
        ],
      ),
    );
  }
}