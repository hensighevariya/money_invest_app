import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class FloatingTooltip extends StatefulWidget {
  const FloatingTooltip({
    super.key,
    required this.message,
    this.preferBelow,
    this.child,
  });

  final String message;
  final bool? preferBelow;
  final Widget? child;

  static final List<FloatingTooltipState> _openedTooltips =
      <FloatingTooltipState>[];

  // Causes any current tooltips to be concealed. Only called for mouse hover enter
  // detections. Won't conceal the supplied tooltip.
  static void _concealOtherTooltips(FloatingTooltipState current) {
    if (_openedTooltips.isNotEmpty) {
      // Avoid concurrent modification.
      final List<FloatingTooltipState> openedTooltips = _openedTooltips
          .toList();
      for (final FloatingTooltipState state in openedTooltips) {
        if (state == current) {
          continue;
        }
        state._concealTooltip();
      }
    }
  }

  // Causes the most recently concealed tooltip to be revealed. Only called for mouse
  // hover exit detections.
  static void _revealLastTooltip() {
    if (_openedTooltips.isNotEmpty) {
      _openedTooltips.last._revealTooltip();
    }
  }

  static bool dismissAllToolTips() {
    if (_openedTooltips.isNotEmpty) {
      // Avoid concurrent modification.
      final List<FloatingTooltipState> openedTooltips = _openedTooltips
          .toList();
      for (final FloatingTooltipState state in openedTooltips) {
        state._dismissTooltip(immediately: true);
      }
      return true;
    }
    return false;
  }

  @override
  State<FloatingTooltip> createState() => FloatingTooltipState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      StringProperty(
        'message',
        message,
        showName: false,
        defaultValue: kNoDefaultValue,
      ),
    );
    properties.add(
      FlagProperty(
        'position',
        value: preferBelow,
        ifTrue: 'below',
        ifFalse: 'above',
        showName: true,
      ),
    );
  }
}

