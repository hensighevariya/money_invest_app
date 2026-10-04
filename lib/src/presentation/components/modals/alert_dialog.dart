import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, this.icon, required this.title, required this.description, required this.action});

  final Widget? icon;
  final String title;
  final String? description;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = context.theme;

    return Dialog(
      child: ConstrainedBox(
        constraints: LayoutConstraints.modalDialog,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.large),
          child: DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: Column(
              spacing: Spacing.xLarge,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ConstrainedBox(constraints: const BoxConstraints(maxHeight: 160), child: icon!),
                Column(
                  spacing: Spacing.small,
                  children: [
                    DefaultTextStyle.merge(
                      style: textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                      child: Text(title),
                    ),
                    if (description != null)
                      DefaultTextStyle.merge(textAlign: TextAlign.center, child: Text(description!)),
                  ],
                ),
                action,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
