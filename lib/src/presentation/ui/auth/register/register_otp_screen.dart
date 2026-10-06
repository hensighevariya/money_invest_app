import 'dart:async';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/ui/auth/widgets/auth_title.dart';

class RegisterOtpScreen extends StatefulWidget {
  const RegisterOtpScreen({
    super.key,
    required this.mobile,
    required this.email,
  });

  final String mobile;
  final String email;

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  Timer? _timer;
  int _remainingSeconds = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  const AuthTitle(title: "OTP Verification"),
                  const Gap(Spacing.xxxLarge),
                  Text("Code will be sent to ${widget.mobile}"),
                  const Gap(Spacing.small),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Mobile verification code",
                      suffixText: _remainingSeconds > 0
                          ? "$_remainingSeconds Sec"
                          : null,
                      suffixIcon: _remainingSeconds == 0
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  _startTimer();
                                });
                              },
                              child: const Text("Resend"),
                            )
                          : null,
                    ),
                  ),
                  const Gap(Spacing.large),
                  Text("Code will be sent to ${widget.email}"),
                  const Gap(Spacing.small),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Email verification code",
                      suffixText: _remainingSeconds > 0
                          ? "$_remainingSeconds Sec"
                          : null,
                      suffixIcon: _remainingSeconds == 0
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  _startTimer();
                                });
                              },
                              child: const Text("Resend"),
                            )
                          : null,
                    ),
                  ),
                  const Gap(Spacing.xxLarge),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButtonPrimaryStyle(
                        context,
                        buttonColor: context.colorScheme.primary,
                      ),
                      onPressed: () {
                        // show success dialog and navigate to home
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Success"),
                            content: const Text(
                              "Account created successfully!",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                  context.go('/home');
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text("Verify"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
