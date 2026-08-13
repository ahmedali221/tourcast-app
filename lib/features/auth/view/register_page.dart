import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/di/locator.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/core/shared/widgets/app_button.dart';
import 'package:tourguide_app/core/shared/widgets/app_text_field.dart';
import 'package:tourguide_app/core/shared/widgets/nt_logo.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/core/utils/extensions.dart';
import 'package:tourguide_app/core/utils/validators.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AuthCubit>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _referralCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _referralCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) context.go(AppRoutes.verifyEmail);
        if (state is AuthError) {
          context.showSnackBar(
            state.message ?? l10n.commonSomethingWentWrong,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      context.screenHeight -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        // Brand block
                        Center(
                          child: Column(
                            spacing: 10,
                            children: [
                              const NtLogo(size: 72),
                              Text(
                                l10n.authTagline,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Heading block
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              l10n.registerHeading,
                              style: AppTextStyles.heading2,
                            ),
                            Text(
                              l10n.registerSubtitle,
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                        // Fields block
                        Column(
                          spacing: 16,
                          children: [
                            AppTextField(
                              label: l10n.registerFullNameLabel,
                              controller: _nameCtrl,
                              validator: (v) => Validators.required(
                                v,
                                l10n,
                                fieldName: l10n.registerFullNameLabel,
                              ),
                            ),
                            AppTextField(
                              label: l10n.registerEmailLabel,
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) => Validators.email(v, l10n),
                            ),
                            AppTextField(
                              label: l10n.registerPasswordLabel,
                              controller: _passwordCtrl,
                              obscureText: _obscurePass,
                              validator: (v) => Validators.password(v, l10n),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePass
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.textSecondary,
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePass = !_obscurePass,
                                ),
                              ),
                            ),
                            AppTextField(
                              label: l10n.registerConfirmPasswordLabel,
                              controller: _confirmCtrl,
                              obscureText: _obscureConfirm,
                              validator: (v) => Validators.confirmPassword(
                                v,
                                _passwordCtrl.text,
                                l10n,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirm
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.textSecondary,
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm,
                                ),
                              ),
                            ),
                            AppTextField(
                              label: l10n.registerReferralCodeLabel,
                              controller: _referralCtrl,
                              textCapitalization: TextCapitalization.characters,
                            ),
                          ],
                        ),
                        // Actions block
                        AppButton(
                          label: l10n.registerButton,
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().register(
                                name: _nameCtrl.text.trim(),
                                email: _emailCtrl.text.trim(),
                                password: _passwordCtrl.text,
                                passwordConfirmation: _confirmCtrl.text,
                                referralCode: _referralCtrl.text.trim(),
                              );
                            }
                          },
                        ),
                        // Login link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.registerAlreadyHaveAccount,
                              style: AppTextStyles.caption,
                            ),
                            TextButton(
                              onPressed: () => context.go(AppRoutes.login),
                              child: Text(
                                l10n.registerLoginLink,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
