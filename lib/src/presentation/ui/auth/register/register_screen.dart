import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/constraints.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/presentation/ui/auth/widgets/auth_title.dart';

import 'logic/register_cubit.dart';
import 'logic/register_state.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _onStatusChanged(BuildContext context, RegisterState state) {
    if (state.status case ProgressStatusSuccess<void>()) {
      context.go('${context.currentPath}/register-verify-otp', extra: {
        'mobile': '+${state.mobileInput.phoneDetail?.code} ${state.mobileInput.value}',
        'email': state.emailInput.value,
      });
    } else if (state.status case ProgressStatusFailed<Object>(:final error)) {
      // show error
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
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
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(showLeading: true, color: context.colorScheme.surface),
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
                  const AuthTitle(
                    title: "Register",
                    description: TextSpan(text: "Create a new account"),
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
                  style: ElevatedButtonPrimaryStyle(context, buttonColor: context.colorScheme.primary),
                  onPressed: !isValid ? null : () => context.read<RegisterCubit>().onContinue(),
                  child: const Text("Sign Up"),
                );
              },
            ),
            const Gap(Spacing.normal),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: Text(
                    "Sign In",
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
