import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class PaymentGatewayScreen extends StatelessWidget {
  const PaymentGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        title: context.localizations.investCompletePayment,
        color: context.colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₹ 1,00,000',
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              const Gap(Spacing.xLarge),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.localizations.investSelectUpiApp,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Gap(Spacing.medium),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildUpiAppIcon(
                    context,
                    'assets/icons/svg_icon/gpay.svg',
                    context.localizations.investGPay,
                    Icons.account_balance_wallet,
                  ),
                  _buildUpiAppIcon(
                    context,
                    'assets/icons/svg_icon/phonepe.svg',
                    context.localizations.investPhonePe,
                    Icons.payment,
                  ),
                  _buildUpiAppIcon(
                    context,
                    'assets/icons/svg_icon/paytm.svg',
                    context.localizations.investPaytm,
                    Icons.mobile_friendly,
                  ),
                  _buildUpiAppIcon(
                    context,
                    'assets/icons/svg_icon/others.svg',
                    context.localizations.investOthers,
                    Icons.apps,
                  ),
                ],
              ),
              const Gap(Spacing.xLarge),

              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.medium,
                    ),
                    child: Text(
                      context.localizations.investOr,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const Gap(Spacing.xLarge),

              _buildOtherPaymentMethod(
                context,
                context.localizations.investNetBanking,
                Icons.account_balance,
              ),
              _buildOtherPaymentMethod(
                context,
                context.localizations.investDebitCreditCard,
                Icons.credit_card,
              ),

              const Gap(Spacing.xLarge * 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security, color: Colors.grey.shade600, size: 16),
                  const Gap(Spacing.xSmall),
                  Text(
                    context.localizations.investSecuredByRazorpay,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
                context.go('${context.currentPath}/success');
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

  Widget _buildUpiAppIcon(
    BuildContext context,
    String svgPath,
    String name,
    IconData fallbackIcon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Spacing.medium),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(
            fallbackIcon,
            size: 28,
            color: context.colorScheme.primary,
          ),
        ),
        const Gap(Spacing.small),
        Text(name, style: context.textTheme.labelMedium),
      ],
    );
  }

  Widget _buildOtherPaymentMethod(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: Spacing.medium),
      padding: const EdgeInsets.all(Spacing.medium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const Gap(Spacing.medium),
          Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
