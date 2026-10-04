import 'package:flutter/material.dart';

abstract interface class Spacing {
  static const double none = 0;
  static const double xSmall = 4;
  static const double small = 8;
  static const double xMedium = 10;
  static const double medium = 12;
  static const double normal = 16;
  static const double large = 20;
  static const double xLarge = 24;
  static const double xxLarge = 32;
  static const double xxxLarge = 40;
}

abstract interface class RadiusValues {
  static const Radius none = Radius.zero;
  static const Radius xSmall = Radius.circular(4);
  static const Radius small = Radius.circular(8);
  static const Radius xMedium = Radius.circular(10);
  static const Radius medium = Radius.circular(12);
  static const Radius normal = Radius.circular(16);
  static const Radius large = Radius.circular(20);
  static const Radius xLarge = Radius.circular(24);
  static const Radius xxLarge = Radius.circular(32);
  static const Radius xxxLarge = Radius.circular(40);
}

abstract interface class ShapeBorderRadius {
  static const BorderRadius none = BorderRadius.zero;
  static const BorderRadius xSmall = BorderRadius.all(RadiusValues.xSmall);
  static const BorderRadius small = BorderRadius.all(RadiusValues.small);
  static const BorderRadius medium = BorderRadius.all(RadiusValues.medium);
  static const BorderRadius xMedium = BorderRadius.all(RadiusValues.xMedium);
  static const BorderRadius normal = BorderRadius.all(RadiusValues.normal);
  static const BorderRadius large = BorderRadius.all(RadiusValues.large);
  static const BorderRadius xLarge = BorderRadius.all(RadiusValues.xLarge);
  static const BorderRadius xxLarge = BorderRadius.all(RadiusValues.xxLarge);
  static const BorderRadius xxxLarge = BorderRadius.all(RadiusValues.xxxLarge);
}

abstract class PaddingValue {
  static const EdgeInsetsDirectional zero = EdgeInsetsDirectional.zero;
  static const EdgeInsetsDirectional xSmall = EdgeInsetsDirectional.all(Spacing.xSmall);
  static const EdgeInsetsDirectional small = EdgeInsetsDirectional.all(Spacing.small);
  static const EdgeInsetsDirectional medium = EdgeInsetsDirectional.all(Spacing.medium);
  static const EdgeInsetsDirectional xMedium = EdgeInsetsDirectional.all(Spacing.xMedium);
  static const EdgeInsetsDirectional normal = EdgeInsetsDirectional.all(Spacing.normal);
  static const EdgeInsetsDirectional large = EdgeInsetsDirectional.all(Spacing.large);
  static const EdgeInsetsDirectional xLarge = EdgeInsetsDirectional.all(Spacing.xLarge);
  static const EdgeInsetsDirectional xxLarge = EdgeInsetsDirectional.all(Spacing.xxLarge);
  static const EdgeInsetsDirectional xxxLarge = EdgeInsetsDirectional.all(Spacing.xxxLarge);
}

abstract class TextSize {
  static const double largeHHeading = 28;
  static const double heading = 20;
  static const double appBarTitle = 18;
  static const double appBarSubTitle = 14;
  static const double title = 16;
  static const double subTitle = 14;
  static const double label = 14;
  static const double content = 12;
  static const double body = 10;
}

abstract interface class Shapes {
  static const OutlinedBorder none = RoundedRectangleBorder();

  static const OutlinedBorder extraSmall = RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xSmall);

  static const OutlinedBorder small = RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small);

  static const OutlinedBorder medium = RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium);

  static const OutlinedBorder normal = RoundedRectangleBorder(borderRadius: ShapeBorderRadius.normal);

  static const OutlinedBorder large = RoundedRectangleBorder(borderRadius: ShapeBorderRadius.large);

  static const OutlinedBorder extraLarge = RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xLarge);

  static const OutlinedBorder full = StadiumBorder();
}

/// Provides breakpoints for your adaptive designs
abstract interface class AdaptiveLayoutBreakpoints {
  /// Phone in portrait
  /// width < 600
  static const double compat = 600;

  /// Tablet in portrait, Foldable in portrait (unfolded)
  /// 600 ≤ width < 840
  static const double medium = 840;

  /// Phone in landscape, Tablet in landscape, Foldable in landscape (unfolded), Desktop
  /// 840 ≤ width < 1200*
  static const double expanded = 1200;

  /// Desktop
  /// 1200 ≤ width < 1600
  static const double large = 1600;

  /// Desktop, Ultra-wide
  /// 1600 ≤ width
  static const double extraLarge = 1600;
}
