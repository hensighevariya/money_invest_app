import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

import 'loading_indicator.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({super.key, this.icon, required this.title, this.description, this.action});

  final Widget? icon;
  final String title;
  final String? description;
  final EmptyViewAction? action;

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = context.theme;

    return Center(
      child: ConstrainedBox(
        constraints: LayoutConstraints.emptyView,
        child: Column(
          spacing: Spacing.xLarge,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 320, maxHeight: 320),
                  child: Center(heightFactor: 1.0, widthFactor: 1.0, child: icon),
                ),
              ),
            Column(
              spacing: Spacing.small,
              children: [
                DefaultTextStyle.merge(style: textTheme.titleLarge, textAlign: TextAlign.center, child: Text(title)),
                if (!description.isNullOrEmpty) ...[
                  Text(
                    description ?? '',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
            if (action != null) ...[action!],
          ],
        ),
      ),
    );
  }
}

class EmptyViewAction extends StatelessWidget {
  const EmptyViewAction({super.key, required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size(200, 48)),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class EmptyStateView<B extends BlocBase<BaseState>> extends StatelessWidget {
  const EmptyStateView({super.key, required this.placeholder, this.loadingWidget, required this.onRetry});

  final Widget placeholder;
  final Widget? loadingWidget;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final loading = context.select<B, bool>((value) => value.state.loading);
    if (loading) {
      return loadingWidget ?? const Center(child: LoadingIndicator());
    }

    final error = context.select<B, Object?>((value) => value.state.error);
    if (error != null) {
      return Center(
        child: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.all(Spacing.normal),
            child: DataErrorView(error: error, onRetry: onRetry),
          ),
        ),
      );
    }

    return placeholder;
  }
}

class DataErrorView extends StatelessWidget {
  const DataErrorView({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    switch (error) {
      case NetworkConnectionException():
        return InternetErrorView(onRetry: onRetry);

      case InternalServerException():
        return ServerErrorView(onRetry: onRetry);

      default:
        return UnknownErrorView(onRetry: onRetry);
    }
  }
}

class InternetErrorView extends StatelessWidget {
  const InternetErrorView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return EmptyDataView(
      icon: LottieBuilder.asset(LottieFiles.noInternet, fit: BoxFit.contain),
      title: localizations.internetErrorTitle,
      description: localizations.internetErrorDescription,
      action: EmptyViewAction(onPressed: onRetry, label: localizations.tryAgainButtonLabel),
    );
  }
}

class ServerErrorView extends StatelessWidget {
  const ServerErrorView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return EmptyDataView(
      icon: LottieBuilder.asset(LottieFiles.serverError, fit: BoxFit.contain),
      title: localizations.serverErrorTitle,
      description: localizations.serverErrorDescription,
      action: EmptyViewAction(onPressed: onRetry, label: localizations.tryAgainButtonLabel),
    );
  }
}

class UnknownErrorView extends StatelessWidget {
  const UnknownErrorView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;
    return EmptyDataView(
      icon: LottieBuilder.asset(LottieFiles.somethingWentWrong, fit: BoxFit.contain),
      title: localizations.unknownErrorTitle,
      description: localizations.unknownErrorDescription,
      action: EmptyViewAction(onPressed: onRetry, label: localizations.tryAgainButtonLabel),
    );
  }
}
