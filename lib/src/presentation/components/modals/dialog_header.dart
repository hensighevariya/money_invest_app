import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:ui_components/ui_components.dart';

class ModalDialogHeader extends StatelessWidget implements PreferredSizeWidget {
  const ModalDialogHeader({
    super.key,
    required this.title,
    this.autoImplyTrailing = true,
    this.centerTitle = true,
    this.trailing,
  });

  final Widget title;
  final bool autoImplyTrailing;
  final bool centerTitle;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = context.theme;

    Widget? trailing = this.trailing;
    if (trailing == null && autoImplyTrailing) {
      trailing = IconButton(
        onPressed: () => context.navigator.pop(),
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
        icon: const SvgIcon(SvgIcons.closeCircle),
      );
    }

    return SizedBox.fromSize(
      size: preferredSize,
      child: NavigationToolbar(
        centerMiddle: centerTitle,
        middle: DefaultTextStyle.merge(style: textTheme.titleLarge, textAlign: TextAlign.center, child: title),
        trailing: IconButton(
          onPressed: () => context.navigator.pop(),
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
          icon: const SvgIcon(SvgIcons.closeCircle),
        ),
      ),
    );
  }
}
