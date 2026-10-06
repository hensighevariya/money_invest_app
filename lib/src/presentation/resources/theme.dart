import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';

import 'constraints.dart';
import 'status_color.dart';
import 'styles/button.dart';

class SecuritySaasAppTheme {
  final BuildContext context;

  SecuritySaasAppTheme(this.context);

  static const String defaultFontFamily = 'Outfit';

  static ColorScheme get _lightColorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF07193F),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF008EFB),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFF1023B),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0x8A000000),
      surfaceTint: Colors.transparent,
    );
  }

  static StatusColor get statusColor {
    return const StatusColor(
      pending: Color(0xFFF5AF19),
      inProgress: Color(0xFFFF6B00),
      success: Color(0xFF00AA73),
      warning: Color(0xFF32ADE6),
    );
  }

  ThemeData get lightTheme => _getTheme(_lightColorScheme);

  ThemeData _getTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: defaultFontFamily,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      extensions: {statusColor},
      splashFactory: NoSplash.splashFactory,
      shadowColor: colorScheme.shadow,
      hintColor: colorScheme.onSurfaceVariant,
      disabledColor: colorScheme.onSurface.withAlpha(100),
      canvasColor: colorScheme.surface,
      textTheme: _textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButtonDefaultStyle(colorScheme),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButtonDefaultStyle(colorScheme),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButtonDefaultStyle(colorScheme),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      checkboxTheme: _checkboxThemeData(colorScheme),
      radioTheme: _radioThemeData(colorScheme),
      cardTheme: _cardTheme(colorScheme),
      floatingActionButtonTheme: _floatingActionButtonTheme(colorScheme),
      dialogTheme: _dialogTheme(colorScheme),
      listTileTheme: _listTileThemeData(colorScheme),
      expansionTileTheme: _expansionTileThemeData(colorScheme),
      datePickerTheme: _datePickerThemeData(colorScheme),
      bottomSheetTheme: _bottomSheetThemeData(colorScheme),
      tooltipTheme: _tooltipTheme(colorScheme),
    );
  }

  TextTheme _textTheme(ColorScheme colorScheme) {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.2,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.2,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.0,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
        height: 1.2,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.2,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.2,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.2,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
      ),
    );
  }

  CardThemeData _cardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      elevation: 8,
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainer,
    );
  }

  InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorScheme.onSurface, width: 1.0),
    );

    final errorBorder = defaultBorder.copyWith(
      borderSide: BorderSide(color: colorScheme.error, width: 1.0),
    );

    final fillColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return colorScheme.onSurface.withValues(alpha: 0.1);
      }
      return Colors.white;
    });

    final iconColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.error)) return colorScheme.error;
      return Colors.black54;
    });

    return InputDecorationTheme(
      constraints: LayoutConstraints.formField,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
      border: defaultBorder,
      enabledBorder: defaultBorder,
      disabledBorder: defaultBorder,
      focusedBorder: defaultBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      fillColor: fillColor,
      filled: true,
      errorMaxLines: 3,
      helperMaxLines: 3,
      suffixIconColor: iconColor,
      prefixIconColor: iconColor,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }

  CheckboxThemeData _checkboxThemeData(ColorScheme colorScheme) {
    return const CheckboxThemeData(splashRadius: 24, shape: Shapes.full);
  }

  RadioThemeData _radioThemeData(ColorScheme colorScheme) {
    return const RadioThemeData(splashRadius: 24);
  }

  FloatingActionButtonThemeData _floatingActionButtonTheme(
    ColorScheme colorScheme,
  ) {
    return const FloatingActionButtonThemeData(shape: CircleBorder());
  }

  DialogThemeData _dialogTheme(ColorScheme colorScheme) {
    return DialogThemeData(
      clipBehavior: Clip.antiAlias,
      shape: Shapes.normal.copyWith(
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      backgroundColor: colorScheme.surfaceContainerLow,
      insetPadding: const EdgeInsets.symmetric(
        vertical: Spacing.xLarge,
        horizontal: Spacing.xxLarge,
      ),
    );
  }

  ListTileThemeData _listTileThemeData(ColorScheme colorScheme) {
    return ListTileThemeData(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        horizontal: Spacing.normal,
      ),
      selectedTileColor: colorScheme.primary,
      selectedColor: colorScheme.onPrimary,
    );
  }

  ExpansionTileThemeData _expansionTileThemeData(ColorScheme colorScheme) {
    return const ExpansionTileThemeData(
      clipBehavior: Clip.antiAlias,
      childrenPadding: EdgeInsetsDirectional.fromSTEB(
        Spacing.normal,
        Spacing.small,
        Spacing.normal,
        Spacing.normal,
      ),
      shape: RoundedRectangleBorder(),
      collapsedShape: RoundedRectangleBorder(),
    );
  }

  DatePickerThemeData _datePickerThemeData(ColorScheme colorScheme) {
    return DatePickerThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: ShapeBorderRadius.medium,
      ),
      headerBackgroundColor: colorScheme.primary,
      headerForegroundColor: colorScheme.onPrimary,
    );
  }

  BottomSheetThemeData _bottomSheetThemeData(ColorScheme colorScheme) {
    return const BottomSheetThemeData(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: ShapeCornerRadius.normal),
      ),
      dragHandleSize: Size(64, 4),
    );
  }

  TooltipThemeData _tooltipTheme(ColorScheme colorScheme) {
    return TooltipThemeData(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.normal),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: ShapeBorderRadius.small,
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        color: Color.alphaBlend(
          colorScheme.inverseSurface.withAlpha(50),
          colorScheme.surfaceContainerHighest,
        ),
      ),
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: defaultFontFamily,
      ),
      preferBelow: true,
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.small,
        horizontal: Spacing.medium,
      ),
    );
  }
}
