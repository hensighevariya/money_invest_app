import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class MonthlyReturnsScreen extends StatelessWidget {
  const MonthlyReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        showLeading: true,
        title: context.localizations.monthlyReturnsTitle,
        color: Colors.grey.shade100,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Spacing.large),
          children: [
            _buildReturnCard(context, '01 Apr 2024', '8,000', 'IMPS'),
            const Gap(Spacing.medium),
            _buildReturnCard(context, '01 Mar 2024', '8,000', 'IMPS'),
            const Gap(Spacing.medium),
            _buildReturnCard(context, '01 Feb 2024', '8,000', 'IMPS'),
            const Gap(Spacing.medium),
            _buildReturnCard(context, '01 Jan 2024', '8,000', 'IMPS'),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnCard(
    BuildContext context,
    String date,
    String amount,
    String method,
  ) {
    return Container(
      padding: const EdgeInsets.all(Spacing.large),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                ),
              ),
              const Gap(Spacing.small),
              Text(
                '₹ $amount',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(Spacing.small),
              Text(
                context.localizations.monthlyReturnsPaidVia(method),
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              context.localizations.monthlyReturnsPaid,
              style: context.textTheme.labelMedium?.copyWith(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
