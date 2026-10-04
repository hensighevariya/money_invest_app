import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_components/ui_components.dart';

Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool showDragHandle = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    scrollControlDisabledMaxHeightRatio: 1.0,
    useSafeArea: true,
    builder: (context) {
      return _CommonBottomSheet(
        builder: builder,
        showDragHandle: showDragHandle,
        isScrollControlled: isScrollControlled,
      );
    },
  );
}

class _CommonBottomSheet extends StatelessWidget {
  const _CommonBottomSheet({required this.builder, this.showDragHandle = true, this.isScrollControlled = true});

  final WidgetBuilder builder;
  final bool showDragHandle;
  final bool isScrollControlled;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQueryData.fromView(View.of(context));
    final double maxHeight = mediaQuery.size.height - mediaQuery.viewPadding.top - 24;

    Widget content;
    if (isScrollControlled) {
      content = DraggableScrollableSheet(
        expand: false,
        initialChildSize: 1.0,
        maxChildSize: 1.0,
        minChildSize: 0.5,
        snap: true,
        builder: (context, scrollController) {
          return PrimaryScrollController(
            controller: scrollController,
            child: ClipPath(child: Builder(builder: builder)),
          );
        },
      );
    } else {
      content = ClipPath(child: Builder(builder: builder));
    }

    content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDragHandle) const _DragHandle(),
        Flexible(child: content),
        Gap(context.mediaQueryInsets.bottom),
      ],
    );

    return ConstrainedBox(constraints: BoxConstraints(maxHeight: maxHeight), child: content);
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size handleSize = theme.bottomSheetTheme.dragHandleSize ?? const Size(32, 4);
    final Color handleColor =
        theme.bottomSheetTheme.dragHandleColor ?? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5);

    return Semantics(
      label: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      container: true,
      child: Material(
        color: theme.bottomSheetTheme.backgroundColor ?? theme.colorScheme.surfaceContainerLow,
        child: SizedBox(
          height: 24,
          child: Center(
            child: Container(
              height: handleSize.height,
              width: handleSize.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(handleSize.height / 2), color: handleColor),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetLayout extends StatelessWidget {
  const BottomSheetLayout({super.key, required this.content, this.header, this.bottom});

  final Widget? header;
  final Widget content;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) ...[header!, const Divider(height: 1, endIndent: 0, indent: 0)],
        Flexible(child: content),
        if (bottom != null) bottom!,
      ],
    );
  }
}

class BottomSheetHeader extends StatelessWidget implements PreferredSizeWidget {
  const BottomSheetHeader({super.key, required this.title, this.action, this.autoImplyTrailing = true});

  final Widget? title;
  final Widget? action;
  final bool autoImplyTrailing;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? middle;
    if (title != null) {
      middle = DefaultTextStyle.merge(style: theme.textTheme.titleLarge, textAlign: TextAlign.center, child: title!);
    }

    Widget? trailing = action;
    if (action == null && autoImplyTrailing) {
      trailing = CloseButton(
        style: IconButton.styleFrom(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          foregroundColor: theme.colorScheme.onSurface,
        ),
      );
    }

    return Material(
      color: theme.bottomSheetTheme.backgroundColor ?? theme.colorScheme.surfaceContainerLow,
      child: SafeAreaDirectional(
        bottom: false,
        minimum: const EdgeInsetsDirectional.only(start: Spacing.normal, end: Spacing.small),
        child: SizedBox(
          height: kToolbarHeight,
          child: NavigationToolbar(centerMiddle: false, middleSpacing: 0, middle: middle, trailing: trailing),
        ),
      ),
    );
  }
}
