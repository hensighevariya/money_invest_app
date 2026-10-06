import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/constraints.dart';

class CompatConstrainedBox extends StatelessWidget {
  const CompatConstrainedBox({
    super.key,
    required this.child,
    this.widthFactor,
    this.heightFactor,
  });

  final Widget? child;
  final double? widthFactor;
  final double? heightFactor;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: heightFactor ?? 1.0,
      widthFactor: widthFactor,
      child: ConstrainedBox(
        constraints: LayoutConstraints.compat,
        child: child,
      ),
    );
  }
}

class MediumConstrainedBox extends StatelessWidget {
  const MediumConstrainedBox({
    super.key,
    required this.child,
    this.widthFactor,
    this.heightFactor,
  });

  final Widget? child;
  final double? widthFactor;
  final double? heightFactor;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: heightFactor ?? 1.0,
      widthFactor: widthFactor,
      child: ConstrainedBox(
        constraints: LayoutConstraints.medium,
        child: child,
      ),
    );
  }
}
