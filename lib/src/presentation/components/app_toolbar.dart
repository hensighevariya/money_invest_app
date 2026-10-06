import 'dart:math' as math;
import 'dart:ui';

import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'icon_buttons.dart';

class AppToolbar extends StatefulWidget implements PreferredSizeWidget {
  const AppToolbar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.autoImplyLeading = true,
    this.centerTitle,
    this.titleSpacing,
    this.leadingSpacing,
    this.trailingSpacing,
    this.toolbarHeight,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool autoImplyLeading;
  final bool? centerTitle;
  final double? titleSpacing;
  final double? leadingSpacing;
  final double? trailingSpacing;
  final double? toolbarHeight;

  @override
  State<AppToolbar> createState() => _AppToolbarState();

  @override
  Size get preferredSize => Size.fromHeight(
    (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
  );
}

class _AppToolbarState extends State<AppToolbar> {
  ScrollNotificationObserverState? _scrollNotificationObserver;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotificationObserver?.removeListener(_handleScrollNotification);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification && notification.depth == 0) {
      final bool oldScrolledUnder = _scrolledUnder;
      final ScrollMetrics metrics = notification.metrics;
      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          _scrolledUnder = metrics.extentAfter > 0;
        case AxisDirection.down:
          _scrolledUnder = metrics.extentBefore > 0;
        case AxisDirection.right:
        case AxisDirection.left:
          // Scrolled under is only supported in the vertical axis, and should
          // not be altered based on horizontal notifications of the same
          // predicate since it could be a 2D scroller.
          break;
      }