class FloatingTooltipState extends State<FloatingTooltip>
    with SingleTickerProviderStateMixin {
  static const double _defaultVerticalOffset = 24.0;
  static const bool _defaultPreferBelow = true;
  static const Duration _fadeInDuration = Duration(milliseconds: 150);
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);

  late double _height;
  late double _verticalOffset;
  late bool _preferBelow;
  late AnimationController _controller;
  OverlayEntry? _entry;
  late bool _mouseIsConnected;

  late bool _isConcealed;
  late bool _forceRemoval;

  String get _tooltipMessage => widget.message;

  @override
  void initState() {
    super.initState();
    _isConcealed = false;
    _forceRemoval = false;
    _mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
    _controller = AnimationController(
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
    // Listen to see when a mouse is added.
    RendererBinding.instance.mouseTracker.addListener(
      _handleMouseTrackerChange,
    );
    // Listen to global pointer events so that we can hide a tooltip immediately
    // if some other control is clicked on.
    GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
  }

  // Forces a rebuild if a mouse has been added or removed.
  void _handleMouseTrackerChange() {
    if (!mounted) {
      return;
    }
    final bool mouseIsConnected =
        RendererBinding.instance.mouseTracker.mouseIsConnected;
    if (mouseIsConnected != _mouseIsConnected) {
      setState(() {
        _mouseIsConnected = mouseIsConnected;
      });
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    // If this tip is concealed, don't remove it, even if it is dismissed, so that we can
    // reveal it later, unless it has explicitly been hidden with _dismissTooltip.
    if (status == AnimationStatus.dismissed &&
        (_forceRemoval || !_isConcealed)) {
      _removeEntry();
    }
  }

  void _dismissTooltip({bool immediately = false}) {
    if (immediately) {
      _removeEntry();
      return;
    }
    // So it will be removed when it's done reversing, regardless of whether it is
    // still concealed or not.
    _forceRemoval = true;
  }

  void _showTooltip({bool immediately = false}) {
    if (immediately) {
      ensureTooltipVisible();
      return;
    }
  }

  void _concealTooltip() {
    if (_isConcealed || _forceRemoval) {
      // Already concealed, or it's being removed.
      return;
    }
    _isConcealed = true;
    if (_entry != null) {
      _entry!.remove();
    }
    _controller.reverse();
  }

  void _revealTooltip() {
    if (!_isConcealed) {
      // Already uncovered.
      return;
    }
    _isConcealed = false;

    if (!_entry!.mounted) {
      final OverlayState overlayState = Overlay.of(
        context,
        debugRequiredFor: widget,
      );
      overlayState.insert(_entry!);
    }
    SemanticsService.tooltip(_tooltipMessage);
    _controller.forward();
  }

  bool ensureTooltipVisible() {
    if (!mounted) {
      return false;
    }
    _forceRemoval = false;
    if (_isConcealed) {
      if (_mouseIsConnected) {
        FloatingTooltip._concealOtherTooltips(this);
      }
      _revealTooltip();
      return true;
    }
    if (_entry != null) {
      // Stop trying to hide, if we were.
      _controller.forward();
      return false; // Already visible.
    }
    _createNewEntry();
    _controller.forward();
    return true;
  }

  static final Set<FloatingTooltipState> _mouseIn = <FloatingTooltipState>{};

  void _handleMouseEnter() {
    if (mounted) {
      _showTooltip();
    }
  }

  void _handleMouseExit({bool immediately = false}) {
    if (mounted) {
      // If the tip is currently covered, we can just remove it without waiting.
      _dismissTooltip(immediately: _isConcealed || immediately);
    }
  }

  void _createNewEntry() {
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    );

    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset target = box.localToGlobal(
      box.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );

    // We create this widget outside of the overlay entry's builder to prevent
    // updated values from happening to leak into the overlay when the overlay
    // rebuilds.
    final Widget overlay = Directionality(
      textDirection: Directionality.of(context),
      child: _TooltipOverlay(
        richMessage: TextSpan(text: widget.message),
        height: _height,
        onEnter: _mouseIsConnected ? (_) => _handleMouseEnter() : null,
        onExit: _mouseIsConnected ? (_) => _handleMouseExit() : null,
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
        target: target,
        verticalOffset: _verticalOffset,
        preferBelow: _preferBelow,
      ),
    );
    _entry = OverlayEntry(builder: (context) => overlay);
    _isConcealed = false;
    overlayState.insert(_entry!);
    SemanticsService.tooltip(_tooltipMessage);
    if (_mouseIsConnected) {
      // Hovered tooltips shouldn't show more than one at once. For example, a chip with
      // a delete icon shouldn't show both the delete icon tooltip and the chip tooltip
      // at the same time.
      FloatingTooltip._concealOtherTooltips(this);
    }
    assert(!FloatingTooltip._openedTooltips.contains(this));
    FloatingTooltip._openedTooltips.add(this);
  }

  void _removeEntry() {
    FloatingTooltip._openedTooltips.remove(this);
    _mouseIn.remove(this);

    if (!_isConcealed) {
      _entry?.remove();
    }
    _isConcealed = false;
    _entry?.dispose();
    _entry = null;
    if (_mouseIsConnected) {
      FloatingTooltip._revealLastTooltip();
    }
  }

  void _handlePointerEvent(PointerEvent event) {
    if (_entry == null) {
      return;
    }
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _handleMouseExit();
    } else if (event is PointerDownEvent) {
      _handleMouseExit(immediately: true);
    }
  }

  @override
  void deactivate() {
    if (_entry != null) {
      _dismissTooltip(immediately: true);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter.removeGlobalRoute(
      _handlePointerEvent,
    );
    RendererBinding.instance.mouseTracker.removeListener(
      _handleMouseTrackerChange,
    );
    _removeEntry();
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    ensureTooltipVisible();
    // When triggerMode is not [TooltipTriggerMode.tap] the tooltip is dismissed
    // by _handlePointerEvent, which listens to the global pointer events.
    // When triggerMode is [TooltipTriggerMode.tap] and the Tooltip GestureDetector
    // competes with other GestureDetectors, the disambiguation process will complete
    // after the global pointer event is received. As we can't rely on the global
    // pointer events to dismiss the Tooltip, we have to call _handleMouseExit
    // to dismiss the tooltip after _showDuration expired.
    _handleMouseExit();
  }

  @override
  Widget build(BuildContext context) {
    // If message is empty then no need to create a tooltip overlay to show
    // the empty black container so just return the wrapped child as is or
    // empty container if child is not specified.
    if (_tooltipMessage.isEmpty) {
      return widget.child ?? const SizedBox.shrink();
    }
    assert(debugCheckHasOverlay(context));
    final TooltipThemeData tooltipTheme = TooltipTheme.of(context);

    _height = tooltipTheme.constraints?.minHeight ?? 24.0;
    _verticalOffset = tooltipTheme.verticalOffset ?? _defaultVerticalOffset;
    _preferBelow =
        widget.preferBelow ?? tooltipTheme.preferBelow ?? _defaultPreferBelow;

    Widget result = Semantics(tooltip: _tooltipMessage, child: widget.child);

    result = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleTap,
      excludeFromSemantics: true,
      child: result,
    );
    // Only check for hovering if there is a mouse connected.
    if (_mouseIsConnected) {
      result = MouseRegion(
        onEnter: (_) => _handleMouseEnter(),
        onExit: (_) => _handleMouseExit(),
        child: result,
      );
    }
    return result;
  }
}

class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  _TooltipPositionDelegate({
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
  });

  final Offset target;

  final double verticalOffset;

  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final offset = positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
    return offset;
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    required this.height,
    required this.richMessage,
    required this.animation,
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
    this.onEnter,
    this.onExit,
  });

  final InlineSpan richMessage;
  final double height;
  final Animation<double> animation;
  final Offset target;
  final double verticalOffset;
  final bool preferBelow;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget result = IgnorePointer(
      child: FadeTransition(
        opacity: animation,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height, maxWidth: 320),
          child: Container(
            margin: theme.tooltipTheme.margin,
            decoration: theme.tooltipTheme.decoration,
            padding: theme.tooltipTheme.padding,
            child: DefaultTextStyle(
              style: theme.textTheme.bodyMedium!.merge(
                theme.tooltipTheme.textStyle,
              ),
              textAlign: theme.tooltipTheme.textAlign,
              child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Text.rich(richMessage),
              ),
            ),
          ),
        ),
      ),
    );
    if (onEnter != null || onExit != null) {
      result = MouseRegion(onEnter: onEnter, onExit: onExit, child: result);
    }
    return Positioned.fill(
      bottom: MediaQuery.maybeViewInsetsOf(context)?.bottom ?? 0.0,
      child: CustomSingleChildLayout(
        delegate: _TooltipPositionDelegate(
          target: target,
          verticalOffset: verticalOffset,
          preferBelow: preferBelow,
        ),
        child: result,
      ),
    );
  }
}
