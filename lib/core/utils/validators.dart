import 'package:tourguide_app/l10n/generated/app_localizations.dart';

// Form field validators — return null if valid, error string if not.
// Each validator takes the caller's AppLocalizations so messages are localized
// without the validator itself depending on BuildContext.
class Validators {
  Validators._();

  static String? email(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.validatorEmailRequired;
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return l10n.validatorEmailInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.validatorPasswordRequired;
    if (value.length < 8) return l10n.validatorPasswordTooShort;
    return null;
  }

  static String? confirmPassword(String? value, String original, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.validatorConfirmPasswordRequired;
    if (value != original) return l10n.validatorPasswordMismatch;
    return null;
  }

  static String? required(String? value, AppLocalizations l10n, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorFieldRequired(fieldName ?? l10n.validatorDefaultFieldName);
    }
    return null;
  }

  static String? amount(String? value, AppLocalizations l10n, {double min = 0}) {
    if (value == null || value.isEmpty) return l10n.validatorAmountRequired;
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) return l10n.validatorAmountInvalid;
    if (parsed < min) return l10n.validatorMinimumAmount(min.toStringAsFixed(0));
    return null;
  }
}
