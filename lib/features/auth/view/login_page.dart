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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<AuthCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) context.go(AppRoutes.home);
        if (state is AuthError)
          context.showSnackBar(
            state.message ?? l10n.commonSomethingWentWrong,
            isError: true,
          );
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
                              l10n.loginWelcomeBack,
                              style: AppTextStyles.heading2,
                            ),
                            Text(
                              l10n.loginSubtitle,
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                        // Fields block
                        Column(
                          spacing: 16,
                          children: [
                            AppTextField(
                              label: l10n.loginEmailLabel,
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) => Validators.email(v, l10n),
                            ),
                            AppTextField(
                              label: l10n.loginPasswordLabel,
                              controller: _passwordCtrl,
                              obscureText: _obscure,
                              validator: (v) => Validators.password(v, l10n),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.textSecondary,
                                  size: 20,
                                ),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ),
                          ],
                        ),
                        // Actions block
                        Column(
                          spacing: 4,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () =>
                                    context.push(AppRoutes.forgotPassword),
                                child: Text(
                                  l10n.loginForgotPassword,
                                  style: AppTextStyles.label.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            AppButton(
                              label: l10n.loginButton,
                              isLoading: state is AuthLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
                                    _emailCtrl.text.trim(),
                                    _passwordCtrl.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        // Register link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.loginNoAccount,
                              style: AppTextStyles.caption,
                            ),
                            TextButton(
                              onPressed: () => context.go(AppRoutes.register),
                              child: Text(
                                l10n.loginRegisterLink,
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
