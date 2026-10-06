import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/data/model/auth_navigation_data_model.dart';
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
      context.go(
        '${context.currentPath}/verify-otp',
        extra: AuthNavigationDataModel(
          type: response.type,
          token: response.token,
          verifyType: response.verifyType,
          resetByMobile: isOnlyDigit(state.emailMobileInput.value),
          emailMobileInput: isOnlyDigit(state.emailMobileInput.value)
              ? '+${state.emailMobileInput.phoneDetail?.code} ${state.emailMobileInput.value}'
              : state.emailMobileInput.value,
        ),
      );
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
