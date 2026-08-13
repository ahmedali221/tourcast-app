// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'NileTech Tour Guide';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonTryAgain => 'Riprova';

  @override
  String get commonLoading => 'Caricamento...';

  @override
  String get commonSubmit => 'Invia';

  @override
  String get commonNext => 'Avanti';

  @override
  String get commonBack => 'Indietro';

  @override
  String get commonDone => 'Fatto';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get commonActive => 'Attivo';

  @override
  String get commonCopied => 'Copiato!';

  @override
  String get commonContactSupport => 'Contatta l\'Assistenza';

  @override
  String get commonPayoutsUnavailable =>
      'I pagamenti sono disponibili una volta verificato il tuo account.';

  @override
  String get commonPleaseContactSupport => 'Contatta l\'assistenza.';

  @override
  String get commonLogout => 'Esci';

  @override
  String get commonLogoutConfirm => 'Sei sicuro di voler uscire?';

  @override
  String get commonSomethingWentWrong => 'Qualcosa è andato storto. Riprova.';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageSubtitle => 'Scegli la lingua preferita';

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageArabic => 'Arabo';

  @override
  String get languageChinese => 'Cinese';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageGerman => 'Tedesco';

  @override
  String get languageFrench => 'Francese';

  @override
  String get languageTurkish => 'Turco';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageSpanish => 'Spagnolo';

  @override
  String get languageJapanese => 'Giapponese';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get navHome => 'Home';

  @override
  String get navMarketplace => 'Marketplace';

  @override
  String get navWallet => 'Portafoglio';

  @override
  String get navSupport => 'Assistenza';

  @override
  String get navProfile => 'Profilo';

  @override
  String get validatorEmailRequired => 'L\'email è obbligatoria';

  @override
  String get validatorEmailInvalid => 'Inserisci un indirizzo email valido';

  @override
  String get validatorPasswordRequired => 'La password è obbligatoria';

  @override
  String get validatorPasswordTooShort =>
      'La password deve contenere almeno 8 caratteri';

  @override
  String get validatorConfirmPasswordRequired => 'Conferma la tua password';

  @override
  String get validatorPasswordMismatch => 'Le password non coincidono';

  @override
  String validatorFieldRequired(String field) {
    return '$field è obbligatorio';
  }

  @override
  String get validatorDefaultFieldName => 'Questo campo';

  @override
  String get validatorAmountRequired => 'L\'importo è obbligatorio';

  @override
  String get validatorAmountInvalid => 'Inserisci un importo valido';

  @override
  String validatorMinimumAmount(String min) {
    return 'L\'importo minimo è \$$min';
  }

  @override
  String get authTagline => 'La tua guida. Il tuo business.';

  @override
  String get loginWelcomeBack => 'Bentornato';

  @override
  String get loginSubtitle => 'Accedi al tuo account guida';

  @override
  String get loginEmailLabel => 'Indirizzo Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginForgotPassword => 'Password dimenticata?';

  @override
  String get loginButton => 'Accedi';

  @override
  String get loginNoAccount => 'Non hai un account?';

  @override
  String get loginRegisterLink => 'Registrati';

  @override
  String get registerHeading => 'Crea Account';

  @override
  String get registerSubtitle => 'Unisciti a NileTech come Guida Turistica';

  @override
  String get registerFullNameLabel => 'Nome Completo';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerConfirmPasswordLabel => 'Conferma Password';

  @override
  String get registerReferralCodeLabel => 'Codice Referral (Facoltativo)';

  @override
  String get registerButton => 'Crea Account';

  @override
  String get registerAlreadyHaveAccount => 'Hai già un account?';

  @override
  String get registerLoginLink => 'Accedi';

  @override
  String get forgotPasswordTitle => 'Password Dimenticata';

  @override
  String get forgotPasswordHeading => 'Reimposta la tua password';

  @override
  String get forgotPasswordSubtitle =>
      'Inserisci la tua email e ti invieremo un link per reimpostarla.';

  @override
  String get forgotPasswordEmailLabel => 'Indirizzo Email';

  @override
  String get forgotPasswordSendButton => 'Invia Link di Reimpostazione';

  @override
  String get forgotPasswordSuccessHeading =>
      'Controlla la tua casella di posta';

  @override
  String get forgotPasswordSuccessBody =>
      'Un link per reimpostare la password è stato inviato al tuo indirizzo email.';

  @override
  String get verifyEmailResentSnackbar => 'Email di verifica inviata di nuovo';

  @override
  String get verifyEmailHeading => 'Verifica la tua Email';

  @override
  String get verifyEmailBody =>
      'Abbiamo inviato un link di verifica alla tua email. Controlla la tua casella di posta e clicca sul link per attivare il tuo account.';

  @override
  String get verifyEmailContinueButton => 'Ho verificato, Continua';

  @override
  String get verifyEmailResendButton => 'Invia di nuovo';

  @override
  String get homeVerificationRequiredTitle => 'Verifica Richiesta';

  @override
  String get homeAccountUnderReviewTitle => 'Account in Revisione';

  @override
  String get homeApplicationRejectedTitle => 'Candidatura Rifiutata';

  @override
  String get homeVerificationRequiredMessage =>
      'Devi inviare i tuoi documenti di verifica prima di poter accedere all\'app.';

  @override
  String get homePendingReviewMessage =>
      'La tua candidatura come guida è in fase di revisione da parte del nostro team. Riceverai una notifica non appena verrà approvata.';

  @override
  String get homeRejectedMessage =>
      'La tua candidatura non è stata approvata. Controlla le note qui sotto e contatta l\'assistenza.';

  @override
  String get homeSubmitVerificationCta => 'Invia Verifica';

  @override
  String get homeReviewNotesLabel => 'Note di Revisione';

  @override
  String get greetingMorning => 'Buongiorno';

  @override
  String get greetingAfternoon => 'Buon pomeriggio';

  @override
  String get greetingEvening => 'Buonasera';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'Il Tuo Saldo';

  @override
  String get homeRequestPayout => 'Richiedi Pagamento';

  @override
  String get homeCommissions => 'Commissioni';

  @override
  String get homeReferrals => 'Referral';

  @override
  String get homeAnnouncements => 'Annunci';

  @override
  String get homeMyPromoCodes => 'I Miei Codici Promo';

  @override
  String get homeNoPromoCodes => 'Nessun codice promo ancora';

  @override
  String get homePendingBannerMessage =>
      'La tua verifica è in fase di revisione. Puoi navigare nell\'app, ma non puoi creare codici promo, referral o richiedere pagamenti fino all\'approvazione.';

  @override
  String get notificationsTrayTitle => 'Notifiche';

  @override
  String get notificationsMarkAllRead => 'Segna tutte come lette';

  @override
  String get notificationsEmptyTitle => 'Nessuna notifica ancora';

  @override
  String get notificationsEmptyMessage => 'Sei aggiornato!';

  @override
  String get notificationsNewSection => 'Nuove';

  @override
  String get notificationsEarlierSection => 'Precedenti';

  @override
  String get profileTitle => 'Il Mio Profilo';

  @override
  String get profileEditUnavailable =>
      'La modifica del profilo è disponibile una volta verificato il tuo account.';

  @override
  String get profileCompleteness => 'Completezza del Profilo';

  @override
  String get profileCountry => 'Paese';

  @override
  String get profileCity => 'Città';

  @override
  String get profileYearsExperienceLabel => 'Anni di Esperienza';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anni',
      one: '$count anno',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'Lingue';

  @override
  String get profileSpecializations => 'Specializzazioni';

  @override
  String get profileBio => 'Biografia';

  @override
  String get profileNoBio => 'Nessuna biografia aggiunta.';

  @override
  String get profileDeleteAccount => 'Elimina Account';

  @override
  String get profileDeleteConfirm =>
      'Questa azione è permanente e non può essere annullata. Sei sicuro?';

  @override
  String get profileWallet => 'Portafoglio';

  @override
  String get profileViewAll => 'Vedi tutto →';

  @override
  String get profileAvailableBalance => 'Saldo Disponibile';

  @override
  String get profilePayoutAccount => 'Account di Pagamento';

  @override
  String get profileManage => 'Gestisci →';

  @override
  String get profileSetupPayoutAccount => 'Configura account di pagamento';

  @override
  String get profileUpdatedSuccess => 'Profilo aggiornato con successo!';

  @override
  String get editProfileTitle => 'Modifica Profilo';

  @override
  String get editProfileChangePhoto => 'Cambia Foto';

  @override
  String get editProfileSelectCountry => 'Seleziona il paese';

  @override
  String get editProfileSaveChanges => 'Salva Modifiche';

  @override
  String get editProfileSelectCountryTitle => 'Seleziona Paese';

  @override
  String get editProfileSearchCountryHint => 'Cerca paese...';

  @override
  String editProfileSelectItemTitle(String title) {
    return 'Seleziona $title';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'Fatto ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'Cerca...';

  @override
  String editProfileApplyCount(int count) {
    return 'Applica ($count selezionati)';
  }

  @override
  String get editProfileAddChip => '+ Aggiungi';

  @override
  String get verificationTitle => 'Verifica dell\'Identità';

  @override
  String get verificationDocumentDetails => 'Dettagli Documento';

  @override
  String get verificationNationalIdLabel => 'Numero Carta d\'Identità';

  @override
  String get verificationLicenseLabel => 'Numero Licenza Guida';

  @override
  String get verificationUploadDocuments => 'Carica Documenti';

  @override
  String get verificationUploadCaption =>
      'Carica copie chiare e leggibili dei tuoi documenti.';

  @override
  String get verificationIdFrontTitle => 'Carta d\'Identità — Fronte';

  @override
  String get verificationIdFrontSubtitle =>
      'Lato anteriore della tua carta d\'identità';

  @override
  String get verificationFormatMax2mb => 'JPEG o PNG • Max 2 MB';

  @override
  String get verificationIdBackTitle => 'Carta d\'Identità — Retro';

  @override
  String get verificationIdBackSubtitle =>
      'Lato posteriore della tua carta d\'identità';

  @override
  String get verificationLicenseTitle => 'Licenza da Guida';

  @override
  String get verificationLicenseSubtitle =>
      'Documento ufficiale della licenza da guida turistica';

  @override
  String get verificationFormatMax5mb => 'JPEG o PNG • Max 5 MB';

  @override
  String get verificationSubmitButton => 'Invia per Verifica';

  @override
  String get verificationUploaded => 'Caricato';

  @override
  String get verificationTapToUpload => 'Tocca per caricare';

  @override
  String get verificationRejectedBanner =>
      'I tuoi documenti sono stati rifiutati. Invia nuovamente i documenti.';

  @override
  String get verificationPendingBanner =>
      'I tuoi documenti sono in fase di revisione. Ti avviseremo.';

  @override
  String get verificationSubmittedDocuments => 'Documenti Inviati';

  @override
  String get verificationVerifiedTitle => 'Identità Verificata';

  @override
  String get verificationVerifiedSubtitle =>
      'La tua identità è stata verificata con successo.';

  @override
  String get verificationSuccessHeading => 'Documenti Inviati';

  @override
  String get verificationSuccessBody =>
      'I tuoi documenti di verifica sono stati inviati con successo. Il nostro team li esaminerà e ti comunicherà l\'esito.';

  @override
  String get verificationSuccessInfoBanner =>
      'La revisione richiede solitamente 1–3 giorni lavorativi.';

  @override
  String get verificationGoHome => 'Vai alla Home';

  @override
  String get marketplaceTitle => 'Marketplace';

  @override
  String get marketplaceSearchHint => 'Cerca app...';

  @override
  String get marketplaceEmptyTitle => 'Nessuna app disponibile';

  @override
  String get marketplaceEmptyMessage => 'Torna più tardi per nuove app.';

  @override
  String get marketplaceViewDetails => 'Vedi Dettagli →';

  @override
  String get appDetailsCouldNotOpenStore =>
      'Impossibile aprire il link dello store';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => 'Informazioni';

  @override
  String get appDetailsAvailablePlans => 'Piani Disponibili';

  @override
  String get appDetailsPromoUnavailable =>
      'I codici promo sono disponibili una volta verificato il tuo account.';

  @override
  String get appDetailsGenerateButton => '+ Genera';

  @override
  String get appDetailsFailedLoadPromoCodes =>
      'Impossibile caricare i codici promo.';

  @override
  String get appDetailsGenerateHint =>
      'Tocca \"+ Genera\" per creare il tuo primo codice.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'Impossibile generare il codice promo. Riprova.';

  @override
  String get appDetailsCopyTooltip => 'Copia';

  @override
  String get appDetailsFailedLoadUsage => 'Impossibile caricare l\'utilizzo.';

  @override
  String get appDetailsNoUsage => 'Nessun utilizzo ancora';

  @override
  String get appDetailsCreatePromoTitle => 'Crea Codice Promo';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'Inserisci un nome personalizzato per il tuo codice promo, oppure lascialo vuoto per generarlo automaticamente.';

  @override
  String get appDetailsPromoNameLabel => 'Nome Codice Promo (opzionale)';

  @override
  String get appDetailsPromoNameHint =>
      'es. AHMED20 — lascia vuoto per generare automaticamente';

  @override
  String get appDetailsGenerate => 'Genera';

  @override
  String get appDetailsPreview => 'Anteprima';

  @override
  String get appDetailsFree => 'Gratis';

  @override
  String get walletTitle => 'Portafoglio';

  @override
  String get walletTransactionHistory => 'Cronologia Transazioni';

  @override
  String get walletNoTransactions => 'Nessuna transazione ancora';

  @override
  String get walletNoTransactionsMessage =>
      'La cronologia delle transazioni apparirà qui.';

  @override
  String get walletPayoutRequestsTitle => 'Richieste di Pagamento';

  @override
  String get walletPayoutRequestsSubtitle =>
      'Visualizza e gestisci i tuoi pagamenti';

  @override
  String get payoutProfileSaved => 'Profilo di pagamento salvato!';

  @override
  String get payoutRequestSubmitted => 'Richiesta di pagamento inviata';

  @override
  String get payoutMethodTitle => 'Metodo di Pagamento';

  @override
  String get payoutPaymentDetailsTitle => 'Dettagli di Pagamento';

  @override
  String get payoutManageAccount => 'Gestisci Account di Pagamento';

  @override
  String get payoutHistorySection => 'Cronologia';

  @override
  String get payoutNoRequests => 'Nessuna richiesta di pagamento ancora';

  @override
  String get payoutNoRequestsMessage =>
      'Le tue richieste di pagamento appariranno qui.';

  @override
  String get payoutChooseMethod => 'Scegli come vuoi ricevere il tuo denaro.';

  @override
  String get payoutNoMethodsAvailable =>
      'Nessun metodo di pagamento disponibile';

  @override
  String get payoutInfoBanner =>
      'Queste informazioni vengono salvate nel tuo profilo di pagamento e utilizzate per tutti i prelievi futuri.';

  @override
  String get payoutSaveContinue => 'Salva e Continua';

  @override
  String payoutAvailableAmount(String amount) {
    return 'Disponibile: $amount';
  }

  @override
  String get payoutChange => 'Cambia';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => 'L\'importo minimo di pagamento è \$10';

  @override
  String get payoutSubmitRequest => 'Invia Richiesta';

  @override
  String get payoutAmountLabel => 'Importo (USD)';

  @override
  String get paymentMethodsSaved => 'Account di pagamento salvato!';

  @override
  String get paymentMethodsTitle => 'Metodi di Pagamento';

  @override
  String get paymentMethodsNoneAvailable =>
      'Nessun metodo di pagamento disponibile';

  @override
  String get paymentMethodsChoose => 'Scegli un metodo di pagamento';

  @override
  String get paymentMethodsAll => 'Tutti i Metodi';

  @override
  String get paymentMethodsActiveBadge => 'ATTIVO';

  @override
  String get paymentMethodsSetUp => 'Configura';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return 'Aggiorna i tuoi dati di pagamento salvati per $methodName.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'Questo diventerà il tuo account di pagamento attivo.';

  @override
  String get paymentMethodsSetActiveButton => 'Imposta come Account Attivo';

  @override
  String get commissionsTitle => 'Commissioni';

  @override
  String get commissionsTotalEarned => 'Totale Commissioni Guadagnate';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transazioni',
      one: '$count transazione',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => 'Cronologia Commissioni';

  @override
  String get commissionsEmptyTitle => 'Nessuna commissione ancora';

  @override
  String get commissionsEmptyMessage =>
      'Le tue commissioni guadagnate appariranno qui.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'Codice promo: $code';
  }

  @override
  String get commissionsDirectSale => 'Vendita diretta';

  @override
  String get referralsTitle => 'Referral';

  @override
  String get referralsTotal => 'Totale Referral';

  @override
  String get referralsTotalEarned => 'Totale Guadagnato';

  @override
  String get referralsGenerateNew => 'Genera Nuovo Codice Referral';

  @override
  String get referralsUnavailable =>
      'I link referral sono disponibili una volta verificato il tuo account.';

  @override
  String get referralsCodesSection => 'Codici Referral';

  @override
  String get referralsEmptyTitle => 'Nessun referral ancora';

  @override
  String get referralsEmptyMessage =>
      'Genera un codice e condividilo per iniziare a guadagnare!';

  @override
  String get referralsCodeCopied => 'Codice copiato!';

  @override
  String referralsUsedBy(String user) {
    return 'Usato da $user';
  }

  @override
  String get referralsNotUsedYet => 'Non ancora usato';

  @override
  String referralsRegisteredOn(String date) {
    return 'Registrato il $date';
  }

  @override
  String get referralsLinkGeneratedTitle => 'Link Referral Generato';

  @override
  String get referralsShareSubtitle =>
      'Condividi il tuo codice o link per iniziare a guadagnare.';

  @override
  String get referralsCodeLabel => 'Codice Referral';

  @override
  String get referralsLinkLabel => 'Link Referral';

  @override
  String get referralsLinkCopied => 'Link copiato!';

  @override
  String get referralsActivityTitle => 'Attività dell\'Utente Invitato';

  @override
  String get referralsNoActivityData => 'Nessun dato di attività';

  @override
  String get referralsActivityWillAppear =>
      'L\'attività apparirà non appena l\'utente sarà attivo.';

  @override
  String get referralsWindowSection => 'Finestra Referral';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'Abbonamenti ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'Eventi di Utilizzo App ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'Codici Promo Riscattati ($count)';
  }

  @override
  String get referralsNoActivityYet => 'Nessuna attività ancora';

  @override
  String referralsItemFallback(int index) {
    return 'Elemento $index';
  }

  @override
  String get supportTicketsTitle => 'Ticket di Assistenza';

  @override
  String get supportFilterAll => 'Tutti';

  @override
  String get supportFilterOpen => 'Aperti';

  @override
  String get supportFilterPending => 'In Sospeso';

  @override
  String get supportFilterClosed => 'Chiusi';

  @override
  String get supportEmptyTitle => 'Nessun ticket ancora';

  @override
  String get supportEmptyMessage =>
      'Tocca + per aprire un nuovo ticket di assistenza.';

  @override
  String get newTicketTitle => 'Nuovo Ticket';

  @override
  String get newTicketSubmitted => 'Ticket inviato con successo!';

  @override
  String get newTicketCategoryLabel => 'Categoria';

  @override
  String get newTicketPriorityLabel => 'Priorità';

  @override
  String get newTicketSubjectLabel => 'Oggetto';

  @override
  String get newTicketSubjectRequired => 'L\'oggetto è obbligatorio';

  @override
  String get newTicketMessageLabel => 'Messaggio';

  @override
  String get newTicketMessageRequired => 'Il messaggio è obbligatorio';

  @override
  String get newTicketSubmitButton => 'Invia Ticket';

  @override
  String get newTicketCategoryTechnical => 'Tecnico';

  @override
  String get newTicketCategoryPayment => 'Pagamento';

  @override
  String get newTicketPriorityNormal => 'Normale';

  @override
  String get newTicketPriorityHigh => 'Alta';

  @override
  String get newTicketPriorityUrgent => 'Urgente';

  @override
  String get ticketDetailRefreshTooltip => 'Aggiorna';

  @override
  String get ticketDetailNoReplies => 'Nessuna risposta ancora.';

  @override
  String get ticketDetailTeamWillRespond =>
      'Il nostro team risponderà a breve.';

  @override
  String get ticketDetailReplyHint => 'Scrivi una risposta...';

  @override
  String get ticketDetailClosed => 'Questo ticket è chiuso.';

  @override
  String get agreementsTitle => 'Accordi Legali';

  @override
  String get agreementsAccepted => 'Accordo accettato';

  @override
  String get agreementsAllAcceptedTitle =>
      'Tutti gli accordi sono stati accettati!';

  @override
  String get agreementsNoPending => 'Non hai accordi in sospeso.';

  @override
  String get agreementsAcceptedStatus => 'Accettato';

  @override
  String get agreementsPendingStatus => 'In attesa della tua accettazione';

  @override
  String get agreementsCheckboxLabel =>
      'Ho letto e accetto i termini sopra indicati';

  @override
  String get agreementsAcceptButton => 'Accetta Accordo';

  @override
  String get knowledgeCenterTitle => 'Base di Conoscenza';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'Per Iniziare';

  @override
  String get knowledgeCenterCategoryPayments => 'Pagamenti';

  @override
  String get knowledgeCenterCategoryAppsTools => 'App e Strumenti';

  @override
  String get knowledgeCenterCategoryAccount => 'Account';

  @override
  String get knowledgeCenterEmptyTitle => 'Nessun articolo ancora';

  @override
  String get knowledgeCenterEmptyMessage =>
      'Torna più tardi per nuovi contenuti.';

  @override
  String get subscriptionPageStub => 'Pagina Abbonamenti';
}
