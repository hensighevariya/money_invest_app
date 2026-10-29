import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/presentation/components/alert_message.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/constraints.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/utils/loading_dialog_handler.dart';
import 'package:money_invest_app/src/utils/validator.dart';
import 'logic/forgot_password_cubit.dart';
import 'logic/forgot_password_state.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  void _onStatusChanged(BuildContext context, ForgotPasswordState state) {
    if (state.status case ProgressStatusSuccess<ForgotPasswordResponse>(
      result: ForgotPasswordResponse response,
    )) {
      final isMobile = isOnlyDigit(state.emailMobileInput.value);
      context.go(
        '${context.currentPath}/verify-otp',
        extra: AuthNavigationDataModel(
          type: isMobile ? 1 : 2,
          token: response.token,
          verifyType: response.verifyType,
          resetByMobile: isMobile,
          emailMobileInput: isMobile
              ? '+${state.emailMobileInput.phoneDetail?.code} ${state.emailMobileInput.value}'
              : state.emailMobileInput.value,
        ),
      );
    } else if (state.status case ProgressStatusFailed<Object>(:final error)) {
      if (error is String) {
        showErrorMessage(context: context, content: error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPasswordCubit(
          authRepository: RepositoryProvider.of(context),
          loadingHandler: LoadingDialogHandler(context: context),
        );
      },
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _onStatusChanged,
        child: const _ForgotPasswordView(),
      ),
    );
  }
}

class _ForgotPasswordView extends StatelessWidget {
  const _ForgotPasswordView();

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
                  child: const Form(child: ForgotPasswordForm()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
