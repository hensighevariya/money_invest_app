import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    final margin = AdaptiveLayout.marginOf(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          minimum: EdgeInsets.all(margin),
          child: EmptyDataView(
            icon: const SvgImageFromAsset.square(
              VectorImages.maintenance,
              size: 240,
            ),
            title: localizations.underMaintenanceTitle,
            description: localizations.underMaintenanceDescription,
          ),
        ),
      ),
    );
  }
}
