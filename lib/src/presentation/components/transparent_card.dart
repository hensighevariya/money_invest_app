import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';

class TransparentCard extends StatelessWidget {
  const TransparentCard({
    super.key,
    required this.child,
    this.clipBehavior,
    this.shape,
  });

  final Widget child;
  final Clip? clipBehavior;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Card(
      elevation: 0,
      shape: shape,
      clipBehavior: clipBehavior,
      color: colorScheme.inverseSurface.withValues(alpha: 0.075),
      child: child,
    );
  }
}
