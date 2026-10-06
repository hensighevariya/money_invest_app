import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/alert_message.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/constraints.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/presentation/ui/auth/widgets/auth_title.dart';
import 'package:money_invest_app/src/utils/loading_dialog_handler.dart';
import 'package:money_invest_app/src/presentation/presentation.dart';
import 'logic/login_cubit.dart';
import 'logic/login_state.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onStatusChanged(BuildContext context, LoginState state) {
    if (state.status case ProgressStatusSuccess<UserData>(
      result: UserData userData,
    )) {
      context.read<UserProfileBloc>().add(UserLoggedIn(userData));
      context.go('/home');
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
        return LoginCubit(
          authRepository: RepositoryProvider.of(context),
          userRepository: RepositoryProvider.of(context),
          loadingHandler: LoadingDialogHandler(context: context),
        );
      },

      child: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _onStatusChanged,
        child: const _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => SystemNavigator.pop(),
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: CustomAppBar(
          showLeading: false,
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
                    // App Logo
                    Center(
                      child: Image.asset(
                        AppImages.appLargeLogo,
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Gap(
                      context.height < 650
                          ? Spacing.xxxLarge
                          : (Spacing.xxxLarge + Spacing.xxxLarge),
                    ),
                    AuthTitle(
                      title: localizations.loginTitle,
                      description: TextSpan(text: localizations.loginSubtitle),
                    ),
                    const Gap(Spacing.xxxLarge),
                    Center(
                      child: ConstrainedBox(
                        constraints: LayoutConstraints.forms,
                        child: const Form(child: LoginForm()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
