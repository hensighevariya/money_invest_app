import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/presentation/components/common_circle_icon.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class MenuListWidget extends StatelessWidget {
  final String? icon;
  final String title;
  final String? svgIcon;
  final void Function()? onTap;
  final bool? isNotification;
  final bool showIcon;
  final bool showBullet;
  final Widget? widget;
  final int? badgeCount;

  const MenuListWidget({
    super.key,
    this.icon,
    this.svgIcon,
    required this.title,
    required this.onTap,
    this.isNotification,
    this.showIcon = true,
    this.showBullet = false,
    this.widget,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.theme.textTheme;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: showBullet ? const EdgeInsets.only(bottom: 2.0) : EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: Spacing.large, vertical: showIcon ? Spacing.none : Spacing.medium),
        constraints: showIcon ? const BoxConstraints(minHeight: 36, maxHeight: 46) : null,
        decoration: showBullet ? BoxDecoration(color: colorScheme.onSurface.withValues(alpha: 0.03)) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showIcon) ...[
              CommonCircularIcon(
                backgroundColor: colorScheme.onSurface.applyOpacity(0.1),
                foregroundColor: colorScheme.onSurface,
                icon: icon,
              ),
              const Gap(Spacing.normal),
            ] else if (showBullet) ...[
              Container(
                margin: const EdgeInsetsDirectional.only(start: 20, end: Spacing.normal),
                width: 6,
                height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.onSurface.withValues(alpha: 0.4)),
              ),
            ],
            Expanded(child: Text(title, style: textTheme.titleSmall)),
            if (badgeCount != null && badgeCount! > 0)
              Container(
                margin: const EdgeInsetsDirectional.only(end: Spacing.small),
                padding: const EdgeInsets.all(Spacing.xSmall),
                decoration: BoxDecoration(color: colorScheme.error, shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                alignment: Alignment.center,
                child: Text(
                  badgeCount! > 99 ? '99+' : badgeCount.toString(),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onError,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (!(isNotification ?? false))
              SvgImageFromAsset.square(
                svgIcon ?? SvgIcons.arrowRight,
                size: 18,
                color: colorScheme.onSurface,
                matchTextDirection: true,
              ),
            widget ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
