import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

class BlurredDialog extends StatelessWidget {
  const BlurredDialog({super.key, required this.child, this.alignment, this.insetPadding});

  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsets? insetPadding;

  @override
  Widget build(BuildContext context) {
    final dialogTheme = DialogTheme.of(context);
    return Dialog(
      alignment: alignment,
      insetPadding: insetPadding,
      backgroundColor: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.none,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Material(
          color: dialogTheme.backgroundColor?.withValues(alpha: 0.8),
          shape: dialogTheme.shape,
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(constraints: LayoutConstraints.modalDialog, child: child),
        ),
      ),
    );
  }
}
