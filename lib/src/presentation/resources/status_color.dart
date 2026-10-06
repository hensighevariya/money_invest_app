import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatusColor extends ThemeExtension<StatusColor> with Diagnosticable {
  const StatusColor({
    required this.pending,
    required this.inProgress,
    required this.success,
    required this.warning,
  });

  final Color pending;
  final Color inProgress;
  final Color success;
  final Color warning;

  static StatusColor of(BuildContext context) {
    final statusColor = maybeOf(context);
    assert(
      statusColor != null,
      'No StatusColor found in ThemeData!\n'
      'To fix this issues, add StatusColor to ThemeData.extensions property.',
    );
    return statusColor!;
  }

  static StatusColor? maybeOf(BuildContext context) {
    StatusColor? statusColor = Theme.of(context).extension<StatusColor>();
    return statusColor;
  }

  @override
  StatusColor copyWith({
    Color? pending,
    Color? inProgress,
    Color? success,
    Color? warning,
  }) {
    return StatusColor(
      pending: pending ?? this.pending,
      inProgress: inProgress ?? this.inProgress,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  ThemeExtension<StatusColor> lerp(
    ThemeExtension<StatusColor>? other,
    double t,
  ) {
    if (other is! StatusColor) return this;
    return copyWith(
      pending: Color.lerp(pending, other.pending, t),
      inProgress: Color.lerp(inProgress, other.inProgress, t),
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusColor &&
          runtimeType == other.runtimeType &&
          pending == other.pending &&
          inProgress == other.inProgress &&
          success == other.success &&
          warning == other.warning;

  @override
  int get hashCode => Object.hashAll([pending, inProgress, success, warning]);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('pending', pending));
    properties.add(ColorProperty('inProgress', inProgress));
    properties.add(ColorProperty('success', success));
    properties.add(ColorProperty('warning', warning));
  }
}
