import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';

abstract interface class LayoutConstants {
  static const Size formFieldSize = Size.fromWidth(
    AdaptiveLayoutBreakpoints.compat,
  );
  static const Size maximumButtonSize = Size.fromWidth(600);
  static const Size minimumButtonSize = Size(120, 36);

  static const double chatMessageMaxWidth = 640;
  static const double chatMediaMaxWidth = 360;
}

abstract interface class LayoutConstraints {
  static const BoxConstraints modalDialog = BoxConstraints(
    maxWidth: 480,
    maxHeight: 640,
    minWidth: 280,
  );
  static const BoxConstraints fullScreenDialog = BoxConstraints(
    maxWidth: 1200,
    maxHeight: 720,
  );
  static const BoxConstraints bottomNavigation = BoxConstraints(maxWidth: 600);
  static const BoxConstraints compat = BoxConstraints(
    maxWidth: AdaptiveLayoutBreakpoints.compat,
  );
  static const BoxConstraints medium = BoxConstraints(
    maxWidth: AdaptiveLayoutBreakpoints.medium,
  );

  static const BoxConstraints formField = BoxConstraints(
    maxWidth: AdaptiveLayoutBreakpoints.compat,
  );
  static const BoxConstraints forms = BoxConstraints(
    maxWidth: AdaptiveLayoutBreakpoints.compat,
  );
  static const BoxConstraints emptyView = BoxConstraints(
    maxWidth: AdaptiveLayoutBreakpoints.compat,
  );
}
