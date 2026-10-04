part of '../button.dart';

class OutlinedButtonDefaultStyle extends ButtonStyle {
  const OutlinedButtonDefaultStyle(this.colorScheme);

  final ColorScheme colorScheme;

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape => const WidgetStatePropertyAll(Shapes.normal);

  @override
  WidgetStateProperty<Size?>? get minimumSize => const WidgetStatePropertyAll(LayoutConstants.minimumButtonSize);

  @override
  WidgetStateProperty<Size?>? get maximumSize => const WidgetStatePropertyAll(LayoutConstants.maximumButtonSize);

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: Spacing.normal, horizontal: Spacing.xLarge));

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _OutlinedButtonColor(colorScheme.primary, colorScheme.onSurfaceVariant);

  @override
  WidgetStateProperty<Color?>? get iconColor => _OutlinedButtonColor(colorScheme.primary, colorScheme.onSurfaceVariant);

  @override
  WidgetStateProperty<Color?>? get overlayColor => _ButtonOverlayColor(colorScheme.primary);

  @override
  WidgetStateProperty<BorderSide?>? get side =>
      _OutlinedButtonBorderSide(colorScheme.primary, colorScheme.onSurface.withValues(alpha: 0.25));
}

@immutable
class _OutlinedButtonColor extends WidgetStateProperty<Color?> with Diagnosticable {
  _OutlinedButtonColor(this.color, [this.disabled]);

  final Color color;
  final Color? disabled;

  @override
  Color? resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return disabled;
    }
    return color;
  }
}

@immutable
class _OutlinedButtonBorderSide extends WidgetStateProperty<BorderSide?> with Diagnosticable {
  _OutlinedButtonBorderSide(this.color, [this.disabled]);

  final Color color;
  final Color? disabled;

  @override
  BorderSide? resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      if (disabled == null) return null;
      return BorderSide(color: disabled!, width: 2);
    }
    if (states.contains(WidgetState.focused) ||
        states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.pressed)) {
      return BorderSide(color: color, width: 2);
    }
    return BorderSide(color: color.withValues(alpha: 0.75), width: 2);
  }
}

class OutlinedButtonPrimaryStyle extends ButtonStyle with _ButtonExpandedForeground {
  OutlinedButtonPrimaryStyle(this.context, {super.visualDensity, this.expanded = true});

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<Color?>? get foregroundColor => _OutlinedButtonColor(_colorScheme.primary);

  @override
  WidgetStateProperty<Color?>? get overlayColor => _ButtonOverlayColor(_colorScheme.primary);

  @override
  WidgetStateProperty<BorderSide?>? get side => _OutlinedButtonBorderSide(_colorScheme.primary);

  @override
  WidgetStateProperty<Color?>? get iconColor => _OutlinedButtonColor(_colorScheme.primary);
}

class OutlinedButtonSecondaryStyle extends ButtonStyle with _ButtonExpandedForeground {
  OutlinedButtonSecondaryStyle(this.context, {super.visualDensity, this.expanded = true});

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<Color?>? get foregroundColor => _OutlinedButtonColor(_colorScheme.secondary);

  @override
  WidgetStateProperty<Color?>? get overlayColor => _ButtonOverlayColor(_colorScheme.secondary);

  @override
  WidgetStateProperty<BorderSide?>? get side => _OutlinedButtonBorderSide(_colorScheme.secondary);

  @override
  WidgetStateProperty<Color?>? get iconColor => _OutlinedButtonColor(_colorScheme.secondary);
}

class OutlinedButtonErrorStyle extends ButtonStyle with _ButtonExpandedForeground {
  OutlinedButtonErrorStyle(this.context, {super.visualDensity, this.expanded = true});

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<Color?>? get foregroundColor => _OutlinedButtonColor(_colorScheme.error);

  @override
  WidgetStateProperty<Color?>? get overlayColor => _ButtonOverlayColor(_colorScheme.error);

  @override
  WidgetStateProperty<BorderSide?>? get side => _OutlinedButtonBorderSide(_colorScheme.error);

  @override
  WidgetStateProperty<Color?>? get iconColor => _OutlinedButtonColor(_colorScheme.error);
}

class OutlinedButtonNeutralStyle extends ButtonStyle with _ButtonExpandedForeground {
  OutlinedButtonNeutralStyle(this.context, {super.visualDensity, this.expanded = true});

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<Color?>? get foregroundColor => _OutlinedButtonColor(_colorScheme.onSurface);

  @override
  WidgetStateProperty<Color?>? get iconColor => _OutlinedButtonColor(_colorScheme.onSurface);

  @override
  WidgetStateProperty<Color?>? get overlayColor => _ButtonOverlayColor(_colorScheme.onSurfaceVariant);

  @override
  WidgetStateProperty<BorderSide?>? get side => _OutlinedButtonBorderSide(_colorScheme.onSurfaceVariant);
}
