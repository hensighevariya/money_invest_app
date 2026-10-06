import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/constraints.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

part 'button/elevated_button.dart';

part 'button/outlined_button.dart';

part 'button/text_button.dart';

mixin _ButtonExpandedForeground on ButtonStyle {
  bool get expanded;

  @override
  ButtonLayerBuilder? get foregroundBuilder =>
      expanded ? _expandedChildBuilder : null;

  Widget _expandedChildBuilder(
    BuildContext context,
    Set<WidgetState> states,
    Widget? child,
  ) {
    return Center(heightFactor: 1.0, child: child);
  }
}

@immutable
class _ButtonOverlayColor extends WidgetStateProperty<Color?>
    with Diagnosticable {
  _ButtonOverlayColor(this.color);

  final Color color;

  @override
  Color? resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return color.withValues(alpha: 0.1);
    }
    if (states.contains(WidgetState.hovered)) {
      return color.withValues(alpha: 0.08);
    }
    if (states.contains(WidgetState.focused)) {
      return color.withValues(alpha: 0.1);
    }
    return null;
  }
}
