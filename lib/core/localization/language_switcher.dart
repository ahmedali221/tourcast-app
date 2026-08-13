import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/localization/app_locales.dart';
import 'package:tourguide_app/core/localization/locale_cubit.dart';
import 'package:tourguide_app/core/theme/app_colors.dart';
import 'package:tourguide_app/core/theme/app_text_styles.dart';
import 'package:tourguide_app/l10n/generated/app_localizations.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final selectedLocale = context.watch<LocaleCubit>().state;
    final activeLanguageCode =
        (selectedLocale ?? Localizations.localeOf(context)).languageCode;
    final activeOption = AppLocales.options.firstWhere(
      (option) => option.locale.languageCode == activeLanguageCode,
      orElse: () => AppLocales.options.first,
    );

    return PopupMenuButton<String>(
      tooltip: l10n.settingsLanguage,
      initialValue: activeLanguageCode,
      position: PopupMenuPosition.under,
      constraints: const BoxConstraints(minWidth: 210, maxWidth: 260),
      onSelected: (languageCode) {
        if (languageCode == activeLanguageCode) return;
        context.read<LocaleCubit>().setLocale(Locale(languageCode));
      },
      itemBuilder: (context) => AppLocales.options
          .map(
            (option) => PopupMenuItem<String>(
              value: option.locale.languageCode,
              child: Row(
                children: [
                  Text(option.flag, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(option.nativeName, style: AppTextStyles.body),
                  ),
                  if (option.locale.languageCode == activeLanguageCode)
                    const Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                ],
              ),
            ),
          )
          .toList(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(activeOption.flag, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 2),
            const Icon(
              Icons.arrow_drop_down_rounded,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageAppBar extends AppBar {
  LanguageAppBar({
    super.key,
    super.title,
    super.leading,
    super.automaticallyImplyLeading,
    super.backgroundColor,
    super.foregroundColor,
    super.surfaceTintColor,
    super.elevation,
    super.bottom,
    List<Widget>? actions,
  }) : super(actions: [...?actions, const LanguageSwitcher()]);
}
