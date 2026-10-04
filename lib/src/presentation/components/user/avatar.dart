import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Material(
      type: MaterialType.circle,
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surfaceContainerHighest,
      child: SvgImageFromAsset(
        VectorImages.userPlaceholder,
        color: colorScheme.onSurfaceVariant,
        height: size,
        width: size,
      ),
    );
  }
}
