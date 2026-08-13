import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourguide_app/core/router/app_routes.dart';
import 'package:tourguide_app/features/auth/viewmodel/auth_cubit.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: l10n.commonLogout,
      onPressed: () => _confirm(context),
    );
  }

  void _confirm(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.commonLogout),
        content: Text(l10n.commonLogoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<AuthCubit>().logout();
              if (context.mounted) context.go(AppRoutes.login);
            },
            child: Text(l10n.commonLogout),
          ),
        ],
      ),
    );
  }
}
