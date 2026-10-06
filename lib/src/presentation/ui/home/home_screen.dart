import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/localization/localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const Gap(24),
              _buildTotalInvestmentCard(context),
              const Gap(16),
              _buildMiniCards(context),
              const Gap(24),
              _buildActionGrid(context),
              const Gap(24),
              _buildBanner(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => context.go('/home/profile'),
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFF0F0F0),
                // Use a generic icon if no profile image is available
                child: Icon(Icons.person, color: Colors.grey),
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localizations.homeHello,
                  style: const TextStyle(color: Color(0xFF333333), fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Rahul Patel',
                  style: TextStyle(color: Color(0xFF1A1A1A), fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A5BBB).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications, color: Color(0xFF1A5BBB), size: 24),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalInvestmentCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A5BBB), Color(0xFF0F3B84)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: const Color(0xFF1A5BBB).withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localizations.homeTotalInvestment,
                style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Gap(8),
              Text(
                '₹ 5,00,000',
                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Gap(24),
              Text(
                context.localizations.homeTotalReturnsReceived,
                style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Gap(4),
              Text(
                '₹ 80,000',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(15),
                const Gap(4),
                _buildBar(25),
                const Gap(4),
                _buildBar(40),
                const Gap(4),
                _buildBar(55),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double height) {
    return Container(
      width: 10,
      height: height,
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildMiniCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMiniCard(
            title: context.localizations.homeActiveInvestments,
            value: '3',
            bottomWidget: Text(
              context.localizations.homeViewDetails,
              style: const TextStyle(color: Color(0xFF1A5BBB), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: _buildMiniCard(
            title: context.localizations.homeMonthlyReturn,
            value: '8%',
            bottomWidget: Text(
              context.localizations.homePerMonth,
              style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniCard({required String title, required String value, required Widget bottomWidget}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xFF4A4A4A), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const Gap(12),
          Text(
            value,
            style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Gap(12),
          bottomWidget,
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          title: context.localizations.homeInvestNow,
          icon: Icons.check_circle_outline,
          color: const Color(0xFF1A5BBB),
          onTap: () {
            context.go('${context.currentPath}/new-investment');
          },
        ),
        _buildActionButton(
          title: context.localizations.homeMyBonds,
          icon: Icons.calculate_outlined,
          color: const Color(0xFF38B2AC),
          onTap: () {
            context.go('${context.currentPath}/my-investments');
          },
        ),
        _buildActionButton(
          title: context.localizations.homeTradeDiary,
          icon: Icons.menu_book_outlined,
          color: const Color(0xFF805AD5),
          onTap: () {
            context.go('${context.currentPath}/trading-diary');
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const Gap(8),
          Text(
            title,
            style: const TextStyle(color: Color(0xFF4A4A4A), fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localizations.homeTransparentTrading,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Gap(4),
              Text(
                context.localizations.homeRealTradesProof,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const Gap(16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: Text(
                  context.localizations.homeSubscribeNow,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          // A placeholder for the line chart image shown in the banner
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(Icons.show_chart, color: Colors.white.withValues(alpha: 0.2), size: 80),
          ),
        ],
      ),
    );
  }
}
