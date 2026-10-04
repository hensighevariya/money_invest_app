import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:ui_components/ui_components.dart';

import 'widgets/update_details.dart';

class ForceUpdateScreen extends StatelessWidget {
  final AppVersionData versionData;

  const ForceUpdateScreen({super.key, required this.versionData});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(child: UpdateDetailView(versionData: versionData)),
        bottomNavigationBar: BottomPersistenceBar(
          constraints: LayoutConstraints.compat,
          children: [
            ElevatedButton(
              onPressed: () => RepositoryProvider.of<CommonRepository>(context).redirectToStore(),
              style: ElevatedButtonPrimaryStyle(context),
              child: Text(localizations.updateNowButtonLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateAvailableBottomSheet extends StatelessWidget {
  final AppVersionData versionData;

  const UpdateAvailableBottomSheet({super.key, required this.versionData});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: UpdateDetailView(versionData: versionData)),
        BottomPersistenceBar(
          spacing: Spacing.small,
          children: [
            ElevatedButton(
              onPressed: () => RepositoryProvider.of<CommonRepository>(context).redirectToStore(),
              style: ElevatedButtonPrimaryStyle(context),
              child: Text(localizations.updateNowButtonLabel),
            ),
            TextButton(onPressed: () => context.navigator.pop(), child: Text(localizations.updateLaterButtonLabel)),
          ],
        ),
      ],
    );
  }
}
