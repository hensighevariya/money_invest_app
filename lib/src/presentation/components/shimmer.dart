import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmer extends StatelessWidget {
  const CommonShimmer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest,
      highlightColor: Color.alphaBlend(
        colorScheme.inverseSurface.withValues(alpha: 0.1),
        colorScheme.surfaceContainerHighest,
      ),
      child: child,
    );
  }
}

class TextShimmer extends StatelessWidget {
  const TextShimmer({super.key, this.width, this.style, this.textAlign});

  final double? width;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final textScaler = MediaQuery.textScalerOf(context);
    final effectiveStyle = defaultTextStyle.style.merge(style);

    final textHeight = textScaler.scale(effectiveStyle.fontSize ?? 14);
    final lineHeight = textHeight * (effectiveStyle.height ?? 1.2);

    final alignment = switch (defaultTextStyle.textAlign ??
        textAlign ??
        TextAlign.start) {
      TextAlign.left => Alignment.centerLeft,
      TextAlign.right => Alignment.centerRight,
      TextAlign.center => Alignment.center,
      TextAlign.justify => Alignment.center,
      TextAlign.start => AlignmentDirectional.centerStart,
      TextAlign.end => AlignmentDirectional.centerEnd,
    };

    return SizedBox(
      height: lineHeight,
      child: Align(
        alignment: alignment,
        widthFactor: 1.0,
        child: CommonShimmer(
          child: Material(
            borderRadius: ShapeBorderRadius.extraLarge,
            child: SizedBox(
              height: textHeight,
              width: width ?? double.maxFinite,
            ),
          ),
        ),
      ),
    );
  }
}
