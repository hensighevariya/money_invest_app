import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:money_invest_app/src/core/base/exceptions.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/utils/loading_dialog_handler.dart';

import 'logic/change_password_cubit.dart';
import 'logic/change_password_state.dart';
import 'widgets/change_password_form.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  Future<void> _onStatusChanged(
    BuildContext context,
    ChangePasswordState state,
  ) async {
    if (state.status case ProgressStatusSuccess<bool>()) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const _ChangePasswordSuccessModal(),
      );
      if (context.mounted) {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/home/profile');
        }
      }
    } else if (state.status case ProgressStatusFailed<Object>(:final error)) {
      if (error is! BaseException) {
        showErrorMessage(context: context, content: error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        userRepository: RepositoryProvider.of(context),
        loadingHandler: LoadingDialogHandler(context: context),
      ),
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _onStatusChanged,
        child: const _ChangePasswordView(),
      ),
    );
  }
}

class _ChangePasswordView extends StatelessWidget {
  const _ChangePasswordView();

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        title: localizations.changePasswordScreenTitle,
        color: context.colorScheme.surface,
      ),
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.all(Spacing.large),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: LayoutConstraints.forms,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        localizations.changePasswordDesc,
                        style: context.textTheme.bodyMedium,
                      ),
                      const Gap(Spacing.xLarge),
                      const Form(child: ChangePasswordForm()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChangePasswordSuccessModal extends StatelessWidget {
  const _ChangePasswordSuccessModal();

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return CustomAlertDialog(
      icon: LottieBuilder.asset(
        LottieFiles.password,
        height: 120,
        fit: BoxFit.contain,
        repeat: true,
      ),
      title: localizations.changePasswordSuccessTitle,
      description: localizations.changePasswordSuccessDescription,
      action: ElevatedButton(
        style: ElevatedButtonPrimaryStyle(context),
        onPressed: () => context.navigator.pop(),
        child: Text(localizations.continueButtonLabel),
      ),
    );
  }
}

