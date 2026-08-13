// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Guide touristique NileTech';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonTryAgain => 'Réessayez';

  @override
  String get commonLoading => 'Chargement...';

  @override
  String get commonSubmit => 'Envoyer';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonActive => 'Actif';

  @override
  String get commonCopied => 'Copié!';

  @override
  String get commonContactSupport => 'Contacter l\'assistance';

  @override
  String get commonPayoutsUnavailable =>
      'Les paiements sont disponibles une fois votre compte vérifié.';

  @override
  String get commonPleaseContactSupport => 'Veuillez contacter l\'assistance.';

  @override
  String get commonLogout => 'Déconnexion';

  @override
  String get commonLogoutConfirm =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get commonSomethingWentWrong => 'Une erreur s\'est produite';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSubtitle => 'Choisissez votre langue préférée';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageArabic => 'Arabe';

  @override
  String get languageChinese => 'Chinois';

  @override
  String get languageRussian => 'Russe';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageTurkish => 'Turc';

  @override
  String get languageItalian => 'Italien';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageJapanese => 'Japonais';

  @override
  String get languageKorean => 'Coréen';

  @override
  String get navHome => 'Accueil';

  @override
  String get navMarketplace => 'Marché';

  @override
  String get navWallet => 'Portefeuille';

  @override
  String get navSupport => 'Assistance';

  @override
  String get navProfile => 'Profil';

  @override
  String get validatorEmailRequired => 'L\'e-mail est requis';

  @override
  String get validatorEmailInvalid => 'Entrez une adresse e-mail valide';

  @override
  String get validatorPasswordRequired => 'Le mot de passe est requis';

  @override
  String get validatorPasswordTooShort =>
      'Le mot de passe doit contenir au moins 8 caractères';

  @override
  String get validatorConfirmPasswordRequired =>
      'Veuillez confirmer votre mot de passe';

  @override
  String get validatorPasswordMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String validatorFieldRequired(String field) {
    return '$field est requis';
  }

  @override
  String get validatorDefaultFieldName => 'Ce champ';

  @override
  String get validatorAmountRequired => 'Le montant est requis';

  @override
  String get validatorAmountInvalid => 'Entrez un montant valide';

  @override
  String validatorMinimumAmount(String min) {
    return 'Le montant minimum est de \$$min';
  }

  @override
  String get authTagline => 'Votre guide. Votre entreprise.';

  @override
  String get loginWelcomeBack => 'Bienvenue à nouveau';

  @override
  String get loginSubtitle => 'Connectez-vous à votre compte guide';

  @override
  String get loginEmailLabel => 'Adresse e-mail';

  @override
  String get loginPasswordLabel => 'Mot de passe';

  @override
  String get loginForgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginButton => 'Connexion';

  @override
  String get loginNoAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get loginRegisterLink => 'S\'inscrire';

  @override
  String get registerHeading => 'Créer un compte';

  @override
  String get registerSubtitle =>
      'Rejoignez NileTech en tant que guide touristique';

  @override
  String get registerFullNameLabel => 'Nom complet';

  @override
  String get registerEmailLabel => 'Courriel';

  @override
  String get registerPasswordLabel => 'Mot de passe';

  @override
  String get registerConfirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get registerReferralCodeLabel => 'Code de référence (facultatif)';

  @override
  String get registerButton => 'Créer un compte';

  @override
  String get registerAlreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get registerLoginLink => 'Connexion';

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié';

  @override
  String get forgotPasswordHeading => 'Réinitialisez votre mot de passe';

  @override
  String get forgotPasswordSubtitle =>
      'Entrez votre e-mail et nous vous enverrons un lien de réinitialisation.';

  @override
  String get forgotPasswordEmailLabel => 'Adresse e-mail';

  @override
  String get forgotPasswordSendButton => 'Envoyer le lien de réinitialisation';

  @override
  String get forgotPasswordSuccessHeading =>
      'Vérifiez votre boîte de réception';

  @override
  String get forgotPasswordSuccessBody =>
      'Un lien de réinitialisation du mot de passe a été envoyé à votre adresse e-mail.';

  @override
  String get verifyEmailResentSnackbar => 'E-mail de vérification renvoyé';

  @override
  String get verifyEmailHeading => 'Vérifiez votre e-mail';

  @override
  String get verifyEmailBody =>
      'Nous avons envoyé un lien de vérification à votre adresse e-mail. Veuillez vérifier votre boîte de réception et cliquer sur le lien pour activer votre compte.';

  @override
  String get verifyEmailContinueButton => 'J\'ai vérifié, continuer';

  @override
  String get verifyEmailResendButton => 'Renvoyer l\'e-mail';

  @override
  String get homeVerificationRequiredTitle => 'Vérification requise';

  @override
  String get homeAccountUnderReviewTitle => 'Compte en cours de révision';

  @override
  String get homeApplicationRejectedTitle => 'Demande rejetée';

  @override
  String get homeVerificationRequiredMessage =>
      'Vous devez soumettre vos documents de vérification avant de pouvoir accéder à l\'application.';

  @override
  String get homePendingReviewMessage =>
      'Votre demande de guide est en cours d’examen par notre équipe. Vous serez averti une fois approuvé.';

  @override
  String get homeRejectedMessage =>
      'Votre candidature n\'a pas été approuvée. Veuillez consulter les notes ci-dessous et contacter l\'assistance.';

  @override
  String get homeSubmitVerificationCta => 'Soumettre la vérification';

  @override
  String get homeReviewNotesLabel => 'Notes de révision';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bonjour';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'Votre solde';

  @override
  String get homeRequestPayout => 'Demander un paiement';

  @override
  String get homeCommissions => 'Commissions';

  @override
  String get homeReferrals => 'Références';

  @override
  String get homeAnnouncements => 'Annonces';

  @override
  String get homeMyPromoCodes => 'Mes codes promotionnels';

  @override
  String get homeNoPromoCodes => 'Pas encore de codes promo';

  @override
  String get homePendingBannerMessage =>
      'Votre vérification est en cours d\'examen. Vous pouvez parcourir l\'application, mais vous ne pouvez pas créer de codes promotionnels, de références ou demander des paiements tant qu\'ils n\'ont pas été approuvés.';

  @override
  String get notificationsTrayTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Marquer tout comme lu';

  @override
  String get notificationsEmptyTitle => 'Aucune notification pour l\'instant';

  @override
  String get notificationsEmptyMessage => 'Vous êtes tous rattrapés !';

  @override
  String get notificationsNewSection => 'Nouveau';

  @override
  String get notificationsEarlierSection => 'Plus tôt';

  @override
  String get profileTitle => 'Mon profil';

  @override
  String get profileEditUnavailable =>
      'La modification du profil est disponible une fois votre compte vérifié.';

  @override
  String get profileCompleteness => 'Complétude du profil';

  @override
  String get profileCountry => 'Pays';

  @override
  String get profileCity => 'Ville';

  @override
  String get profileYearsExperienceLabel => 'Années d\'expérience';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ans',
      one: '$count an',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'Langues';

  @override
  String get profileSpecializations => 'Spécialisations';

  @override
  String get profileBio => 'Biographie';

  @override
  String get profileNoBio => 'Aucune bio ajoutée pour l\'instant.';

  @override
  String get profileDeleteAccount => 'Supprimer le compte';

  @override
  String get profileDeleteConfirm =>
      'Cette action est permanente et ne peut être annulée. Es-tu sûr?';

  @override
  String get profileWallet => 'Portefeuille';

  @override
  String get profileViewAll => 'Tout afficher →';

  @override
  String get profileAvailableBalance => 'Solde disponible';

  @override
  String get profilePayoutAccount => 'Compte de paiement';

  @override
  String get profileManage => 'Gérer →';

  @override
  String get profileSetupPayoutAccount => 'Créer un compte de paiement';

  @override
  String get profileUpdatedSuccess => 'Profil mis à jour avec succès !';

  @override
  String get editProfileTitle => 'Modifier le profil';

  @override
  String get editProfileChangePhoto => 'Changer de photo';

  @override
  String get editProfileSelectCountry => 'Sélectionnez un pays';

  @override
  String get editProfileSaveChanges => 'Enregistrer les modifications';

  @override
  String get editProfileSelectCountryTitle => 'Sélectionnez un pays';

  @override
  String get editProfileSearchCountryHint => 'Rechercher un pays...';

  @override
  String editProfileSelectItemTitle(String title) {
    return 'Sélectionnez $title';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'Terminé ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'Rechercher...';

  @override
  String editProfileApplyCount(int count) {
    return 'Appliquer ($count sélectionné)';
  }

  @override
  String get editProfileAddChip => '+ Ajouter';

  @override
  String get verificationTitle => 'Vérification d\'identité';

  @override
  String get verificationDocumentDetails => 'Détails du document';

  @override
  String get verificationNationalIdLabel =>
      'Numéro d\'identification nationale';

  @override
  String get verificationLicenseLabel => 'Numéro de licence de guide';

  @override
  String get verificationUploadDocuments => 'Télécharger des documents';

  @override
  String get verificationUploadCaption =>
      'Veuillez télécharger des copies claires et lisibles de vos documents.';

  @override
  String get verificationIdFrontTitle => 'Carte d\'identité nationale — avant';

  @override
  String get verificationIdFrontSubtitle =>
      'Recto de votre carte d\'identité nationale';

  @override
  String get verificationFormatMax2mb => 'JPEG ou PNG • Max 2 Mo';

  @override
  String get verificationIdBackTitle => 'Carte d\'identité nationale — Retour';

  @override
  String get verificationIdBackSubtitle =>
      'Verso de votre carte d\'identité nationale';

  @override
  String get verificationLicenseTitle => 'Licence de guide';

  @override
  String get verificationLicenseSubtitle =>
      'Document officiel de licence de guide touristique';

  @override
  String get verificationFormatMax5mb => 'JPEG ou PNG • Max 5 Mo';

  @override
  String get verificationSubmitButton => 'Soumettre pour vérification';

  @override
  String get verificationUploaded => 'Téléchargé';

  @override
  String get verificationTapToUpload => 'Appuyez pour télécharger';

  @override
  String get verificationRejectedBanner =>
      'Vos documents ont été rejetés. Veuillez soumettre à nouveau.';

  @override
  String get verificationPendingBanner =>
      'Vos documents sont en cours de révision. Nous vous informerons.';

  @override
  String get verificationSubmittedDocuments => 'Documents soumis';

  @override
  String get verificationVerifiedTitle => 'Identité vérifiée';

  @override
  String get verificationVerifiedSubtitle =>
      'Votre identité a été vérifiée avec succès.';

  @override
  String get verificationSuccessHeading => 'Documents soumis';

  @override
  String get verificationSuccessBody =>
      'Vos documents de vérification ont été soumis avec succès. Notre équipe les examinera et vous informera du résultat.';

  @override
  String get verificationSuccessInfoBanner =>
      'L\'examen prend généralement 1 à 3 jours ouvrables.';

  @override
  String get verificationGoHome => 'Aller à la maison';

  @override
  String get marketplaceTitle => 'Marché';

  @override
  String get marketplaceSearchHint => 'Rechercher des applications...';

  @override
  String get marketplaceEmptyTitle => 'Aucune application disponible';

  @override
  String get marketplaceEmptyMessage =>
      'Revenez plus tard pour de nouvelles applications.';

  @override
  String get marketplaceViewDetails => 'Voir les détails →';

  @override
  String get appDetailsCouldNotOpenStore =>
      'Impossible d\'ouvrir le lien du magasin';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'Magasin d\'applications';

  @override
  String get appDetailsAbout => 'À propos';

  @override
  String get appDetailsAvailablePlans => 'Forfaits disponibles';

  @override
  String get appDetailsPromoUnavailable =>
      'Les codes promotionnels sont disponibles une fois votre compte vérifié.';

  @override
  String get appDetailsGenerateButton => '+ Générer';

  @override
  String get appDetailsFailedLoadPromoCodes =>
      'Échec du chargement des codes promotionnels.';

  @override
  String get appDetailsGenerateHint =>
      'Appuyez sur \"+ Générer\" pour créer votre premier code.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'Échec de la génération du code promotionnel. Veuillez réessayer.';

  @override
  String get appDetailsCopyTooltip => 'Copier';

  @override
  String get appDetailsFailedLoadUsage =>
      'Échec du chargement de l\'utilisation.';

  @override
  String get appDetailsNoUsage => 'Pas encore d\'utilisation';

  @override
  String get appDetailsCreatePromoTitle => 'Créer un code promotionnel';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'Saisissez un nom personnalisé pour votre code promotionnel ou laissez-le vide pour en générer un automatiquement.';

  @override
  String get appDetailsPromoNameLabel =>
      'Nom du code promotionnel (facultatif)';

  @override
  String get appDetailsPromoNameHint =>
      'par ex. AHMED20 — laisser vide pour générer automatiquement';

  @override
  String get appDetailsGenerate => 'Générer';

  @override
  String get appDetailsPreview => 'Aperçu';

  @override
  String get appDetailsFree => 'Gratuit';

  @override
  String get walletTitle => 'Portefeuille';

  @override
  String get walletTransactionHistory => 'Historique des transactions';

  @override
  String get walletNoTransactions => 'Aucune transaction pour l\'instant';

  @override
  String get walletNoTransactionsMessage =>
      'L’historique de vos transactions apparaîtra ici.';

  @override
  String get walletPayoutRequestsTitle => 'Demandes de paiement';

  @override
  String get walletPayoutRequestsSubtitle => 'Afficher et gérer vos paiements';

  @override
  String get payoutProfileSaved => 'Profil de paiement enregistré !';

  @override
  String get payoutRequestSubmitted => 'Demande de paiement soumise';

  @override
  String get payoutMethodTitle => 'Méthode de paiement';

  @override
  String get payoutPaymentDetailsTitle => 'Détails du paiement';

  @override
  String get payoutManageAccount => 'Gérer le compte de paiement';

  @override
  String get payoutHistorySection => 'Histoire';

  @override
  String get payoutNoRequests => 'Aucune demande de paiement pour l\'instant';

  @override
  String get payoutNoRequestsMessage =>
      'Vos demandes de paiement apparaîtront ici.';

  @override
  String get payoutChooseMethod =>
      'Choisissez comment vous souhaitez recevoir votre argent.';

  @override
  String get payoutNoMethodsAvailable => 'Aucun mode de paiement disponible';

  @override
  String get payoutInfoBanner =>
      'Ces informations sont enregistrées dans votre profil de paiement et utilisées pour tous les retraits futurs.';

  @override
  String get payoutSaveContinue => 'Enregistrer et continuer';

  @override
  String payoutAvailableAmount(String amount) {
    return 'Disponible : $amount';
  }

  @override
  String get payoutChange => 'Changement';

  @override
  String get payoutAmountHint => '0,00';

  @override
  String get payoutMinimumHelper =>
      'Le montant minimum du paiement est de 10 \$';

  @override
  String get payoutSubmitRequest => 'Soumettre la demande';

  @override
  String get payoutAmountLabel => 'Montant (USD)';

  @override
  String get paymentMethodsSaved => 'Compte de paiement enregistré !';

  @override
  String get paymentMethodsTitle => 'Méthodes de paiement';

  @override
  String get paymentMethodsNoneAvailable => 'Aucun mode de paiement disponible';

  @override
  String get paymentMethodsChoose => 'Choisissez un mode de paiement';

  @override
  String get paymentMethodsAll => 'Toutes les méthodes';

  @override
  String get paymentMethodsActiveBadge => 'ACTIF';

  @override
  String get paymentMethodsSetUp => 'Configurer';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return 'Mettez à jour vos informations de paiement enregistrées pour $methodName.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'Cela deviendra votre compte de paiement actif.';

  @override
  String get paymentMethodsSetActiveButton => 'Définir comme compte actif';

  @override
  String get commissionsTitle => 'Commissions';

  @override
  String get commissionsTotalEarned => 'Commissions totales gagnées';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '$count transaction',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => 'Historique des commissions';

  @override
  String get commissionsEmptyTitle => 'Pas encore de commissions';

  @override
  String get commissionsEmptyMessage =>
      'Vos commissions gagnées apparaîtront ici.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'Code promotionnel : $code';
  }

  @override
  String get commissionsDirectSale => 'Vente directe';

  @override
  String get referralsTitle => 'Références';

  @override
  String get referralsTotal => 'Total des références';

  @override
  String get referralsTotalEarned => 'Total gagné';

  @override
  String get referralsGenerateNew => 'Générer un nouveau code de parrainage';

  @override
  String get referralsUnavailable =>
      'Les liens de parrainage sont disponibles une fois votre compte vérifié.';

  @override
  String get referralsCodesSection => 'Codes de référence';

  @override
  String get referralsEmptyTitle => 'Aucune référence pour l\'instant';

  @override
  String get referralsEmptyMessage =>
      'Générez un code et partagez-le pour commencer à gagner !';

  @override
  String get referralsCodeCopied => 'Code copié !';

  @override
  String referralsUsedBy(String user) {
    return 'Utilisé par $user';
  }

  @override
  String get referralsNotUsedYet => 'Pas encore utilisé';

  @override
  String referralsRegisteredOn(String date) {
    return 'Enregistré $date';
  }

  @override
  String get referralsLinkGeneratedTitle => 'Lien de parrainage généré';

  @override
  String get referralsShareSubtitle =>
      'Partagez votre code ou votre lien pour commencer à gagner.';

  @override
  String get referralsCodeLabel => 'Code de référence';

  @override
  String get referralsLinkLabel => 'Lien de référence';

  @override
  String get referralsLinkCopied => 'Lien copié !';

  @override
  String get referralsActivityTitle => 'Activité des utilisateurs référés';

  @override
  String get referralsNoActivityData => 'Aucune donnée d\'activité';

  @override
  String get referralsActivityWillAppear =>
      'L\'activité apparaîtra une fois que l\'utilisateur sera actif.';

  @override
  String get referralsWindowSection => 'Fenêtre de référence';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'Abonnements ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'Événements d\'utilisation d\'applications ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'Échanges promotionnels ($count)';
  }

  @override
  String get referralsNoActivityYet => 'Aucune activité pour le moment';

  @override
  String referralsItemFallback(int index) {
    return 'Article $index';
  }

  @override
  String get supportTicketsTitle => 'Billets d\'assistance';

  @override
  String get supportFilterAll => 'Tout';

  @override
  String get supportFilterOpen => 'Ouvert';

  @override
  String get supportFilterPending => 'En attente';

  @override
  String get supportFilterClosed => 'Fermé';

  @override
  String get supportEmptyTitle => 'Pas encore de billets';

  @override
  String get supportEmptyMessage =>
      'Appuyez sur + pour ouvrir un nouveau ticket d\'assistance.';

  @override
  String get newTicketTitle => 'Nouveau billet';

  @override
  String get newTicketSubmitted => 'Billet soumis avec succès !';

  @override
  String get newTicketCategoryLabel => 'Catégorie';

  @override
  String get newTicketPriorityLabel => 'Priorité';

  @override
  String get newTicketSubjectLabel => 'Sujet';

  @override
  String get newTicketSubjectRequired => 'Le sujet est obligatoire';

  @override
  String get newTicketMessageLabel => 'Message';

  @override
  String get newTicketMessageRequired => 'Le message est requis';

  @override
  String get newTicketSubmitButton => 'Soumettre le billet';

  @override
  String get newTicketCategoryTechnical => 'Technique';

  @override
  String get newTicketCategoryPayment => 'Paiement';

  @override
  String get newTicketPriorityNormal => 'Normale';

  @override
  String get newTicketPriorityHigh => 'Élevé';

  @override
  String get newTicketPriorityUrgent => 'Urgent';

  @override
  String get ticketDetailRefreshTooltip => 'Actualiser';

  @override
  String get ticketDetailNoReplies => 'Aucune réponse pour l\'instant.';

  @override
  String get ticketDetailTeamWillRespond =>
      'Notre équipe vous répondra sous peu.';

  @override
  String get ticketDetailReplyHint => 'Tapez une réponse...';

  @override
  String get ticketDetailClosed => 'Ce ticket est fermé.';

  @override
  String get agreementsTitle => 'Accords juridiques';

  @override
  String get agreementsAccepted => 'Accord accepté';

  @override
  String get agreementsAllAcceptedTitle => 'Tous accords acceptés !';

  @override
  String get agreementsNoPending => 'Vous n’avez aucun accord en attente.';

  @override
  String get agreementsAcceptedStatus => 'Accepté';

  @override
  String get agreementsPendingStatus => 'En attendant votre acceptation';

  @override
  String get agreementsCheckboxLabel =>
      'J\'ai lu et j\'accepte les conditions ci-dessus';

  @override
  String get agreementsAcceptButton => 'Accepter l\'accord';

  @override
  String get knowledgeCenterTitle => 'Centre de connaissances';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'Commencer';

  @override
  String get knowledgeCenterCategoryPayments => 'Paiements';

  @override
  String get knowledgeCenterCategoryAppsTools => 'Applications et outils';

  @override
  String get knowledgeCenterCategoryAccount => 'Compte';

  @override
  String get knowledgeCenterEmptyTitle => 'Pas encore d\'articles';

  @override
  String get knowledgeCenterEmptyMessage =>
      'Revenez plus tard pour du nouveau contenu.';

  @override
  String get subscriptionPageStub => 'Page d\'abonnements';
}
