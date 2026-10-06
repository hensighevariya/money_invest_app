import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class DigitalBondScreen extends StatelessWidget {
  const DigitalBondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        showLeading: true,
        title: context.localizations.investInvestmentBond,
        color: Colors.grey.shade100,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.large),
          child: Container(
            padding: const EdgeInsets.all(Spacing.large),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.insert_chart,
                  size: 48,
                  color: context.colorScheme.primary,
                ),
                const Gap(Spacing.medium),

                Text(
                  context.localizations.investInvestmentAgreement,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(Spacing.xLarge),

                _buildRow(
                  context,
                  context.localizations.investInvestorName,
                  'John Doe',
                ),
                const Divider(),
                _buildRow(
                  context,
                  context.localizations.investAmount,
                  '₹ 1,00,000',
                ),
                const Divider(),
                _buildRow(
                  context,
                  context.localizations.investStartDate,
                  '12 Mar 2024',
                ),
                const Divider(),
                _buildRow(
                  context,
                  context.localizations.investMonthlyReturnRate,
                  '8.0%',
                ),
                const Divider(),
                _buildRow(
                  context,
                  context.localizations.investMaturityTerms,
                  context.localizations.investAsPerAgreement,
                ),
                const Gap(Spacing.xLarge),

                // Some placeholder lines mimicking text
                Container(
                  height: 8,
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                Container(
                  height: 8,
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.only(bottom: 8, right: 20),
                ),
                Container(
                  height: 8,
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.only(bottom: 8, right: 50),
                ),

                const Gap(Spacing.xLarge),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Download PDF
                    },
                    icon: const Icon(Icons.lock_outline, color: Colors.white),
                    label: Text(
                      context.localizations.investDownloadPdf,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade500,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
