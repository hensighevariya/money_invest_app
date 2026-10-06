import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class CommonDivider extends StatelessWidget {
  final Color? color;
  final double? paddingSize;
  final double? indent;
  final double? endIndent;

  const CommonDivider({
    super.key,
    this.color,
    this.paddingSize,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(paddingSize ?? Spacing.large),
        Divider(
          color: context.colorScheme.onSurface.applyOpacity(0.3),
          indent: indent,
          endIndent: endIndent,
        ),
        Gap(paddingSize ?? Spacing.large),
      ],
    );
  }
}

class CommonVerticalDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  const CommonVerticalDivider({
    super.key,
    this.color,
    this.height = 48,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      color: context.colorScheme.onPrimaryContainer.applyOpacity(0.3),
      width: width,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );

    if (height != null) {
      return SizedBox(height: height, child: divider);
    }
    return divider;
  }
}
