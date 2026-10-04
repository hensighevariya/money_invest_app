import 'dart:math';

import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key, this.size = 48, this.color});

  final double size;
  final Color? color;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicator();
}

class _LoadingIndicator extends State<LoadingIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Durations.extralong4);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return Center(
      heightFactor: 1.0,
      widthFactor: 1.0,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.square(widget.size),
          painter: _LoadingCirclePainter(animation: _controller, strokeColor: color, color: colorScheme.onSurface),
        ),
      ),
    );
  }
}

class _LoadingCirclePainter extends CustomPainter {
  _LoadingCirclePainter({required this.animation, required this.color, required this.strokeColor})
    : scaleAnimation = TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 0.75, end: 1.0), weight: 0.5),
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.75), weight: 0.5),
      ]).animate(animation),
      super(repaint: animation);

  final Animation<double> animation;
  final Animation<double> scaleAnimation;
  final Color color;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final outerCircleRadius = (size.shortestSide / 2) * scaleAnimation.value;
    final innerCircleRadius = outerCircleRadius * 0.5;

    canvas.drawCircle(center, innerCircleRadius, paint);

    final strokePaint =
        Paint()
          ..color = strokeColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = size.shortestSide / 8
          ..style = PaintingStyle.stroke;

    double sweepAngle = (pi / 180) * 120;
    final outerCircleRect = Rect.fromCircle(center: center, radius: outerCircleRadius);

    double outerCircle1StartAngle = 2 * pi * animation.value;
    double outerCircle2StartAngle = outerCircle1StartAngle + pi;

    final stroke1Path = Path()..addArc(outerCircleRect, outerCircle1StartAngle, sweepAngle);
    final stroke2Path = Path()..addArc(outerCircleRect, outerCircle2StartAngle, sweepAngle);

    canvas.drawPath(stroke1Path, strokePaint);
    canvas.drawPath(stroke2Path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
