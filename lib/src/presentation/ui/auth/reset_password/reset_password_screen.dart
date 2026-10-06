import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/model/auth_navigation_data_model.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/utils/loading_dialog_handler.dart';

import 'logic/reset_password_cubit.dart';
import 'logic/reset_password_state.dart';
import 'widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, this.data});

  final AuthNavigationDataModel? data;

  Future<void> _onStatusChanged(
    BuildContext context,
    ResetPasswordState state,
  ) async {
    if (state.status case ProgressStatusSuccess<bool>()) {
      await showDialog<void>(
        context: context,
        builder: (context) => const ResetPasswordSuccessModal(),
      );
      if (context.mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ResetPasswordCubit(
          type: data?.type ?? 0,
          verificationToken: data?.token ?? '',
          authRepository: RepositoryProvider.of(context),
          loadingHandler: LoadingDialogHandler(context: context),
        );
      },
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _onStatusChanged,
        child: const _ResetPasswordView(),
      ),
    );
  }
}

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(color: context.colorScheme.surface),
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.all(Spacing.large),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: LayoutConstraints.forms,
                  child: const Form(child: ResetPasswordForm()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResetPasswordSuccessModal extends StatelessWidget {
  const ResetPasswordSuccessModal({super.key});

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
      title: localizations.resetPasswordSuccessTitle,
      description: localizations.resetPasswordSuccessDescription,
      action: ElevatedButton(
        style: ElevatedButtonPrimaryStyle(context),
        onPressed: () => context.navigator.pop(),
        child: Text(localizations.continueButtonLabel),
      ),
    );
  }
}