      if (_scrolledUnder != oldScrolledUnder) {
        setState(() {
          // React to a change in MaterialState.scrolledUnder
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final appBarTheme = theme.appBarTheme;

    final backgroundColor =
        appBarTheme.backgroundColor ?? theme.colorScheme.surface;
    final foregroundColor =
        appBarTheme.foregroundColor ?? theme.colorScheme.onSurface;
    final iconColor =
        appBarTheme.iconTheme?.color ??
        appBarTheme.foregroundColor ??
        theme.colorScheme.onSurface;

    final effectiveTextStyle = const TextStyle()
        .merge(theme.textTheme.titleLarge)
        .copyWith(color: foregroundColor);

    Widget? leading = widget.leading;
    if (leading == null &&
        widget.autoImplyLeading &&
        (ModalRoute.of(context)?.canPop ?? false)) {
      leading = BackIconButton(onPressed: () => context.navigator.maybePop());
    }

    Widget? action;
    if (widget.actions?.isNotEmpty ?? false) {
      action = Row(
        spacing: Spacing.small,
        mainAxisSize: MainAxisSize.min,
        children: widget.actions!,
      );
    }

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: _scrolledUnder ? 1.0 : 0.0),
      duration: Durations.medium2,
      curve: Curves.ease,
      builder: (context, value, child) {
        final double blurRadius = lerpDouble(0.0, 32.0, value) ?? 0.0;
        final effectiveBackgroundColor = Color.lerp(
          Colors.transparent,
          backgroundColor.withValues(alpha: 0.25),
          value,
        );

        return Material(
          color: effectiveBackgroundColor,
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            enabled: blurRadius > 0,
            filter: ImageFilter.blur(sigmaY: blurRadius, sigmaX: blurRadius),
            child: child,
          ),
        );
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: appBarTheme.systemOverlayStyle ?? const SystemUiOverlayStyle(),
        child: IconTheme(
          data: appBarTheme.iconTheme ?? IconThemeData(color: iconColor),
          child: IconButtonTheme(
            data: IconButtonThemeData(
              style: IconButton.styleFrom(foregroundColor: iconColor),
            ),
            child: CustomMultiChildLayout(
              delegate: _ToolbarLayout(
                toolbarHeight: widget.toolbarHeight ?? kToolbarHeight,
                textDirection: context.textDirection,
                mediaQueryPadding: context.mediaQueryPadding,
                titleSpacing: widget.titleSpacing ?? Spacing.normal,
                leadingSpacing: widget.leadingSpacing ?? Spacing.xSmall,
                trailingSpacing: widget.trailingSpacing ?? Spacing.xSmall,
                centerTitle:
                    widget.centerTitle ?? appBarTheme.centerTitle ?? true,
                bottomSize: widget.bottom?.preferredSize,
              ),
              children: [
                if (leading != null)
                  LayoutId(id: _ToolbarSlot.leading, child: leading),
                if (action != null)
                  LayoutId(id: _ToolbarSlot.action, child: action),
                if (widget.title != null)
                  LayoutId(
                    id: _ToolbarSlot.title,
                    child: DefaultTextStyle.merge(
                      style: effectiveTextStyle,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      child: widget.title!,
                    ),
                  ),
                if (widget.bottom != null)
                  LayoutId(id: _ToolbarSlot.bottom, child: widget.bottom!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget?>('title', widget.title));
    properties.add(DiagnosticsProperty<Widget?>('leading', widget.leading));
    properties.add(
      DiagnosticsProperty<List<Widget>?>('action', widget.actions),
    );
    properties.add(
      DiagnosticsProperty<PreferredSizeWidget?>('bottom', widget.bottom),
    );
    properties.add(
      DiagnosticsProperty<bool>('autoImplyLeading', widget.autoImplyLeading),
    );
    properties.add(DoubleProperty('titleSpacing', widget.titleSpacing));
    properties.add(DoubleProperty('leadingSpacing', widget.leadingSpacing));
    properties.add(DoubleProperty('trailingSpacing', widget.trailingSpacing));
  }
}

enum _ToolbarSlot { leading, title, action, bottom }

class _ToolbarLayout extends MultiChildLayoutDelegate {
  _ToolbarLayout({
    required this.textDirection,
    required this.mediaQueryPadding,
    required this.titleSpacing,
    required this.leadingSpacing,
    required this.trailingSpacing,
    required this.toolbarHeight,
    this.centerTitle = true,
    required this.bottomSize,
  });

  final EdgeInsets mediaQueryPadding;
  final TextDirection textDirection;
  final double titleSpacing;
  final double leadingSpacing;
  final double trailingSpacing;
  final double toolbarHeight;
  final bool centerTitle;
  final Size? bottomSize;

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(
      constraints.maxWidth,
      math.min(
        constraints.maxHeight,
        mediaQueryPadding.top + toolbarHeight + (bottomSize?.height ?? 0),
      ),
    );
  }

  @override
  void performLayout(Size size) {
    double leadingWidth = 0.0;
    double trailingWidth = 0.0;

    final effectiveToolbarHeight = math.min(
      size.height - mediaQueryPadding.top - (bottomSize?.height ?? 0),
      toolbarHeight,
    );
    double effectiveStartMargin, effectiveEndMargin;

    effectiveStartMargin = switch (textDirection) {
      TextDirection.ltr => mediaQueryPadding.left,
      TextDirection.rtl => mediaQueryPadding.right,
    };
    effectiveEndMargin = switch (textDirection) {
      TextDirection.ltr => mediaQueryPadding.right,
      TextDirection.rtl => mediaQueryPadding.left,
    };

    if (hasChild(_ToolbarSlot.leading)) {
      final iconConstraints = BoxConstraints(maxWidth: size.width);
      final leadingSize = layoutChild(_ToolbarSlot.leading, iconConstraints);

      double effectiveLeadingSpace = math.max(
        effectiveStartMargin,
        leadingSpacing,
      );
      final double leadingX = switch (textDirection) {
        TextDirection.rtl =>
          size.width - leadingSize.width - effectiveLeadingSpace,
        TextDirection.ltr => effectiveLeadingSpace,
      };
      final double leadingY =
          mediaQueryPadding.top +
          (effectiveToolbarHeight - leadingSize.height) / 2.0;

      leadingWidth = effectiveLeadingSpace + leadingSize.width;
      positionChild(_ToolbarSlot.leading, Offset(leadingX, leadingY));
    }

    if (hasChild(_ToolbarSlot.action)) {
      final Size trailingSize = layoutChild(
        _ToolbarSlot.action,
        BoxConstraints(maxWidth: size.width),
      );

      double effectiveTrailingSpace = math.max(
        effectiveEndMargin,
        trailingSpacing,
      );
      final double trailingX = switch (textDirection) {
        TextDirection.ltr =>
          size.width - trailingSize.width - effectiveTrailingSpace,
        TextDirection.rtl => effectiveTrailingSpace,
      };
      final double trailingY =
          mediaQueryPadding.top +
          (effectiveToolbarHeight - trailingSize.height) / 2.0;

      trailingWidth = effectiveTrailingSpace + trailingSize.width;
      positionChild(_ToolbarSlot.action, Offset(trailingX, trailingY));
    }

    if (hasChild(_ToolbarSlot.title)) {
      final double availableMaxWidth = math.max(
        size.width - leadingWidth - trailingWidth - (titleSpacing * 2),
        0.0,
      );
      final BoxConstraints constraints = BoxConstraints(
        maxWidth: availableMaxWidth,
        maxHeight: effectiveToolbarHeight,
      );
      final Size titleSize = layoutChild(_ToolbarSlot.title, constraints);

      final double titleStartMargin = leadingWidth + titleSpacing;
      double titleStart = titleStartMargin;
      final double titleY =
          mediaQueryPadding.top +
          (effectiveToolbarHeight - titleSize.height) / 2.0;

      if (centerTitle) {
        titleStart = (size.width - titleSize.width) / 2.0;
        if (titleStart + titleSize.width > size.width - trailingWidth) {
          titleStart =
              size.width - trailingWidth - Spacing.small - titleSize.width;
        } else if (titleStart < titleStartMargin) {
          titleStart = titleStartMargin;
        }
      }
      final double titleX = switch (textDirection) {
        TextDirection.rtl => size.width - titleSize.width - titleStart,
        TextDirection.ltr => titleStart,
      };
      positionChild(_ToolbarSlot.title, Offset(titleX, titleY));
    }

    if (hasChild(_ToolbarSlot.bottom)) {
      final BoxConstraints constraints = BoxConstraints.tightFor(
        width: math.min(math.min(bottomSize?.width ?? 0, size.width), 960),
        height: bottomSize?.height,
      );
      final bottomWidgetSize = layoutChild(_ToolbarSlot.bottom, constraints);
      positionChild(
        _ToolbarSlot.bottom,
        Offset(
          (size.width - bottomWidgetSize.width) / 2,
          effectiveToolbarHeight + mediaQueryPadding.top,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(_ToolbarLayout oldDelegate) =>
      oldDelegate.textDirection != textDirection ||
      oldDelegate.mediaQueryPadding != mediaQueryPadding ||
      oldDelegate.titleSpacing != titleSpacing ||
      oldDelegate.leadingSpacing != leadingSpacing ||
      oldDelegate.trailingSpacing != trailingSpacing ||
      oldDelegate.toolbarHeight != toolbarHeight ||
      oldDelegate.centerTitle != centerTitle ||
      oldDelegate.bottomSize != bottomSize;
}
