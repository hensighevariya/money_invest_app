import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'components.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final VoidCallback? onPressed;
  final String? title;
  final Widget? titleWidget;
  final bool showLeading;
  final bool centerTitle;
  final Widget? leadingWidget;
  final List<Widget> action;
  final double? leadingWidth;
  final Color? color;
  final Color? foregroundColor;
  final Color? backIconColor;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.title,
    this.onPressed,
    this.centerTitle = true,
    this.showLeading = true,
    this.leadingWidget,
    this.action = const [],
    this.titleWidget,
    this.leadingWidth,
    this.color,
    this.foregroundColor,
    this.backIconColor,
    this.bottom,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: showLeading
          ? leadingWidget ??
                BackIcon(
                  onPressed: onPressed ?? context.navigator.pop,
                  color: backIconColor,
                )
          : const SizedBox.shrink(),
      centerTitle: centerTitle,
      leadingWidth:
          leadingWidth ?? (showLeading || centerTitle ? 56 : Spacing.large),
      backgroundColor: color ?? context.colorScheme.surfaceContainerHighest,
      title:
          titleWidget ??
          Text(
            title ?? '',
            style: context.theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
      actions: action,
      titleSpacing: 0,
      foregroundColor: foregroundColor,
      bottom: bottom,
    );
  }
}

class BackIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final String? icon;

  const BackIcon({super.key, this.onPressed, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return CommonIcon(
      onTap: onPressed ?? context.navigator.pop,
      icon: icon ?? SvgIcons.arrowLeft,
      iconColor: color ?? context.colorScheme.onSurface,
      matchTextDirection: true,
    );
  }
}

class CommonIcon extends StatelessWidget {
  final Color? color;
  final VoidCallback onTap;
  final String icon;
  final String? toolTip;
  final double? splashRadius;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final double? iconSize;
  final Color? iconColor;
  final double? padding;
  final bool matchTextDirection;

  const CommonIcon({
    super.key,
    this.color,
    required this.onTap,
    required this.icon,
    this.toolTip,
    this.splashRadius,
    this.decoration,
    this.height,
    this.width,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.matchTextDirection = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.comfortable,
      onPressed: () {},
      tooltip: toolTip,
      highlightColor: Colors.transparent,
      splashRadius: splashRadius,
      icon: Container(
        width: width ?? 44,
        height: height ?? 44,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration:
              decoration ?? BoxDecoration(shape: BoxShape.circle, color: color),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: EdgeInsets.all(padding ?? 10),
                child: SvgImageFromAsset.square(
                  icon,
                  fit: BoxFit.cover,
                  color: iconColor,
                  size: iconSize ?? 24,
                  matchTextDirection: matchTextDirection,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
