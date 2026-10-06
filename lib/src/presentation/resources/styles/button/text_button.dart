part of '../button.dart';

class TextButtonDefaultStyle extends ButtonStyle {
  const TextButtonDefaultStyle(this.colorScheme);

  final ColorScheme colorScheme;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Spacing.small,
          horizontal: Spacing.normal,
        ),
      );

  @override
  WidgetStateProperty<Color?>? get foregroundColor => _TextButtonColor(
    colorScheme.primaryFixed,
    colorScheme.onSurface.withValues(alpha: 0.25),
  );

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(colorScheme.primary);
}

@immutable
class _TextButtonColor extends WidgetStateProperty<Color?> with Diagnosticable {
  _TextButtonColor(this.color, [this.disabled]);

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

class TextButtonPrimaryStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  TextButtonPrimaryStyle(
    this.context, {
    super.visualDensity,
    this.expanded = false,
  });

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(Shapes.normal);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _TextButtonColor(_colorScheme.onSurface);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.primary);
}

class TextButtonSecondaryStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  TextButtonSecondaryStyle(
    this.context, {
    super.visualDensity,
    this.expanded = false,
  });

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _TextButtonColor(_colorScheme.secondaryFixed);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.secondary);
}

class TextButtonErrorStyle extends ButtonStyle with _ButtonExpandedForeground {
  TextButtonErrorStyle(
    this.context, {
    super.visualDensity,
    this.expanded = false,
  });

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _TextButtonColor(_colorScheme.error);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.error);
}

class TextButtonNeutralStyle extends ButtonStyle
    with _ButtonExpandedForeground {
  TextButtonNeutralStyle(
    this.context, {
    super.visualDensity,
    this.expanded = false,
  });

  final BuildContext context;
  @override
  final bool expanded;

  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      _TextButtonColor(_colorScheme.onSurfaceVariant);

  @override
  WidgetStateProperty<Color?>? get overlayColor =>
      _ButtonOverlayColor(_colorScheme.onSurfaceVariant);
}
