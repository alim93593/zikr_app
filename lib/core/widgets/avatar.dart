import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final double radius;

  const Avatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
      );
    }
    final colorScheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primary.withAlpha((0.12 * 255).round()),
      child: Text(
        initials,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
      ),
    );
  }
}
