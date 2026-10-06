import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class TradingDiaryViewScreen extends StatelessWidget {
  const TradingDiaryViewScreen({super.key});

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
        child: ListView(
          padding: const EdgeInsets.all(Spacing.large),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.large,
                vertical: Spacing.medium,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '12 Mar 2024',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ],
              ),
            ),
            const Gap(Spacing.large),

            Container(
              padding: const EdgeInsets.all(Spacing.large),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localizations.tradingDiaryTotalPnL,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '+ ₹ 25,450',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(Spacing.large),

            _buildTradeItem(
              context,
              'NIFTY 22A01D CE',
              '150',
              '120',
              '150',
              '180',
              '9,000',
              '09:30 AM',
            ),
            const Divider(height: Spacing.xLarge * 2),
            _buildTradeItem(
              context,
              'BANKNIFTY 48000 PE',
              '100',
              '200',
              '100',
              '250',
              '5,000',
              '11:15 AM',
            ),
            const Divider(height: Spacing.xLarge * 2),
            _buildTradeItem(
              context,
              'NIFTY 22500 PE',
              '200',
              '95',
              '200',
              '120',
              '5,000',
              '02:30 PM',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeItem(
    BuildContext context,
    String title,
    String buyQty,
    String buyPrice,
    String sellQty,
    String sellPrice,
    String pnl,
    String time,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.orange.shade600,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange.shade200, width: 2),
          ),
        ),
        const Gap(Spacing.medium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    time,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              const Gap(Spacing.small),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.localizations.tradingDiaryBuy(
                            buyQty,
                            buyPrice,
                          ),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          context.localizations.tradingDiarySell(
                            sellQty,
                            sellPrice,
                          ),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '+ ₹ $pnl',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Gap(Spacing.medium),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(
                      Icons.picture_as_pdf_outlined,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
