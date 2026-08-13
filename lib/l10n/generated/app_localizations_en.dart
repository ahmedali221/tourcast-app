// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NileTech Tour Guide';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonTryAgain => 'Try Again';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonSubmit => 'Submit';

  @override
  String get commonNext => 'Next';

  @override
  String get commonBack => 'Back';

  @override
  String get commonDone => 'Done';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonActive => 'Active';

  @override
  String get commonCopied => 'Copied!';

  @override
  String get commonContactSupport => 'Contact Support';

  @override
  String get commonPayoutsUnavailable =>
      'Payouts are available once your account is verified.';

  @override
  String get commonPleaseContactSupport => 'Please contact support.';

  @override
  String get commonLogout => 'Logout';

  @override
  String get commonLogoutConfirm => 'Are you sure you want to logout?';

  @override
  String get commonSomethingWentWrong =>
      'Something went wrong. Please try again.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Choose your preferred language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageGerman => 'German';

  @override
  String get languageFrench => 'French';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get languageItalian => 'Italian';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageJapanese => 'Japanese';

  @override
  String get languageKorean => 'Korean';

  @override
  String get navHome => 'Home';

  @override
  String get navMarketplace => 'Marketplace';

  @override
  String get navWallet => 'Wallet';

  @override
  String get navSupport => 'Support';

  @override
  String get navProfile => 'Profile';

  @override
  String get validatorEmailRequired => 'Email is required';

  @override
  String get validatorEmailInvalid => 'Enter a valid email address';

  @override
  String get validatorPasswordRequired => 'Password is required';

  @override
  String get validatorPasswordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get validatorConfirmPasswordRequired => 'Please confirm your password';

  @override
  String get validatorPasswordMismatch => 'Passwords do not match';

  @override
  String validatorFieldRequired(String field) {
    return '$field is required';
  }

  @override
  String get validatorDefaultFieldName => 'This field';

  @override
  String get validatorAmountRequired => 'Amount is required';

  @override
  String get validatorAmountInvalid => 'Enter a valid amount';

  @override
  String validatorMinimumAmount(String min) {
    return 'Minimum amount is \$$min';
  }

  @override
  String get authTagline => 'Your Guide. Your Business.';

  @override
  String get loginWelcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Login to your guide account';

  @override
  String get loginEmailLabel => 'Email Address';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginForgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'Login';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginRegisterLink => 'Register';

  @override
  String get registerHeading => 'Create Account';

  @override
  String get registerSubtitle => 'Join NileTech as a Tour Guide';

  @override
  String get registerFullNameLabel => 'Full Name';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerConfirmPasswordLabel => 'Confirm Password';

  @override
  String get registerReferralCodeLabel => 'Referral Code (Optional)';

  @override
  String get registerButton => 'Create Account';

  @override
  String get registerAlreadyHaveAccount => 'Already have an account?';

  @override
  String get registerLoginLink => 'Login';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordHeading => 'Reset your password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email and we\'ll send you a reset link.';

  @override
  String get forgotPasswordEmailLabel => 'Email Address';

  @override
  String get forgotPasswordSendButton => 'Send Reset Link';

  @override
  String get forgotPasswordSuccessHeading => 'Check your inbox';

  @override
  String get forgotPasswordSuccessBody =>
      'A password reset link has been sent to your email address.';

  @override
  String get verifyEmailResentSnackbar => 'Verification email resent';

  @override
  String get verifyEmailHeading => 'Verify Your Email';

  @override
  String get verifyEmailBody =>
      'We sent a verification link to your email. Please check your inbox and click the link to activate your account.';

  @override
  String get verifyEmailContinueButton => 'I\'ve Verified, Continue';

  @override
  String get verifyEmailResendButton => 'Resend Email';

  @override
  String get homeVerificationRequiredTitle => 'Verification Required';

  @override
  String get homeAccountUnderReviewTitle => 'Account Under Review';

  @override
  String get homeApplicationRejectedTitle => 'Application Rejected';

  @override
  String get homeVerificationRequiredMessage =>
      'You need to submit your verification documents before you can access the app.';

  @override
  String get homePendingReviewMessage =>
      'Your guide application is being reviewed by our team. You\'ll be notified once approved.';

  @override
  String get homeRejectedMessage =>
      'Your application was not approved. Please review the notes below and contact support.';

  @override
  String get homeSubmitVerificationCta => 'Submit Verification';

  @override
  String get homeReviewNotesLabel => 'Review Notes';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'Your Balance';

  @override
  String get homeRequestPayout => 'Request Payout';

  @override
  String get homeCommissions => 'Commissions';

  @override
  String get homeReferrals => 'Referrals';

  @override
  String get homeAnnouncements => 'Announcements';

  @override
  String get homeMyPromoCodes => 'My Promo Codes';

  @override
  String get homeNoPromoCodes => 'No promo codes yet';

  @override
  String get homePendingBannerMessage =>
      'Your verification is being reviewed. You can browse the app but cannot create promo codes, referrals, or request payouts until approved.';

  @override
  String get notificationsTrayTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsEmptyTitle => 'No notifications yet';

  @override
  String get notificationsEmptyMessage => 'You\'re all caught up!';

  @override
  String get notificationsNewSection => 'New';

  @override
  String get notificationsEarlierSection => 'Earlier';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get profileEditUnavailable =>
      'Profile editing is available once your account is verified.';

  @override
  String get profileCompleteness => 'Profile Completeness';

  @override
  String get profileCountry => 'Country';

  @override
  String get profileCity => 'City';

  @override
  String get profileYearsExperienceLabel => 'Years of Experience';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'Languages';

  @override
  String get profileSpecializations => 'Specializations';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileNoBio => 'No bio added yet.';

  @override
  String get profileDeleteAccount => 'Delete Account';

  @override
  String get profileDeleteConfirm =>
      'This action is permanent and cannot be undone. Are you sure?';

  @override
  String get profileWallet => 'Wallet';

  @override
  String get profileViewAll => 'View all →';

  @override
  String get profileAvailableBalance => 'Available Balance';

  @override
  String get profilePayoutAccount => 'Payout Account';

  @override
  String get profileManage => 'Manage →';

  @override
  String get profileSetupPayoutAccount => 'Set up payout account';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully!';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get editProfileChangePhoto => 'Change Photo';

  @override
  String get editProfileSelectCountry => 'Select country';

  @override
  String get editProfileSaveChanges => 'Save Changes';

  @override
  String get editProfileSelectCountryTitle => 'Select Country';

  @override
  String get editProfileSearchCountryHint => 'Search country...';

  @override
  String editProfileSelectItemTitle(String title) {
    return 'Select $title';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'Done ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'Search...';

  @override
  String editProfileApplyCount(int count) {
    return 'Apply ($count selected)';
  }

  @override
  String get editProfileAddChip => '+ Add';

  @override
  String get verificationTitle => 'Identity Verification';

  @override
  String get verificationDocumentDetails => 'Document Details';

  @override
  String get verificationNationalIdLabel => 'National ID Number';

  @override
  String get verificationLicenseLabel => 'Guide License Number';

  @override
  String get verificationUploadDocuments => 'Upload Documents';

  @override
  String get verificationUploadCaption =>
      'Please upload clear, legible copies of your documents.';

  @override
  String get verificationIdFrontTitle => 'National ID — Front';

  @override
  String get verificationIdFrontSubtitle =>
      'Front side of your national ID card';

  @override
  String get verificationFormatMax2mb => 'JPEG or PNG • Max 2 MB';

  @override
  String get verificationIdBackTitle => 'National ID — Back';

  @override
  String get verificationIdBackSubtitle => 'Back side of your national ID card';

  @override
  String get verificationLicenseTitle => 'Guide License';

  @override
  String get verificationLicenseSubtitle =>
      'Official tour guide license document';

  @override
  String get verificationFormatMax5mb => 'JPEG or PNG • Max 5 MB';

  @override
  String get verificationSubmitButton => 'Submit for Verification';

  @override
  String get verificationUploaded => 'Uploaded';

  @override
  String get verificationTapToUpload => 'Tap to upload';

  @override
  String get verificationRejectedBanner =>
      'Your documents were rejected. Please resubmit.';

  @override
  String get verificationPendingBanner =>
      'Your documents are under review. We\'ll notify you.';

  @override
  String get verificationSubmittedDocuments => 'Submitted Documents';

  @override
  String get verificationVerifiedTitle => 'Identity Verified';

  @override
  String get verificationVerifiedSubtitle =>
      'Your identity has been successfully verified.';

  @override
  String get verificationSuccessHeading => 'Documents Submitted';

  @override
  String get verificationSuccessBody =>
      'Your verification documents have been submitted successfully. Our team will review them and notify you of the result.';

  @override
  String get verificationSuccessInfoBanner =>
      'Review typically takes 1–3 business days.';

  @override
  String get verificationGoHome => 'Go to Home';

  @override
  String get marketplaceTitle => 'Marketplace';

  @override
  String get marketplaceSearchHint => 'Search apps...';

  @override
  String get marketplaceEmptyTitle => 'No apps available';

  @override
  String get marketplaceEmptyMessage => 'Check back later for new apps.';

  @override
  String get marketplaceViewDetails => 'View Details →';

  @override
  String get appDetailsCouldNotOpenStore => 'Could not open store link';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => 'About';

  @override
  String get appDetailsAvailablePlans => 'Available Plans';

  @override
  String get appDetailsPromoUnavailable =>
      'Promo codes are available once your account is verified.';

  @override
  String get appDetailsGenerateButton => '+ Generate';

  @override
  String get appDetailsFailedLoadPromoCodes => 'Failed to load promo codes.';

  @override
  String get appDetailsGenerateHint =>
      'Tap \"+ Generate\" to create your first code.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'Failed to generate promo code. Please try again.';

  @override
  String get appDetailsCopyTooltip => 'Copy';

  @override
  String get appDetailsFailedLoadUsage => 'Failed to load usage.';

  @override
  String get appDetailsNoUsage => 'No usage yet';

  @override
  String get appDetailsCreatePromoTitle => 'Create Promo Code';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'Enter a custom name for your promo code, or leave it empty to auto-generate one.';

  @override
  String get appDetailsPromoNameLabel => 'Promo Code Name (optional)';

  @override
  String get appDetailsPromoNameHint =>
      'e.g. AHMED20 — leave empty to auto-generate';

  @override
  String get appDetailsGenerate => 'Generate';

  @override
  String get appDetailsPreview => 'Preview';

  @override
  String get appDetailsFree => 'Free';

  @override
  String get walletTitle => 'Wallet';

  @override
  String get walletTransactionHistory => 'Transaction History';

  @override
  String get walletNoTransactions => 'No transactions yet';

  @override
  String get walletNoTransactionsMessage =>
      'Your transaction history will appear here.';

  @override
  String get walletPayoutRequestsTitle => 'Payout Requests';

  @override
  String get walletPayoutRequestsSubtitle => 'View and manage your payouts';

  @override
  String get payoutProfileSaved => 'Payout profile saved!';

  @override
  String get payoutRequestSubmitted => 'Payout request submitted';

  @override
  String get payoutMethodTitle => 'Payout Method';

  @override
  String get payoutPaymentDetailsTitle => 'Payment Details';

  @override
  String get payoutManageAccount => 'Manage Payment Account';

  @override
  String get payoutHistorySection => 'History';

  @override
  String get payoutNoRequests => 'No payout requests yet';

  @override
  String get payoutNoRequestsMessage =>
      'Your payout requests will appear here.';

  @override
  String get payoutChooseMethod => 'Choose how you want to receive your money.';

  @override
  String get payoutNoMethodsAvailable => 'No payout methods available';

  @override
  String get payoutInfoBanner =>
      'This info is saved to your payout profile and used for all future withdrawals.';

  @override
  String get payoutSaveContinue => 'Save & Continue';

  @override
  String payoutAvailableAmount(String amount) {
    return 'Available: $amount';
  }

  @override
  String get payoutChange => 'Change';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => 'Minimum payout amount is \$10';

  @override
  String get payoutSubmitRequest => 'Submit Request';

  @override
  String get payoutAmountLabel => 'Amount (USD)';

  @override
  String get paymentMethodsSaved => 'Payment account saved!';

  @override
  String get paymentMethodsTitle => 'Payment Methods';

  @override
  String get paymentMethodsNoneAvailable => 'No payment methods available';

  @override
  String get paymentMethodsChoose => 'Choose a payment method';

  @override
  String get paymentMethodsAll => 'All Methods';

  @override
  String get paymentMethodsActiveBadge => 'ACTIVE';

  @override
  String get paymentMethodsSetUp => 'Set up';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return 'Update your saved payment details for $methodName.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'This will become your active payout account.';

  @override
  String get paymentMethodsSetActiveButton => 'Set as Active Account';

  @override
  String get commissionsTitle => 'Commissions';

  @override
  String get commissionsTotalEarned => 'Total Commissions Earned';

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
  String get commissionsHistorySection => 'Commission History';

  @override
  String get commissionsEmptyTitle => 'No commissions yet';

  @override
  String get commissionsEmptyMessage =>
      'Your earned commissions will appear here.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'Promo code: $code';
  }

  @override
  String get commissionsDirectSale => 'Direct sale';

  @override
  String get referralsTitle => 'Referrals';

  @override
  String get referralsTotal => 'Total Referrals';

  @override
  String get referralsTotalEarned => 'Total Earned';

  @override
  String get referralsGenerateNew => 'Generate New Referral Code';

  @override
  String get referralsUnavailable =>
      'Referral links are available once your account is verified.';

  @override
  String get referralsCodesSection => 'Referral Codes';

  @override
  String get referralsEmptyTitle => 'No referrals yet';

  @override
  String get referralsEmptyMessage =>
      'Generate a code and share it to start earning!';

  @override
  String get referralsCodeCopied => 'Code copied!';

  @override
  String referralsUsedBy(String user) {
    return 'Used by $user';
  }

  @override
  String get referralsNotUsedYet => 'Not used yet';

  @override
  String referralsRegisteredOn(String date) {
    return 'Registered $date';
  }

  @override
  String get referralsLinkGeneratedTitle => 'Referral Link Generated';

  @override
  String get referralsShareSubtitle =>
      'Share your code or link to start earning.';

  @override
  String get referralsCodeLabel => 'Referral Code';

  @override
  String get referralsLinkLabel => 'Referral Link';

  @override
  String get referralsLinkCopied => 'Link copied!';

  @override
  String get referralsActivityTitle => 'Referred User Activity';

  @override
  String get referralsNoActivityData => 'No activity data';

  @override
  String get referralsActivityWillAppear =>
      'Activity will appear once the user is active.';

  @override
  String get referralsWindowSection => 'Referral Window';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'Subscriptions ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'App Usage Events ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'Promo Redemptions ($count)';
  }

  @override
  String get referralsNoActivityYet => 'No activity yet';

  @override
  String referralsItemFallback(int index) {
    return 'Item $index';
  }

  @override
  String get supportTicketsTitle => 'Support Tickets';

  @override
  String get supportFilterAll => 'All';

  @override
  String get supportFilterOpen => 'Open';

  @override
  String get supportFilterPending => 'Pending';

  @override
  String get supportFilterClosed => 'Closed';

  @override
  String get supportEmptyTitle => 'No tickets yet';

  @override
  String get supportEmptyMessage => 'Tap + to open a new support ticket.';

  @override
  String get newTicketTitle => 'New Ticket';

  @override
  String get newTicketSubmitted => 'Ticket submitted successfully!';

  @override
  String get newTicketCategoryLabel => 'Category';

  @override
  String get newTicketPriorityLabel => 'Priority';

  @override
  String get newTicketSubjectLabel => 'Subject';

  @override
  String get newTicketSubjectRequired => 'Subject is required';

  @override
  String get newTicketMessageLabel => 'Message';

  @override
  String get newTicketMessageRequired => 'Message is required';

  @override
  String get newTicketSubmitButton => 'Submit Ticket';

  @override
  String get newTicketCategoryTechnical => 'Technical';

  @override
  String get newTicketCategoryPayment => 'Payment';

  @override
  String get newTicketPriorityNormal => 'Normal';

  @override
  String get newTicketPriorityHigh => 'High';

  @override
  String get newTicketPriorityUrgent => 'Urgent';

  @override
  String get ticketDetailRefreshTooltip => 'Refresh';

  @override
  String get ticketDetailNoReplies => 'No replies yet.';

  @override
  String get ticketDetailTeamWillRespond => 'Our team will respond shortly.';

  @override
  String get ticketDetailReplyHint => 'Type a reply...';

  @override
  String get ticketDetailClosed => 'This ticket is closed.';

  @override
  String get agreementsTitle => 'Legal Agreements';

  @override
  String get agreementsAccepted => 'Agreement accepted';

  @override
  String get agreementsAllAcceptedTitle => 'All agreements accepted!';

  @override
  String get agreementsNoPending => 'You have no pending agreements.';

  @override
  String get agreementsAcceptedStatus => 'Accepted';

  @override
  String get agreementsPendingStatus => 'Pending your acceptance';

  @override
  String get agreementsCheckboxLabel =>
      'I have read and agree to the terms above';

  @override
  String get agreementsAcceptButton => 'Accept Agreement';

  @override
  String get knowledgeCenterTitle => 'Knowledge Center';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'Getting Started';

  @override
  String get knowledgeCenterCategoryPayments => 'Payments';

  @override
  String get knowledgeCenterCategoryAppsTools => 'Apps & Tools';

  @override
  String get knowledgeCenterCategoryAccount => 'Account';

  @override
  String get knowledgeCenterEmptyTitle => 'No articles yet';

  @override
  String get knowledgeCenterEmptyMessage => 'Check back later for new content.';

  @override
  String get subscriptionPageStub => 'Subscriptions Page';
}
