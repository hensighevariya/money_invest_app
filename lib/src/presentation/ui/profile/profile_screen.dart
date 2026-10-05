import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/components/common_divider.dart';
import 'package:money_invest_app/src/presentation/components/menu_list.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:ui_components/ui_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        title: context.localizations.profileTitle,
        color: context.colorScheme.surface,
      ),
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            top: false,
            bottom: false,
            minimum: const EdgeInsets.symmetric(vertical: Spacing.large),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: context.colorScheme.onSurface,
                      child: const SvgIcon(SvgIcons.icnPerson, size: 40),
                    ),
                    const Gap(Spacing.normal),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rahul Patel",
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(Spacing.xSmall),
                        Text(
                          "+91 98765 43210",
                          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Gap(Spacing.xLarge)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MenuListWidget(
                  title: context.localizations.profilePersonalInformation,
                  icon: SvgIcons.icnPerson,
                  onTap: () {},
                ),
                CommonDivider(paddingSize: Spacing.xMedium),
                MenuListWidget(title: context.localizations.profileBankAccount, icon: SvgIcons.icnBank, onTap: () {}),
                CommonDivider(paddingSize: Spacing.xMedium),
                MenuListWidget(
                  title: context.localizations.profileChangePassword,
                  icon: SvgIcons.icnLock,
                  onTap: () {},
                ),
                CommonDivider(paddingSize: Spacing.xMedium),
                MenuListWidget(
                  title: context.localizations.profileNotificationSettings,
                  icon: SvgIcons.icnNotification,
                  onTap: () {},
                  isNotification: true,
                  widget: Switch(value: true, onChanged: (value) {}),
                ),
                CommonDivider(paddingSize: Spacing.xMedium),
                MenuListWidget(
                  title: context.localizations.profileLanguage,
                  icon: SvgIcons.icnLanguage,
                  onTap: () {},
                  isNotification: true,
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.localizations.profileLanguageEnglish,
                        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                      ),
                      const Gap(Spacing.xSmall),
                      const SvgIcon(SvgIcons.arrowRight, size: 20),
                    ],
                  ),
                ),
                CommonDivider(paddingSize: Spacing.xMedium),
                MenuListWidget(
                  title: context.localizations.profileHelpAndSupport,
                  icon: SvgIcons.icnHelp,
                  onTap: () {},
                ),
                CommonDivider(paddingSize: Spacing.xMedium),
                MenuListWidget(
                  title: context.localizations.profileLogout,
                  icon: SvgIcons.icnLogout,
                  onTap: () {},
                  isNotification: true,
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: Gap(Spacing.xLarge)),
        ],
      ),
    );
  }
}
