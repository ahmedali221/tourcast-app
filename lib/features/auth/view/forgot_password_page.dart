import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/localization/language_switcher.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/app_text_field.dart';
import 'package:tourguide_app/core/shared/widgets/nt_logo.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AuthCubit>(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
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
          appBar: LanguageAppBar(
            title: Text(l10n.forgotPasswordTitle),
            backgroundColor: AppColors.surface,
          ),
          body: state is AuthEmailSent
              ? _SuccessView()
              : _FormView(
                  formKey: _formKey,
                  emailCtrl: _emailCtrl,
                  isLoading: state is AuthLoading,
                  onSubmit: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().sendPasswordResetEmail(
                        _emailCtrl.text.trim(),
                      );
                    }
                  },
                ),
        );
      },
    );
  }
}

class _FormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _FormView({
    required this.formKey,
    required this.emailCtrl,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const NtLogo(size: 72),
            const SizedBox(height: 24),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.successTint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_reset_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.forgotPasswordHeading,
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.forgotPasswordSubtitle,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppTextField(
              label: l10n.forgotPasswordEmailLabel,
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validators.email(value, l10n),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: l10n.forgotPasswordSendButton,
              isLoading: isLoading,
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: AppColors.successTint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 56,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.forgotPasswordSuccessHeading,
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.forgotPasswordSuccessBody,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
