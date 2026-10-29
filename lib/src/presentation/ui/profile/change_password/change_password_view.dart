import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:money_invest_app/src/core/base/exceptions.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/localization/localization.dart';
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
      backgroundColor: const Color(0xFF12151D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12151D),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home/profile');
            }
          },
        ),
        title: Text(
          localizations.changePasswordScreenTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: LayoutConstraints.forms,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  localizations.changePasswordDesc,
                  style: const TextStyle(
                    color: Color(0xFF8E95A5),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const Gap(24),
                const ChangePasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChangePasswordSuccessModal extends StatelessWidget {
  const _ChangePasswordSuccessModal();

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return Dialog(
      backgroundColor: const Color(0xFF1C202C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              LottieFiles.password,
              height: 120,
              fit: BoxFit.contain,
              repeat: true,
            ),
            const Gap(16),
            Text(
              localizations.changePasswordSuccessTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            Text(
              localizations.changePasswordSuccessDescription,
              style: const TextStyle(
                color: Color(0xFF8E95A5),
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E73F8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  localizations.continueButtonLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

