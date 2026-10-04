import 'dart:async';
import 'dart:math' as math;

import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

void showGeneralMessage({required BuildContext context, required String content}) {
  final alertMessage = AlertMessage(content: content, leading: const Icon(Icons.info_outline_rounded));
  showAlertMessage(context, alertMessage);
}

void showSuccessMessage({required BuildContext context, required String content}) {
  final alertMessage = AlertMessage(
    content: content,
    leading: const Icon(Icons.check_circle_outline_rounded),
    style: AlertMessageStyle.success,
  );
  showAlertMessage(context, alertMessage);
}

void showErrorMessage({required BuildContext context, required String content}) {
  final alertMessage = AlertMessage(
    content: content,
    leading: const Icon(Icons.error_outline_rounded),
    style: AlertMessageStyle.error,
  );
  showAlertMessage(context, alertMessage);
}

void showAlertMessage(BuildContext context, AlertMessage alertMessage) {
  OverlayState? overlayState = Navigator.of(context, rootNavigator: true).overlay;
  if (overlayState == null) return;

  OverlayEntry? overlayEntry;

  final Widget overlay = Directionality(
    textDirection: Directionality.of(context),
    child: Builder(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        return Positioned.fill(
          top: math.max(mediaQuery.padding.top + Spacing.normal, Spacing.normal),
          left: math.max(mediaQuery.padding.left, Spacing.normal),
          right: math.max(mediaQuery.padding.right, Spacing.normal),
          bottom: math.max(mediaQuery.padding.bottom, mediaQuery.viewInsets.bottom) + Spacing.normal,
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            heightFactor: 1.0,
            child: _AlertMessageView(
              content: alertMessage.content,
              leading: alertMessage.leading,
              style: alertMessage.style,
              duration: const Duration(seconds: 5),
              onRemoved: () => overlayEntry?.remove(),
            ),
          ),
        );
      },
    ),
  );

  overlayEntry = OverlayEntry(builder: (context) => overlay);
  overlayState.insert(overlayEntry);
}

enum AlertMessageStyle { general, success, error }

class AlertMessage {
  const AlertMessage({required this.content, this.leading, this.style = AlertMessageStyle.general});

  final String content;
  final Widget? leading;
  final AlertMessageStyle style;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertMessage &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          leading == other.leading &&
          style == other.style;

  @override
  int get hashCode => content.hashCode ^ leading.hashCode ^ style.hashCode ^ style.hashCode;
}

class _AlertMessageView extends StatefulWidget {
  const _AlertMessageView({
    required this.content,
    required this.leading,
    this.style = AlertMessageStyle.general,
    required this.duration,
    required this.onRemoved,
  });

  final String content;
  final Widget? leading;
  final AlertMessageStyle style;
  final Duration duration;
  final VoidCallback onRemoved;

  @override
  State<_AlertMessageView> createState() => _AlertMessageViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('content', content));
    properties.add(DiagnosticsProperty<Widget?>('leading', leading));
    properties.add(EnumProperty<AlertMessageStyle>('style', style));
    properties.add(DiagnosticsProperty<Duration>('duration', duration));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onRemoved', onRemoved));
  }
}

class _AlertMessageViewState extends State<_AlertMessageView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  final GlobalKey _dismissibleKey = GlobalKey();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = _controller.drive(
      Tween(begin: const Offset(0, -0.5), end: Offset.zero).chain(CurveTween(curve: Curves.fastOutSlowIn)),
    );

    _timer = Timer(widget.duration, _dismiss);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().whenComplete(_onDismissed);
  }

  void _onDismissed() {
    _controller.reverse();
    widget.onRemoved();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final statusColor = theme.extension<StatusColor>();

    Color effectiveForegroundColor = switch (widget.style) {
      AlertMessageStyle.general => colorScheme.primary,
      AlertMessageStyle.success => statusColor?.success ?? colorScheme.primary,
      AlertMessageStyle.error => colorScheme.error,
    };

    final contentTextStyle = DefaultTextStyle.of(
      context,
    ).style.merge(theme.textTheme.bodyMedium).copyWith(color: effectiveForegroundColor);

    Widget child = Row(
      spacing: Spacing.medium,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.leading != null)
          IconTheme(data: IconThemeData(color: effectiveForegroundColor), child: widget.leading!),
        Flexible(child: Text(widget.content, textAlign: TextAlign.start, maxLines: 6, overflow: TextOverflow.ellipsis)),
      ],
    );

    child = Material(
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surfaceContainerLow,
      shape: Shapes.medium.copyWith(side: BorderSide(color: colorScheme.outlineVariant)),
      textStyle: contentTextStyle,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48, maxWidth: 600),
        padding: const EdgeInsets.symmetric(horizontal: Spacing.medium, vertical: Spacing.medium),
        child: child,
      ),
    );

    return SlideTransition(
      position: _slideAnimation,
      child: Semantics(
        container: true,
        liveRegion: true,
        onDismiss: _onDismissed,
        child: Dismissible(
          key: _dismissibleKey,
          direction: DismissDirection.horizontal,
          onDismissed: (direction) => _onDismissed(),
          child: child,
        ),
      ),
    );
  }
}
