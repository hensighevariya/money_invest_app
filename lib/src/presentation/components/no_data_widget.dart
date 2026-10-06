import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class NoDataWidget extends StatelessWidget {
  final String? title;
  final bool showSubtitle;
  final String? subTitle;

  const NoDataWidget({
    super.key,
    this.title,
    this.showSubtitle = true,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return Padding(
      padding: PaddingValue.large,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgImageFromAsset.square(
            SvgIcons.icnEmptyFile,
            size: 90,
            fit: BoxFit.cover,
          ),
          const Gap(Spacing.large),
          Text(
            title ?? localizations.dataNotFound,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (showSubtitle) ...[
            const Gap(Spacing.medium),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width * 0.6),
              child: Text(
                subTitle ??
                    localizations.whoopsThisInformationIsNotAvailableForAMoment,
                textAlign: TextAlign.center,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
