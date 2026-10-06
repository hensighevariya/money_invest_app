import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class CommonCircularIcon extends StatelessWidget {
  final String? icon;
  final double? iconSize;
  final double? dimension;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;

  const CommonCircularIcon({
    super.key,
    this.icon,
    this.dimension,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.borderColor,
    this.borderRadius,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: dimension ?? 44,
        width: dimension ?? 44,
        decoration: BoxDecoration(
          color: backgroundColor ?? colorScheme.onPrimary,
          borderRadius: borderRadius ?? ShapeBorderRadius.xxxLarge,
          border: Border.all(
            color:
                borderColor ?? colorScheme.onSurfaceVariant.applyOpacity(0.35),
          ),
        ),
        alignment: Alignment.center,
        child: SvgImageFromAsset.square(
          icon ?? SvgIcons.icnPerson,
          color: foregroundColor ?? colorScheme.primary,
          size: iconSize ?? 24,
        ),
      ),
    );
  }
}
