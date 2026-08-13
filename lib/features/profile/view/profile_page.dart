import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/localization/language_switcher.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/shared/widgets/auth_avatar.dart';
import 'package:tourguide_app/core/shared/widgets/error_view.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/features/profile/model/profile_model.dart';
import 'package:tourguide_app/features/profile/viewmodel/profile_cubit.dart';
import 'package:tourguide_app/features/verification/viewmodel/verification_cubit.dart';
import 'package:tourguide_app/features/wallet/viewmodel/wallet_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (_) => locator<AuthCubit>()),
        BlocProvider(create: (_) => locator<VerificationCubit>()..loadStatus()),
        BlocProvider(
          create: (_) => locator<WalletCubit>()..loadFinanceSnapshot(),
        ),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: LanguageAppBar(
        title: Text(l10n.profileTitle),
        actions: [
          BlocBuilder<VerificationCubit, VerificationState>(
            builder: (context, verState) {
              final canEdit =
                  verState is VerificationLoaded &&
                  verState.verification != null &&
                  verState.verification!.status.toUpperCase() == 'VERIFIED';
              return IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: canEdit ? AppColors.primary : AppColors.textHint,
                ),
                onPressed: canEdit
                    ? () => context.push(AppRoutes.editProfile)
                    : () => context.showSnackBar(
                        l10n.profileEditUnavailable,
                        isError: true,
                      ),
              );
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) context.go(AppRoutes.login);
            },
          ),
        ],
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              context.showSnackBar(
                state.message ?? l10n.commonSomethingWentWrong,
                isError: true,
              );
            }
            if (state is ProfileUpdated) context.go(AppRoutes.login);
          },
          builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial)
              return _ShimmerView();
            if (state is ProfileError) {
              return ErrorView(
                message: state.message ?? l10n.commonSomethingWentWrong,
                onRetry: () => context.read<ProfileCubit>().loadProfile(),
              );
            }
            if (state is ProfileLoaded)
              return _BodyView(profile: state.profile);
            return _ShimmerView();
          },
        ),
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  final ProfileModel profile;
  const _BodyView({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        children: [
          // Header card
          _Card(
            child: Column(
              children: [
                AuthAvatar(
                  photoUrl: profile.photoUrl,
                  initials: profile.fullName,
                  radius: 45,
                ),
                const SizedBox(height: 12),
                Text(profile.fullName, style: AppTextStyles.heading2),
                const SizedBox(height: 2),
                Text(profile.email, style: AppTextStyles.caption),
                const SizedBox(height: 12),
                BlocBuilder<VerificationCubit, VerificationState>(
                  builder: (context, state) {
                    final status = state is VerificationLoaded
                        ? (state.verification?.status ?? 'PENDING')
                        : profile.verificationStatus;
                    return _VerificationBadge(status: status);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Completeness
          _Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.profileCompleteness, style: AppTextStyles.label),
                    Text(
                      '${profile.completenessPercent}%',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: profile.completenessPercent / 100,
                    minHeight: 6,
                    backgroundColor: AppColors.divider,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Info
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  label: l10n.profileCountry,
                  value: profile.country ?? l10n.profileMissingValue,
                ),
                _InfoRow(
                  label: l10n.profileCity,
                  value: profile.city ?? l10n.profileMissingValue,
                ),
                _InfoRow(
                  label: l10n.profileYearsExperienceLabel,
                  value: profile.yearsOfExperience != null
                      ? l10n.profileYearsExperienceValue(
                          profile.yearsOfExperience!,
                        )
                      : l10n.profileMissingValue,
                ),
                // if (profile.rating != null) _RatingRow(rating: profile.rating!),
                if (profile.languages.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(l10n.profileLanguages, style: AppTextStyles.caption),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: profile.languages
                        .map((l) => _Chip(label: l))
                        .toList(),
                  ),
                ],
                if (profile.specializations.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    l10n.profileSpecializations,
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: profile.specializations
                        .map((s) => _Chip(label: s))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Bio
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.profileBio, style: AppTextStyles.label),
                const SizedBox(height: 8),
                Text(
                  profile.bio?.isNotEmpty == true
                      ? profile.bio!
                      : l10n.profileNoBio,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Finance card
          _FinanceCard(),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(
              Icons.logout,
              color: AppColors.textSecondary,
              size: 18,
            ),
            label: Text(
              l10n.commonLogout,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _showDeleteDialog(context),
            child: Text(
              l10n.profileDeleteAccount,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.commonLogout),
        content: Text(l10n.commonLogoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await context.read<AuthCubit>().logout();
              if (context.mounted) context.go(AppRoutes.login);
            },
            child: Text(l10n.commonLogout),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.profileDeleteAccount),
        content: Text(l10n.profileDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProfileCubit>().deleteAccount();
            },
            child: Text(
              l10n.commonDelete,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.caption),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}

class _VerificationBadge extends StatelessWidget {
  final String status;
  const _VerificationBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'VERIFIED' => (AppColors.badgeVerified, 'VERIFIED'),
      'REJECTED' => (AppColors.badgeRejected, 'REJECTED'),
      _ => (AppColors.badgePending, 'PENDING'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: child,
    );
  }
}

class _FinanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state is WalletLoading || state is WalletInitial) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
          );
        }
        if (state is! FinanceSnapshotLoaded) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.profileWallet, style: AppTextStyles.label),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.wallet),
                    child: Text(
                      l10n.profileViewAll,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(state.balance.toCurrency(), style: AppTextStyles.heading2),
              Text(l10n.profileAvailableBalance, style: AppTextStyles.caption),
              if (state.payoutProfile != null) ...[
                const Divider(height: 24, color: AppColors.divider),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.profilePayoutAccount,
                      style: AppTextStyles.caption,
                    ),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.paymentMethods),
                      child: Text(
                        l10n.profileManage,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  state.payoutProfile!.methodName,
                  style: AppTextStyles.bodyMedium,
                ),
                ...state.payoutProfile!.details.entries.map(
                  (e) => Text(
                    '${e.key.replaceAll('_', ' ')}: ${e.value}',
                    style: AppTextStyles.caption,
                  ),
                ),
              ] else ...[
                const Divider(height: 24, color: AppColors.divider),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.paymentMethods),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.profileSetupPayoutAccount,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _ShimmerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: List.generate(
            3,
            (_) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
