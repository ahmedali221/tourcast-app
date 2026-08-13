import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/nt_logo.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AuthCubit>(),
      child: const _VerifyEmailView(),
    );
  }
}

class _VerifyEmailView extends StatelessWidget {
  const _VerifyEmailView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthEmailSent) {
          context.showSnackBar(l10n.verifyEmailResentSnackbar);
        }
        if (state is AuthError) {
          context.showSnackBar(
            state.message ?? l10n.commonSomethingWentWrong,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const NtLogo(size: 72),
                  const SizedBox(height: 32),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: AppColors.successTint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_outlined,
                      size: 72,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.verifyEmailHeading,
                    style: AppTextStyles.heading2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.verifyEmailBody,
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    label: l10n.verifyEmailContinueButton,
                    onPressed: () => context.go(AppRoutes.verification),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () => context
                              .read<AuthCubit>()
                              .resendVerificationEmail(),
                    child: Text(
                      l10n.verifyEmailResendButton,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
