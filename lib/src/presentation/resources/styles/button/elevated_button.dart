part of '../button.dart';

class ElevatedButtonDefaultStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  const ElevatedButtonDefaultStyle(this.colorScheme);

  final ColorScheme colorScheme;

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(Shapes.normal);

  @override
  WidgetStateProperty<Size?>? get minimumSize =>
      const WidgetStatePropertyAll(LayoutConstants.minimumButtonSize);

  @override
  WidgetStateProperty<Size?>? get maximumSize =>
      const WidgetStatePropertyAll(LayoutConstants.maximumButtonSize);

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Spacing.normal,
          horizontal: Spacing.xLarge,
        ),
      );

  @override
  WidgetStateProperty<Color?>? get backgroundColor => _ElevatedButtonColor(
    colorScheme.primary,
    colorScheme.surfaceContainerHigh.applyOpacity(0.5),
  );

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _ElevatedButtonColor(colorScheme.onPrimary, colorScheme.onSurfaceVariant);

  @override
  WidgetStateProperty<Color?>? get iconColor =>
      _ElevatedButtonColor(colorScheme.onPrimary, colorScheme.onSurfaceVariant);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(colorScheme.onPrimary);

  @override
  bool get expanded => false;
}

@immutable
class _ElevatedButtonColor extends WidgetStateProperty<Color?>
    with Diagnosticable {
  _ElevatedButtonColor(this.color, [this.disabled]);

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

class ElevatedButtonPrimaryStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  ElevatedButtonPrimaryStyle(
    this.context, {
    super.visualDensity,
    this.expanded = true,
    this.buttonColor,
  });

  final BuildContext context;
  final Color? buttonColor;

  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Spacing.normal,
          horizontal: Spacing.xLarge,
        ),
      );

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(Shapes.normal);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      _ElevatedButtonColor(buttonColor ?? _colorScheme.primary, Colors.grey);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _ElevatedButtonColor(_colorScheme.onPrimary, Colors.white);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.error);

  @override
  WidgetStateProperty<Color?>? get iconColor =>
      _ElevatedButtonColor(_colorScheme.onPrimary);
}

class ElevatedButtonSecondaryStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  ElevatedButtonSecondaryStyle(
    this.context, {
    super.visualDensity,
    this.expanded = true,
    this.borderColor,
    this.buttonColor,
  });

  final BuildContext context;
  final Color? borderColor;

  final Color? buttonColor;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Spacing.medium,
          horizontal: Spacing.normal,
        ),
      );

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStatePropertyAll(
    BorderSide(color: borderColor ?? _colorScheme.onSurfaceVariant, width: 1),
  );

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(Shapes.normal);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      _ElevatedButtonColor(buttonColor ?? _colorScheme.surfaceContainerHighest);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _ElevatedButtonColor(_colorScheme.onSurface);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.onSecondary);

  @override
  WidgetStateProperty<Color?>? get iconColor =>
      _ElevatedButtonColor(_colorScheme.onSecondary);
}

class ElevatedButtonErrorStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  ElevatedButtonErrorStyle(
    this.context, {
    super.visualDensity,
    this.expanded = true,
  });

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Spacing.medium,
          horizontal: Spacing.normal,
        ),
      );

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(Shapes.normal);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      _ElevatedButtonColor(_colorScheme.error);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _ElevatedButtonColor(_colorScheme.onError);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.onError);

  @override
  WidgetStateProperty<Color?>? get iconColor =>
      _ElevatedButtonColor(_colorScheme.onError);
}

class ElevatedButtonNeutralStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  ElevatedButtonNeutralStyle(
    this.context, {
    super.visualDensity,
    this.expanded = true,
  });

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Spacing.medium,
          horizontal: Spacing.normal,
        ),
      );

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(Shapes.normal);

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStatePropertyAll(
    BorderSide(color: _colorScheme.onSecondaryContainer, width: 1),
  );

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      _ElevatedButtonColor(_colorScheme.onPrimary);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _ElevatedButtonColor(_colorScheme.onSurface);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.onSurface);

  @override
  WidgetStateProperty<Color?>? get iconColor =>
      _ElevatedButtonColor(_colorScheme.onSurface);
}
