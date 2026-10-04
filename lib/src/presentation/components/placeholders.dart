import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

import 'image.dart';

class StreamPlaceholder extends StatelessWidget {
  const StreamPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Material(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.normal),
        child: Center(
          child: SvgImageFromAsset.square(
            VectorImages.streamPlaceholder,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            size: 84,
          ),
        ),
      ),
    );
  }
}
