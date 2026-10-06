import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

class UpdateDetailView extends StatelessWidget {
  const UpdateDetailView({super.key, required this.versionData});

  final AppVersionData versionData;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    final textTheme = context.theme.textTheme;
    final margin = AdaptiveLayout.marginOf(context);

    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.all(margin),
      child: CompatConstrainedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: SvgImageFromAsset.square(
                VectorImages.appUpdate,
                size: 360,
              ),
            ),
            DefaultTextStyle.merge(
              textAlign: TextAlign.center,
              child: Column(
                spacing: Spacing.medium,
                children: [
                  Text(
                    localizations.updateAvailableTitle(versionData.version),
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    localizations.updateAvailableDescription,
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
