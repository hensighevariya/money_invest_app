import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:ui_components/ui_components.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key, required this.onPressed, this.color})
    : _isFilled = false;

  const BackIconButton.filled({super.key, this.onPressed, this.color})
    : _isFilled = true;

  final VoidCallback? onPressed;
  final Color? color;
  final bool _isFilled;

  @override
  Widget build(BuildContext context) {
    ButtonStyle? buttonStyle;
    if (_isFilled) {
      final colorScheme = context.colorScheme;
      buttonStyle = IconButton.styleFrom(
        backgroundColor: colorScheme.surfaceContainerHigh.withValues(
          alpha: 0.75,
        ),
        foregroundColor: colorScheme.onSurface,
      );
    }

    return IconButton(
      style: buttonStyle,
      color: color,
      padding: const EdgeInsets.all(Spacing.medium),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: onPressed,
      icon: const SvgIcon(SvgIcons.arrowLeft),
    );
  }
}

class ToolbarActionButton extends StatelessWidget {
  const ToolbarActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.tooltip,
  }) : _isFilled = false;

  const ToolbarActionButton.filled({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.tooltip,
  }) : _isFilled = true;

  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? tooltip;
  final bool _isFilled;

  @override
  Widget build(BuildContext context) {
    ButtonStyle? buttonStyle;
    if (_isFilled) {
      final colorScheme = context.colorScheme;
      buttonStyle = IconButton.styleFrom(
        backgroundColor: colorScheme.surfaceContainerHigh.withValues(
          alpha: 0.75,
        ),
        foregroundColor: colorScheme.onSurfaceVariant,
      );
    }

    return IconButton(
      style: buttonStyle,
      color: color,
      padding: const EdgeInsets.all(Spacing.medium),
      tooltip: tooltip,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
