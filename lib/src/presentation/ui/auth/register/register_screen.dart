import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/alert_message.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/presentation/ui/auth/widgets/auth_title.dart';
import 'package:money_invest_app/src/utils/loading_dialog_handler.dart';

import 'logic/register_cubit.dart';
import 'logic/register_state.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _onStatusChanged(BuildContext context, RegisterState state) {
    if (state.status case ProgressStatusSuccess<dynamic>(:final result)) {
      final registerResponse = result is RegisterResponse ? result : null;
      context.go(
        '${context.currentPath}/register-verify-otp',
        extra: {
          'mobile':
              '+${state.mobileInput.phoneDetail?.code ?? '91'} ${state.mobileInput.value}',
          'email': state.emailInput.value,
          'emailToken': registerResponse?.emailVerificationToken ??
              registerResponse?.token ??
              '',
          'mobileToken': registerResponse?.mobileVerificationToken ??
              registerResponse?.token ??
              '',
        },
      );
    } else if (state.status case ProgressStatusFailed<Object>(:final error)) {
      showErrorMessage(context: context, content: _getErrorMessage(error));
    }
  }

  String _getErrorMessage(Object? error) {
    if (error is InvalidResponseException) {
      if (error.errors != null && error.errors!.isNotEmpty) {
        final firstError = error.errors!.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
        return firstError.toString();
      }
      if (error.message != null && error.message!.isNotEmpty) {
        return error.message!;
      }
    }
    if (error is String && error.isNotEmpty) {
      return error;
    }
    return error?.toString() ?? 'Something went wrong';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        authRepository: RepositoryProvider.of(context),
        loadingHandler: LoadingDialogHandler(context: context),
      )..loadCountries(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _onStatusChanged,
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        color: context.colorScheme.surface,
      ),
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.all(Spacing.large),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.appLargeLogo,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Gap(Spacing.xxxLarge),
                  AuthTitle(
                    title: localizations.registerTitle,
                    description: TextSpan(
                      text: localizations.registerSubtitle,
                    ),
                  ),
                  const Gap(Spacing.xxxLarge),
                  Center(
                    child: ConstrainedBox(
                      constraints: LayoutConstraints.forms,
                      child: const Form(child: RegisterForm()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(Spacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocSelector<RegisterCubit, RegisterState, bool>(
              selector: (state) => state.isFormValid,
              builder: (context, isValid) {
                return ElevatedButton(
                  style: ElevatedButtonPrimaryStyle(
                    context,
                    buttonColor: context.colorScheme.primary,
                  ),
                  onPressed: !isValid
                      ? null
                      : () => context.read<RegisterCubit>().onContinue(),
                  child: Text(localizations.registerButtonLabel),
                );
              },
            ),
            const Gap(Spacing.normal),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.alreadyHaveAccount,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: Text(
                    localizations.signIn,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
