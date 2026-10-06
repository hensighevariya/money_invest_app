import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class TradingDiarySubscriptionScreen extends StatefulWidget {
  const TradingDiarySubscriptionScreen({super.key});

  @override
  State<TradingDiarySubscriptionScreen> createState() =>
      _TradingDiarySubscriptionScreenState();
}

class _TradingDiarySubscriptionScreenState
    extends State<TradingDiarySubscriptionScreen> {
  String _selectedPlan = 'monthly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        title: context.localizations.tradingDiaryTitle,
        color: context.colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(Spacing.large),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5E27E8), Color(0xFF9C41FA)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 32),
                    const Gap(Spacing.medium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.localizations.tradingDiaryPremium,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(Spacing.xSmall),
                          Text(
                            context.localizations.tradingDiaryPremiumDesc,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Spacing.xLarge),

              _buildPlanCard(
                'monthly',
                context.localizations.tradingDiaryMonthlyPlan,
                context.localizations.tradingDiaryMonthlyPrice('499'),
                null,
              ),
              const Gap(Spacing.medium),
              _buildPlanCard(
                'yearly',
                context.localizations.tradingDiaryYearlyPlan,
                context.localizations.tradingDiaryYearlyPrice('4,999'),
                context.localizations.tradingDiarySavePercent('17'),
              ),

              const Gap(Spacing.xLarge),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/home/trading-diary/view');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    context.localizations.tradingDiarySubscribe,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const Gap(Spacing.xLarge * 1.5),

              _buildFeatureItem(context.localizations.tradingDiaryFeature1),
              _buildFeatureItem(context.localizations.tradingDiaryFeature2),
              _buildFeatureItem(context.localizations.tradingDiaryFeature3),
              _buildFeatureItem(context.localizations.tradingDiaryFeature4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    String id,
    String title,
    String subtitle,
    String? badge,
  ) {
    final bool isSelected = _selectedPlan == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(Spacing.large),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected
                  ? context.colorScheme.primary
                  : Colors.grey.shade400,
            ),
            const Gap(Spacing.medium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Gap(Spacing.xSmall),
                  Text(
                    subtitle,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else if (isSelected)
              Icon(
                Icons.verified,
                color: context.colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.medium),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 12),
          ),
          const Gap(Spacing.medium),
          Text(
            feature,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
