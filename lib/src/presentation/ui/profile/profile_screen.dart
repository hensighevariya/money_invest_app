import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/presentation.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.select<UserProfileBloc, UserData?>((bloc) => bloc.state.data);

    final displayName = (userData?.fullName.isNotEmpty ?? false)
        ? userData!.fullName
        : ((userData?.firstName?.isNotEmpty ?? false)
              ? '${userData!.firstName} ${userData.lastName ?? ''}'.trim()
              : 'Shingala Gaurav Kishorbhai');

    final clientId = (userData?.clientId?.isNotEmpty ?? false) ? userData!.clientId! : 'S825544';

    return Scaffold(
      backgroundColor: const Color(0xFF12151D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12151D),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              )
            : null,
        title: const Text(
          'Your Account',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // User Profile Tile
                    _buildUserProfileTile(
                      context,
                      name: displayName,
                      clientId: clientId,
                      onTap: () => context.go('/home/profile/edit-profile'),
                    ),
                    const Gap(14),

                    // Kept Same Options as Old
                    _buildOldOptionsList(context, userData),
                    Gap(Spacing.large),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileTile(
    BuildContext context, {
    required String name,
    required String clientId,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1C202C),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF262C3E)),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFF252B3B),
              child: Icon(Icons.person, color: Color(0xFF547AFF), size: 26),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Gap(3),
                  Text('Client ID: $clientId', style: const TextStyle(color: Color(0xFF8E95A5), fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF547AFF), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildOldOptionsList(BuildContext context, UserData? userData) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C202C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF262C3E)),
      ),
      child: Column(
        children: [
          _buildOptionTile(
            icon: Icons.person_outline,
            title: context.localizations.profilePersonalInformation,
            subtitle: 'View and update personal details',
            onTap: () => context.go('/home/profile/edit-profile'),
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.badge_outlined,
            title: context.localizations.profileKyc,
            subtitle: userData?.isKyc == 1 ? 'Verified' : 'Complete your KYC',
            onTap: () => context.go('/home/profile/kyc'),
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.account_balance_outlined,
            title: context.localizations.profileBankAccount,
            subtitle: 'Manage linked bank accounts',
            onTap: () {},
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.lock_outline,
            title: context.localizations.profileChangePassword,
            subtitle: 'Update your account password',
            onTap: () => context.go('/home/profile/change-password'),
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.notifications_none,
            title: context.localizations.profileNotificationSettings,
            subtitle: 'Manage push notifications',
            trailing: Switch(
              value: userData?.isNotification ?? false,
              activeThumbColor: Colors.white,
              activeTrackColor: const Color(0xFF4E73F8),
              onChanged: (value) {
                context.read<UserProfileBloc>().add(UpdateNotificationStatus(value));
              },
            ),
            onTap: () {
              final currentStatus = userData?.isNotification ?? false;
              context.read<UserProfileBloc>().add(UpdateNotificationStatus(!currentStatus));
            },
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.language_outlined,
            title: context.localizations.profileLanguage,
            subtitle: 'App display language',
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('English', style: TextStyle(color: Color(0xFF8E95A5), fontSize: 13)),
                Gap(4),
                Icon(Icons.chevron_right, color: Color(0xFF6B7280), size: 20),
              ],
            ),
            onTap: () {},
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.help_outline,
            title: context.localizations.profileHelpAndSupport,
            subtitle: 'FAQs and support contact',
            onTap: () {},
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            subtitle: 'Request account deletion',
            isDestructive: true,
            onTap: () => _showDeleteAccountDialog(context),
          ),
          _buildDivider(),
          _buildOptionTile(
            icon: Icons.logout,
            title: context.localizations.profileLogout,
            subtitle: 'Sign out from this device',
            isDestructive: true,
            onTap: () {
              logout(
                context,
                onTap: () async {
                  final authRepo = RepositoryProvider.of<AuthRepository>(context);
                  try {
                    await authRepo.userLogout();
                  } catch (_) {}
                  if (context.mounted) {
                    context.read<UserProfileBloc>().add(const UserLoggedOut());
                    context.go('/login');
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    bool isDestructive = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? const Color(0xFFFF5252) : const Color(0xFF8E95A5), size: 22),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDestructive ? const Color(0xFFFF5252) : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(2),
                  Text(subtitle, style: const TextStyle(color: Color(0xFF8E95A5), fontSize: 12)),
                ],
              ),
            ),
            trailing ?? const Icon(Icons.chevron_right, color: Color(0xFF6B7280), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Color(0xFF262C3E), height: 1, indent: 52);
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final controller = TextEditingController();
    var isDeleteEnabled = false;
    var isLoading = false;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: const Color(0xFF1C202C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Delete Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Gap(12),
                    const Text(
                      'Are you sure you want to request account deletion? This will be sent for approval.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF8E95A5), fontSize: 13, height: 1.4),
                    ),
                    const Gap(20),
                    const Text(
                      'Type "DELETE" to confirm your action',
                      style: TextStyle(color: Color(0xFF8E95A5), fontSize: 12),
                    ),
                    const Gap(8),
                    TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: 'DELETE',
                        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                        filled: true,
                        fillColor: const Color(0xFF12151D),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF2E3548)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF547AFF)),
                        ),
                      ),
                      onChanged: (value) {
                        final enabled = value.trim().toUpperCase() == 'DELETE';
                        if (enabled != isDeleteEnabled) {
                          setState(() => isDeleteEnabled = enabled);
                        }
                      },
                    ),
                    const Gap(24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF2E3548)),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: isLoading ? null : () => Navigator.of(dialogContext).pop(),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE53935),
                              disabledBackgroundColor: const Color(0xFFE53935).withValues(alpha: 0.35),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: (isDeleteEnabled && !isLoading)
                                ? () async {
                                    setState(() => isLoading = true);
                                    try {
                                      final userRepo = RepositoryProvider.of<UserRepository>(context);
                                      await userRepo.deleteAccount(deleteReason: 'No longer needed');
                                      if (dialogContext.mounted) {
                                        Navigator.of(dialogContext).pop();
                                      }
                                      if (context.mounted) {
                                        context.read<UserProfileBloc>().add(const UserLoggedOut());
                                        context.go('/login');
                                        showSuccessMessage(
                                          context: context,
                                          content: 'Account deleted successfully',
                                        );
                                      }
                                    } catch (error) {
                                      if (error is SessionExpiredException ||
                                          error is InvalidSessionException ||
                                          error is AccountInactiveError) {
                                        if (dialogContext.mounted) {
                                          Navigator.of(dialogContext).pop();
                                        }
                                        if (context.mounted) {
                                          context.read<UserProfileBloc>().add(const UserLoggedOut());
                                          context.go('/login');
                                          showSuccessMessage(
                                            context: context,
                                            content: 'Account deleted successfully',
                                          );
                                        }
                                        return;
                                      }

                                      setState(() => isLoading = false);
                                      if (context.mounted) {
                                        showErrorMessage(
                                          context: context,
                                          content: error is InvalidResponseException && error.message != null
                                              ? error.message!
                                              : 'Failed to delete account. Please try again.',
                                        );
                                      }
                                    }
                                  }
                                : null,
                            child: isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : const Text(
                                    'Delete Account',
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Future<void> logout(BuildContext context, {required Future<void> Function() onTap}) async {
  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      var isLoading = false;
      return StatefulBuilder(
        builder: (context, setState) {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0xFF252B3B),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFF547AFF),
                        size: 26,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    context.localizations.profileLogout,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    context.localizations.logoutDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF8E95A5),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const Gap(24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF2E3548)),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: isLoading ? null : () => Navigator.of(dialogContext).pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4E73F8),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  setState(() => isLoading = true);
                                  try {
                                    await onTap();
                                  } finally {
                                    if (dialogContext.mounted) {
                                      Navigator.of(dialogContext).pop();
                                    }
                                  }
                                },
                          child: isLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  context.localizations.profileLogout,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
