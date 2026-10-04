import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key, required this.title, this.description});

  final String title;
  final TextSpan? description;

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = context.theme;

    return Column(
      spacing: Spacing.xSmall,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.headlineMedium?.copyWith(color: colorScheme.primary)),
        if (description != null)
          Text.rich(description!, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
