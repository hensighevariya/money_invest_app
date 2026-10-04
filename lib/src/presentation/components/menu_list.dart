import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:ui_components/ui_components.dart';

import 'components.dart';

class SliverMenuList extends StatelessWidget {
  const SliverMenuList({super.key, required this.items});

  final List<Widget> items;

  Widget? _itemBuilder(BuildContext context, int index) {
    final child = items[index];
    return CompatConstrainedBox(child: child);
  }

  Widget? _separatorBuilder(BuildContext context, int index) {
    return const CompatConstrainedBox(child: Divider(indent: Spacing.normal, endIndent: Spacing.normal));
  }

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      top: false,
      bottom: false,
      sliver: SliverList.separated(
        itemCount: items.length,
        itemBuilder: _itemBuilder,
        separatorBuilder: _separatorBuilder,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Widget>('items', items));
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.trailing,
    this.autoImplyTrailing = true,
    this.color,
    this.contentPadding,
  });

  final Widget? icon;
  final Widget title;
  final Widget? trailing;
  final Color? color;
  final bool autoImplyTrailing;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);

    Widget? trailing = this.trailing;
    if (trailing == null && autoImplyTrailing) {
      trailing = const SvgIcon(SvgIcons.arrowRight);
    }

    if (trailing != null) {
      trailing = IconTheme.merge(data: IconThemeData(size: 20, color: colorScheme.onSurfaceVariant), child: trailing);
    }

    return ListTile(
      shape: Shapes.medium,
      leadingAndTrailingTextStyle: textTheme.bodyMedium,
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: Spacing.normal),
      iconColor: color ?? colorScheme.primary,
      textColor: color,
      onTap: onPressed,
      leading: icon,
      title: title,
      trailing: trailing,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget?>('icon', icon));
    properties.add(DiagnosticsProperty<Widget>('title', title));
    properties.add(DiagnosticsProperty<Widget?>('trailing', trailing));
    properties.add(ColorProperty('color', color));
    properties.add(DiagnosticsProperty<bool>('autoImplyTrailing', autoImplyTrailing));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry?>('contentPadding', contentPadding));
  }
}
