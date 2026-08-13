// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'NileTech Tourguide';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonRetry => 'Wiederholen';

  @override
  String get commonTryAgain => 'Erneut versuchen';

  @override
  String get commonLoading => 'Wird geladen...';

  @override
  String get commonSubmit => 'Absenden';

  @override
  String get commonNext => 'Weiter';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonDone => 'Fertig';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonEdit => 'Bearbeiten';

  @override
  String get commonActive => 'Aktiv';

  @override
  String get commonCopied => 'Kopiert!';

  @override
  String get commonContactSupport => 'Support kontaktieren';

  @override
  String get commonPayoutsUnavailable =>
      'Auszahlungen sind verfügbar, sobald Ihr Konto verifiziert wurde.';

  @override
  String get commonPleaseContactSupport =>
      'Bitte kontaktieren Sie den Support.';

  @override
  String get commonLogout => 'Abmelden';

  @override
  String get commonLogoutConfirm => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get commonSomethingWentWrong =>
      'Etwas ist schiefgelaufen. Bitte versuchen Sie es erneut.';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSubtitle => 'Wählen Sie Ihre bevorzugte Sprache';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageArabic => 'Arabisch';

  @override
  String get languageChinese => 'Chinesisch';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageTurkish => 'Türkisch';

  @override
  String get languageItalian => 'Italienisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageJapanese => 'Japanisch';

  @override
  String get languageKorean => 'Koreanisch';

  @override
  String get navHome => 'Start';

  @override
  String get navMarketplace => 'Marktplatz';

  @override
  String get navWallet => 'Wallet';

  @override
  String get navSupport => 'Support';

  @override
  String get navProfile => 'Profil';

  @override
  String get validatorEmailRequired => 'E-Mail ist erforderlich';

  @override
  String get validatorEmailInvalid =>
      'Geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get validatorPasswordRequired => 'Passwort ist erforderlich';

  @override
  String get validatorPasswordTooShort =>
      'Das Passwort muss mindestens 8 Zeichen lang sein';

  @override
  String get validatorConfirmPasswordRequired =>
      'Bitte bestätigen Sie Ihr Passwort';

  @override
  String get validatorPasswordMismatch =>
      'Die Passwörter stimmen nicht überein';

  @override
  String validatorFieldRequired(String field) {
    return '$field ist erforderlich';
  }

  @override
  String get validatorDefaultFieldName => 'Dieses Feld';

  @override
  String get validatorAmountRequired => 'Betrag ist erforderlich';

  @override
  String get validatorAmountInvalid => 'Geben Sie einen gültigen Betrag ein';

  @override
  String validatorMinimumAmount(String min) {
    return 'Der Mindestbetrag beträgt \$$min';
  }

  @override
  String get authTagline => 'Ihr Guide. Ihr Business.';

  @override
  String get loginWelcomeBack => 'Willkommen zurück';

  @override
  String get loginSubtitle => 'Melden Sie sich bei Ihrem Guide-Konto an';

  @override
  String get loginEmailLabel => 'E-Mail-Adresse';

  @override
  String get loginPasswordLabel => 'Passwort';

  @override
  String get loginForgotPassword => 'Passwort vergessen?';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get loginNoAccount => 'Noch kein Konto?';

  @override
  String get loginRegisterLink => 'Registrieren';

  @override
  String get registerHeading => 'Konto erstellen';

  @override
  String get registerSubtitle => 'Werden Sie Tour Guide bei NileTech';

  @override
  String get registerFullNameLabel => 'Vollständiger Name';

  @override
  String get registerEmailLabel => 'E-Mail';

  @override
  String get registerPasswordLabel => 'Passwort';

  @override
  String get registerConfirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get registerReferralCodeLabel => 'Empfehlungscode (optional)';

  @override
  String get registerButton => 'Konto erstellen';

  @override
  String get registerAlreadyHaveAccount => 'Sie haben bereits ein Konto?';

  @override
  String get registerLoginLink => 'Anmelden';

  @override
  String get forgotPasswordTitle => 'Passwort vergessen';

  @override
  String get forgotPasswordHeading => 'Setzen Sie Ihr Passwort zurück';

  @override
  String get forgotPasswordSubtitle =>
      'Geben Sie Ihre E-Mail-Adresse ein und wir senden Ihnen einen Link zum Zurücksetzen.';

  @override
  String get forgotPasswordEmailLabel => 'E-Mail-Adresse';

  @override
  String get forgotPasswordSendButton => 'Reset-Link senden';

  @override
  String get forgotPasswordSuccessHeading => 'Prüfen Sie Ihren Posteingang';

  @override
  String get forgotPasswordSuccessBody =>
      'Ein Link zum Zurücksetzen des Passworts wurde an Ihre E-Mail-Adresse gesendet.';

  @override
  String get verifyEmailResentSnackbar => 'Bestätigungs-E-Mail erneut gesendet';

  @override
  String get verifyEmailHeading => 'Bestätigen Sie Ihre E-Mail-Adresse';

  @override
  String get verifyEmailBody =>
      'Wir haben einen Bestätigungslink an Ihre E-Mail-Adresse gesendet. Bitte prüfen Sie Ihren Posteingang und klicken Sie auf den Link, um Ihr Konto zu aktivieren.';

  @override
  String get verifyEmailContinueButton => 'Ich habe bestätigt, weiter';

  @override
  String get verifyEmailResendButton => 'E-Mail erneut senden';

  @override
  String get homeVerificationRequiredTitle => 'Verifizierung erforderlich';

  @override
  String get homeAccountUnderReviewTitle => 'Konto wird geprüft';

  @override
  String get homeApplicationRejectedTitle => 'Antrag abgelehnt';

  @override
  String get homeVerificationRequiredMessage =>
      'Sie müssen Ihre Verifizierungsdokumente einreichen, bevor Sie auf die App zugreifen können.';

  @override
  String get homePendingReviewMessage =>
      'Ihr Guide-Antrag wird derzeit von unserem Team geprüft. Sie werden benachrichtigt, sobald er genehmigt wurde.';

  @override
  String get homeRejectedMessage =>
      'Ihr Antrag wurde nicht genehmigt. Bitte lesen Sie die Hinweise unten und kontaktieren Sie den Support.';

  @override
  String get homeSubmitVerificationCta => 'Verifizierung einreichen';

  @override
  String get homeReviewNotesLabel => 'Prüfhinweise';

  @override
  String get greetingMorning => 'Guten Morgen';

  @override
  String get greetingAfternoon => 'Guten Tag';

  @override
  String get greetingEvening => 'Guten Abend';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'Ihr Guthaben';

  @override
  String get homeRequestPayout => 'Auszahlung anfordern';

  @override
  String get homeCommissions => 'Provisionen';

  @override
  String get homeReferrals => 'Empfehlungen';

  @override
  String get homeAnnouncements => 'Ankündigungen';

  @override
  String get homeMyPromoCodes => 'Meine Promo-Codes';

  @override
  String get homeNoPromoCodes => 'Noch keine Promo-Codes';

  @override
  String get homePendingBannerMessage =>
      'Ihre Verifizierung wird geprüft. Sie können die App durchsuchen, aber erst nach Genehmigung Promo-Codes erstellen, Empfehlungen abgeben oder Auszahlungen anfordern.';

  @override
  String get notificationsTrayTitle => 'Benachrichtigungen';

  @override
  String get notificationsMarkAllRead => 'Alle als gelesen markieren';

  @override
  String get notificationsEmptyTitle => 'Noch keine Benachrichtigungen';

  @override
  String get notificationsEmptyMessage => 'Sie sind auf dem neuesten Stand!';

  @override
  String get notificationsNewSection => 'Neu';

  @override
  String get notificationsEarlierSection => 'Früher';

  @override
  String get profileTitle => 'Mein Profil';

  @override
  String get profileEditUnavailable =>
      'Die Profilbearbeitung ist verfügbar, sobald Ihr Konto verifiziert wurde.';

  @override
  String get profileCompleteness => 'Profilvollständigkeit';

  @override
  String get profileCountry => 'Land';

  @override
  String get profileCity => 'Stadt';

  @override
  String get profileYearsExperienceLabel => 'Jahre Erfahrung';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Jahre',
      one: '$count Jahr',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'Sprachen';

  @override
  String get profileSpecializations => 'Spezialisierungen';

  @override
  String get profileBio => 'Biografie';

  @override
  String get profileNoBio => 'Noch keine Biografie hinzugefügt.';

  @override
  String get profileDeleteAccount => 'Konto löschen';

  @override
  String get profileDeleteConfirm =>
      'Diese Aktion ist endgültig und kann nicht rückgängig gemacht werden. Sind Sie sicher?';

  @override
  String get profileWallet => 'Wallet';

  @override
  String get profileViewAll => 'Alle anzeigen →';

  @override
  String get profileAvailableBalance => 'Verfügbares Guthaben';

  @override
  String get profilePayoutAccount => 'Auszahlungskonto';

  @override
  String get profileManage => 'Verwalten →';

  @override
  String get profileSetupPayoutAccount => 'Auszahlungskonto einrichten';

  @override
  String get profileUpdatedSuccess => 'Profil erfolgreich aktualisiert!';

  @override
  String get editProfileTitle => 'Profil bearbeiten';

  @override
  String get editProfileChangePhoto => 'Foto ändern';

  @override
  String get editProfileSelectCountry => 'Land auswählen';

  @override
  String get editProfileSaveChanges => 'Änderungen speichern';

  @override
  String get editProfileSelectCountryTitle => 'Land auswählen';

  @override
  String get editProfileSearchCountryHint => 'Land suchen...';

  @override
  String editProfileSelectItemTitle(String title) {
    return '$title auswählen';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'Fertig ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'Suchen...';

  @override
  String editProfileApplyCount(int count) {
    return 'Anwenden ($count ausgewählt)';
  }

  @override
  String get editProfileAddChip => '+ Hinzufügen';

  @override
  String get verificationTitle => 'Identitätsverifizierung';

  @override
  String get verificationDocumentDetails => 'Dokumentdetails';

  @override
  String get verificationNationalIdLabel => 'Personalausweisnummer';

  @override
  String get verificationLicenseLabel => 'Guide-Lizenznummer';

  @override
  String get verificationUploadDocuments => 'Dokumente hochladen';

  @override
  String get verificationUploadCaption =>
      'Bitte laden Sie klare, gut lesbare Kopien Ihrer Dokumente hoch.';

  @override
  String get verificationIdFrontTitle => 'Personalausweis — Vorderseite';

  @override
  String get verificationIdFrontSubtitle =>
      'Vorderseite Ihres Personalausweises';

  @override
  String get verificationFormatMax2mb => 'JPEG oder PNG • Max. 2 MB';

  @override
  String get verificationIdBackTitle => 'Personalausweis — Rückseite';

  @override
  String get verificationIdBackSubtitle => 'Rückseite Ihres Personalausweises';

  @override
  String get verificationLicenseTitle => 'Guide-Lizenz';

  @override
  String get verificationLicenseSubtitle =>
      'Offizielles Lizenzdokument als Tour Guide';

  @override
  String get verificationFormatMax5mb => 'JPEG oder PNG • Max. 5 MB';

  @override
  String get verificationSubmitButton => 'Zur Verifizierung einreichen';

  @override
  String get verificationUploaded => 'Hochgeladen';

  @override
  String get verificationTapToUpload => 'Zum Hochladen tippen';

  @override
  String get verificationRejectedBanner =>
      'Ihre Dokumente wurden abgelehnt. Bitte reichen Sie sie erneut ein.';

  @override
  String get verificationPendingBanner =>
      'Ihre Dokumente werden geprüft. Wir benachrichtigen Sie.';

  @override
  String get verificationSubmittedDocuments => 'Eingereichte Dokumente';

  @override
  String get verificationVerifiedTitle => 'Identität verifiziert';

  @override
  String get verificationVerifiedSubtitle =>
      'Ihre Identität wurde erfolgreich verifiziert.';

  @override
  String get verificationSuccessHeading => 'Dokumente eingereicht';

  @override
  String get verificationSuccessBody =>
      'Ihre Verifizierungsdokumente wurden erfolgreich eingereicht. Unser Team wird sie prüfen und Sie über das Ergebnis informieren.';

  @override
  String get verificationSuccessInfoBanner =>
      'Die Prüfung dauert in der Regel 1–3 Werktage.';

  @override
  String get verificationGoHome => 'Zur Startseite';

  @override
  String get marketplaceTitle => 'Marktplatz';

  @override
  String get marketplaceSearchHint => 'Apps suchen...';

  @override
  String get marketplaceEmptyTitle => 'Keine Apps verfügbar';

  @override
  String get marketplaceEmptyMessage =>
      'Schauen Sie später wieder vorbei für neue Apps.';

  @override
  String get marketplaceViewDetails => 'Details anzeigen →';

  @override
  String get appDetailsCouldNotOpenStore =>
      'Store-Link konnte nicht geöffnet werden';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => 'Über';

  @override
  String get appDetailsAvailablePlans => 'Verfügbare Tarife';

  @override
  String get appDetailsPromoUnavailable =>
      'Promo-Codes sind verfügbar, sobald Ihr Konto verifiziert wurde.';

  @override
  String get appDetailsGenerateButton => '+ Generieren';

  @override
  String get appDetailsFailedLoadPromoCodes =>
      'Promo-Codes konnten nicht geladen werden.';

  @override
  String get appDetailsGenerateHint =>
      'Tippen Sie auf \"+ Generieren\", um Ihren ersten Code zu erstellen.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'Promo-Code konnte nicht generiert werden. Bitte versuchen Sie es erneut.';

  @override
  String get appDetailsCopyTooltip => 'Kopieren';

  @override
  String get appDetailsFailedLoadUsage =>
      'Nutzungsdaten konnten nicht geladen werden.';

  @override
  String get appDetailsNoUsage => 'Noch keine Nutzung';

  @override
  String get appDetailsCreatePromoTitle => 'Promo-Code erstellen';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'Geben Sie einen eigenen Namen für Ihren Promo-Code ein oder lassen Sie das Feld leer, um automatisch einen zu generieren.';

  @override
  String get appDetailsPromoNameLabel => 'Promo-Code-Name (optional)';

  @override
  String get appDetailsPromoNameHint =>
      'z. B. AHMED20 — leer lassen für automatische Generierung';

  @override
  String get appDetailsGenerate => 'Generieren';

  @override
  String get appDetailsPreview => 'Vorschau';

  @override
  String get appDetailsFree => 'Kostenlos';

  @override
  String get walletTitle => 'Wallet';

  @override
  String get walletTransactionHistory => 'Transaktionsverlauf';

  @override
  String get walletNoTransactions => 'Noch keine Transaktionen';

  @override
  String get walletNoTransactionsMessage =>
      'Ihr Transaktionsverlauf wird hier angezeigt.';

  @override
  String get walletPayoutRequestsTitle => 'Auszahlungsanfragen';

  @override
  String get walletPayoutRequestsSubtitle =>
      'Auszahlungen anzeigen und verwalten';

  @override
  String get payoutProfileSaved => 'Auszahlungsprofil gespeichert!';

  @override
  String get payoutRequestSubmitted => 'Auszahlungsanfrage eingereicht';

  @override
  String get payoutMethodTitle => 'Auszahlungsmethode';

  @override
  String get payoutPaymentDetailsTitle => 'Zahlungsdetails';

  @override
  String get payoutManageAccount => 'Zahlungskonto verwalten';

  @override
  String get payoutHistorySection => 'Verlauf';

  @override
  String get payoutNoRequests => 'Noch keine Auszahlungsanfragen';

  @override
  String get payoutNoRequestsMessage =>
      'Ihre Auszahlungsanfragen werden hier angezeigt.';

  @override
  String get payoutChooseMethod =>
      'Wählen Sie, wie Sie Ihr Geld erhalten möchten.';

  @override
  String get payoutNoMethodsAvailable => 'Keine Auszahlungsmethoden verfügbar';

  @override
  String get payoutInfoBanner =>
      'Diese Angaben werden in Ihrem Auszahlungsprofil gespeichert und für alle zukünftigen Auszahlungen verwendet.';

  @override
  String get payoutSaveContinue => 'Speichern & weiter';

  @override
  String payoutAvailableAmount(String amount) {
    return 'Verfügbar: $amount';
  }

  @override
  String get payoutChange => 'Ändern';

  @override
  String get payoutAmountHint => '0,00';

  @override
  String get payoutMinimumHelper =>
      'Der Mindestauszahlungsbetrag beträgt 10 \$';

  @override
  String get payoutSubmitRequest => 'Anfrage senden';

  @override
  String get payoutAmountLabel => 'Betrag (USD)';

  @override
  String get paymentMethodsSaved => 'Zahlungskonto gespeichert!';

  @override
  String get paymentMethodsTitle => 'Zahlungsmethoden';

  @override
  String get paymentMethodsNoneAvailable => 'Keine Zahlungsmethoden verfügbar';

  @override
  String get paymentMethodsChoose => 'Wählen Sie eine Zahlungsmethode';

  @override
  String get paymentMethodsAll => 'Alle Methoden';

  @override
  String get paymentMethodsActiveBadge => 'AKTIV';

  @override
  String get paymentMethodsSetUp => 'Einrichten';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return 'Aktualisieren Sie Ihre gespeicherten Zahlungsdaten für $methodName.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'Dies wird Ihr aktives Auszahlungskonto.';

  @override
  String get paymentMethodsSetActiveButton => 'Als aktives Konto festlegen';

  @override
  String get commissionsTitle => 'Provisionen';

  @override
  String get commissionsTotalEarned => 'Insgesamt verdiente Provisionen';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Transaktionen',
      one: '$count Transaktion',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => 'Provisionsverlauf';

  @override
  String get commissionsEmptyTitle => 'Noch keine Provisionen';

  @override
  String get commissionsEmptyMessage =>
      'Ihre verdienten Provisionen werden hier angezeigt.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'Promo-Code: $code';
  }

  @override
  String get commissionsDirectSale => 'Direktverkauf';

  @override
  String get referralsTitle => 'Empfehlungen';

  @override
  String get referralsTotal => 'Empfehlungen insgesamt';

  @override
  String get referralsTotalEarned => 'Insgesamt verdient';

  @override
  String get referralsGenerateNew => 'Neuen Empfehlungscode generieren';

  @override
  String get referralsUnavailable =>
      'Empfehlungslinks sind verfügbar, sobald Ihr Konto verifiziert wurde.';

  @override
  String get referralsCodesSection => 'Empfehlungscodes';

  @override
  String get referralsEmptyTitle => 'Noch keine Empfehlungen';

  @override
  String get referralsEmptyMessage =>
      'Generieren Sie einen Code und teilen Sie ihn, um mit dem Verdienen zu beginnen!';

  @override
  String get referralsCodeCopied => 'Code kopiert!';

  @override
  String referralsUsedBy(String user) {
    return 'Verwendet von $user';
  }

  @override
  String get referralsNotUsedYet => 'Noch nicht verwendet';

  @override
  String referralsRegisteredOn(String date) {
    return 'Registriert am $date';
  }

  @override
  String get referralsLinkGeneratedTitle => 'Empfehlungslink generiert';

  @override
  String get referralsShareSubtitle =>
      'Teilen Sie Ihren Code oder Link, um mit dem Verdienen zu beginnen.';

  @override
  String get referralsCodeLabel => 'Empfehlungscode';

  @override
  String get referralsLinkLabel => 'Empfehlungslink';

  @override
  String get referralsLinkCopied => 'Link kopiert!';

  @override
  String get referralsActivityTitle => 'Aktivität geworbener Nutzer';

  @override
  String get referralsNoActivityData => 'Keine Aktivitätsdaten';

  @override
  String get referralsActivityWillAppear =>
      'Die Aktivität wird angezeigt, sobald der Nutzer aktiv ist.';

  @override
  String get referralsWindowSection => 'Empfehlungszeitraum';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'Abonnements ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'App-Nutzungsereignisse ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'Promo-Einlösungen ($count)';
  }

  @override
  String get referralsNoActivityYet => 'Noch keine Aktivität';

  @override
  String referralsItemFallback(int index) {
    return 'Element $index';
  }

  @override
  String get supportTicketsTitle => 'Support-Tickets';

  @override
  String get supportFilterAll => 'Alle';

  @override
  String get supportFilterOpen => 'Offen';

  @override
  String get supportFilterPending => 'Ausstehend';

  @override
  String get supportFilterClosed => 'Geschlossen';

  @override
  String get supportEmptyTitle => 'Noch keine Tickets';

  @override
  String get supportEmptyMessage =>
      'Tippen Sie auf +, um ein neues Support-Ticket zu öffnen.';

  @override
  String get newTicketTitle => 'Neues Ticket';

  @override
  String get newTicketSubmitted => 'Ticket erfolgreich übermittelt!';

  @override
  String get newTicketCategoryLabel => 'Kategorie';

  @override
  String get newTicketPriorityLabel => 'Priorität';

  @override
  String get newTicketSubjectLabel => 'Betreff';

  @override
  String get newTicketSubjectRequired => 'Betreff ist erforderlich';

  @override
  String get newTicketMessageLabel => 'Nachricht';

  @override
  String get newTicketMessageRequired => 'Nachricht ist erforderlich';

  @override
  String get newTicketSubmitButton => 'Ticket senden';

  @override
  String get newTicketCategoryTechnical => 'Technisch';

  @override
  String get newTicketCategoryPayment => 'Zahlung';

  @override
  String get newTicketPriorityNormal => 'Normal';

  @override
  String get newTicketPriorityHigh => 'Hoch';

  @override
  String get newTicketPriorityUrgent => 'Dringend';

  @override
  String get ticketDetailRefreshTooltip => 'Aktualisieren';

  @override
  String get ticketDetailNoReplies => 'Noch keine Antworten.';

  @override
  String get ticketDetailTeamWillRespond =>
      'Unser Team wird sich in Kürze melden.';

  @override
  String get ticketDetailReplyHint => 'Antwort eingeben...';

  @override
  String get ticketDetailClosed => 'Dieses Ticket ist geschlossen.';

  @override
  String get agreementsTitle => 'Rechtliche Vereinbarungen';

  @override
  String get agreementsAccepted => 'Vereinbarung akzeptiert';

  @override
  String get agreementsAllAcceptedTitle => 'Alle Vereinbarungen akzeptiert!';

  @override
  String get agreementsNoPending =>
      'Sie haben keine ausstehenden Vereinbarungen.';

  @override
  String get agreementsAcceptedStatus => 'Akzeptiert';

  @override
  String get agreementsPendingStatus => 'Wartet auf Ihre Zustimmung';

  @override
  String get agreementsCheckboxLabel =>
      'Ich habe die obigen Bedingungen gelesen und stimme ihnen zu';

  @override
  String get agreementsAcceptButton => 'Vereinbarung akzeptieren';

  @override
  String get knowledgeCenterTitle => 'Wissenscenter';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'Erste Schritte';

  @override
  String get knowledgeCenterCategoryPayments => 'Zahlungen';

  @override
  String get knowledgeCenterCategoryAppsTools => 'Apps & Tools';

  @override
  String get knowledgeCenterCategoryAccount => 'Konto';

  @override
  String get knowledgeCenterEmptyTitle => 'Noch keine Artikel';

  @override
  String get knowledgeCenterEmptyMessage =>
      'Schauen Sie später wieder vorbei für neue Inhalte.';

  @override
  String get subscriptionPageStub => 'Abonnements-Seite';
}
