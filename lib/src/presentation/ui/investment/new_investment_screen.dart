import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class NewInvestmentScreen extends StatefulWidget {
  const NewInvestmentScreen({super.key});

  @override
  State<NewInvestmentScreen> createState() => _NewInvestmentScreenState();
}

class _NewInvestmentScreenState extends State<NewInvestmentScreen> {
  String _selectedAmount = '1,00,000';
  String _selectedPaymentMethod = 'UPI';

  Widget _buildAmountButton(String amount, String label) {
    final bool isSelected = _selectedAmount == amount;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedAmount = amount;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Spacing.medium),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? context.colorScheme.primary
                  : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: context.textTheme.titleMedium?.copyWith(
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
    String method,
    String title,
    IconData icon,
    bool isRecommended,
  ) {
    final bool isSelected = _selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: Spacing.medium),
        padding: const EdgeInsets.all(Spacing.medium),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primary.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? context.colorScheme.primary
                  : Colors.grey.shade600,
              size: 24,
            ),
            const Gap(Spacing.medium),
            Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        title: context.localizations.investNewInvestment,
        color: context.colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localizations.investAmount,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(Spacing.medium),
              Row(
                children: [
                  _buildAmountButton('50,000', '₹ 50,000'),
                  const Gap(Spacing.medium),
                  _buildAmountButton('1,00,000', '₹ 1,00,000'),
                ],
              ),
              const Gap(Spacing.medium),
              Row(
                children: [
                  _buildAmountButton('2,00,000', '₹ 2,00,000'),
                  const Gap(Spacing.medium),
                  _buildAmountButton(
                    'Custom',
                    context.localizations.investCustom,
                  ),
                ],
              ),
              const Gap(Spacing.xLarge),
              Text(
                context.localizations.investPaymentMethod,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(Spacing.medium),
              _buildPaymentMethod(
                'UPI',
                context.localizations.investUpi,
                Icons.account_balance_wallet_outlined,
                true,
              ),
              _buildPaymentMethod(
                'NetBanking',
                context.localizations.investNetBanking,
                Icons.account_balance_outlined,
                false,
              ),
              _buildPaymentMethod(
                'IMPS',
                context.localizations.investImpsNeft,
                Icons.compare_arrows_outlined,
                false,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.large),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context.go('${context.currentPath}/payment-gateway');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                context.localizations.investProceedToPay,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
