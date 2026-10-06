import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

class PermissionAlertDialog extends StatelessWidget {
  const PermissionAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.action,
  });

  final String title;
  final String description;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: LayoutConstraints.modalDialog,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalDialogHeader(title: Text(title)),
            Padding(
              padding: const EdgeInsets.all(Spacing.large),
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.center,
                child: DefaultTextStyle.merge(
                  textAlign: TextAlign.center,
                  child: Text(description),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Spacing.normal),
              child: action,
            ),
          ],
        ),
      ),
    );
  }
}
