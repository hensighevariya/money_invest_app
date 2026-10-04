import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:ui_components/ui_components.dart';

import '../../resources/assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final l10n = context.localizations;
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xLarge, vertical: Spacing.xxLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              
              // App Logo
              Center(
                child: Image.asset(
                  AppImages.appLargeLogo,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(flex: 1),
              const SizedBox(height: Spacing.large),
              Text(
                l10n.loginTitle,
                style: textTheme.headlineLarge?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Spacing.small),
              Text(l10n.loginSubtitle, style: textTheme.titleMedium),
              const SizedBox(height: Spacing.xxLarge),

              // Mobile Number / Email Field
              CommonTextField(
                controller: _emailController,
                hintText: l10n.loginEmailHint,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.phone_android_rounded),
              ),
              const SizedBox(height: Spacing.large),

              // Password Field
              CommonTextField(
                controller: _passwordController,
                hintText: l10n.loginPasswordHint,
                obscureText: !_isPasswordVisible,
                prefixIcon: Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: SvgIcon(_isPasswordVisible ? SvgIcons.icnEye : SvgIcons.icnEyeSlash),
                ),
              ),
              const SizedBox(height: Spacing.normal),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(l10n.loginForgotPassword, style: textTheme.labelLarge?.copyWith(color: colorScheme.secondary)),
                ),
              ),
              const SizedBox(height: Spacing.xLarge),

              // Login / Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    foregroundColor: colorScheme.onSecondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(l10n.loginButtonText, style: textTheme.titleMedium?.copyWith(color: colorScheme.onSecondary)),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
