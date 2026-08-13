import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// The application title shown in the task switcher and window title
  ///
  /// In en, this message translates to:
  /// **'NileTech Tour Guide'**
  String get appTitle;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get commonTryAgain;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// No description provided for @commonSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get commonSubmit;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get commonActive;

  /// No description provided for @commonCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied!'**
  String get commonCopied;

  /// No description provided for @commonContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get commonContactSupport;

  /// No description provided for @commonPayoutsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Payouts are available once your account is verified.'**
  String get commonPayoutsUnavailable;

  /// No description provided for @commonPleaseContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Please contact support.'**
  String get commonPleaseContactSupport;

  /// No description provided for @commonLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get commonLogout;

  /// No description provided for @commonLogoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get commonLogoutConfirm;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get commonSomethingWentWrong;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get settingsLanguageSubtitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChinese;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageTurkish;

  /// No description provided for @languageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get languageItalian;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapanese;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get languageKorean;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMarketplace.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get navMarketplace;

  /// No description provided for @navWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get navWallet;

  /// No description provided for @navSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get navSupport;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @validatorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validatorEmailRequired;

  /// No description provided for @validatorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validatorEmailInvalid;

  /// No description provided for @validatorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validatorPasswordRequired;

  /// No description provided for @validatorPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get validatorPasswordTooShort;

  /// No description provided for @validatorConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validatorConfirmPasswordRequired;

  /// No description provided for @validatorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validatorPasswordMismatch;

  /// No description provided for @validatorFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'{field} is required'**
  String validatorFieldRequired(String field);

  /// No description provided for @validatorDefaultFieldName.
  ///
  /// In en, this message translates to:
  /// **'This field'**
  String get validatorDefaultFieldName;

  /// No description provided for @validatorAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get validatorAmountRequired;

  /// No description provided for @validatorAmountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get validatorAmountInvalid;

  /// No description provided for @validatorMinimumAmount.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount is \${min}'**
  String validatorMinimumAmount(String min);

  /// No description provided for @authTagline.
  ///
  /// In en, this message translates to:
  /// **'Your Guide. Your Business.'**
  String get authTagline;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Login to your guide account'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// No description provided for @loginRegisterLink.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get loginRegisterLink;

  /// No description provided for @registerHeading.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerHeading;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join NileTech as a Tour Guide'**
  String get registerSubtitle;

  /// No description provided for @registerFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get registerFullNameLabel;

  /// No description provided for @registerEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailLabel;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerPasswordLabel;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerReferralCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Referral Code (Optional)'**
  String get registerReferralCodeLabel;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerButton;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerAlreadyHaveAccount;

  /// No description provided for @registerLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get registerLoginLink;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordHeading.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get forgotPasswordHeading;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get forgotPasswordEmailLabel;

  /// No description provided for @forgotPasswordSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get forgotPasswordSendButton;

  /// No description provided for @forgotPasswordSuccessHeading.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get forgotPasswordSuccessHeading;

  /// No description provided for @forgotPasswordSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'A password reset link has been sent to your email address.'**
  String get forgotPasswordSuccessBody;

  /// No description provided for @verifyEmailResentSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Verification email resent'**
  String get verifyEmailResentSnackbar;

  /// No description provided for @verifyEmailHeading.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyEmailHeading;

  /// No description provided for @verifyEmailBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification link to your email. Please check your inbox and click the link to activate your account.'**
  String get verifyEmailBody;

  /// No description provided for @verifyEmailContinueButton.
  ///
  /// In en, this message translates to:
  /// **'I\'ve Verified, Continue'**
  String get verifyEmailContinueButton;

  /// No description provided for @verifyEmailResendButton.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get verifyEmailResendButton;

  /// No description provided for @homeVerificationRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Required'**
  String get homeVerificationRequiredTitle;

  /// No description provided for @homeAccountUnderReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Under Review'**
  String get homeAccountUnderReviewTitle;

  /// No description provided for @homeApplicationRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Application Rejected'**
  String get homeApplicationRejectedTitle;

  /// No description provided for @homeVerificationRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'You need to submit your verification documents before you can access the app.'**
  String get homeVerificationRequiredMessage;

  /// No description provided for @homePendingReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Your guide application is being reviewed by our team. You\'ll be notified once approved.'**
  String get homePendingReviewMessage;

  /// No description provided for @homeRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your application was not approved. Please review the notes below and contact support.'**
  String get homeRejectedMessage;

  /// No description provided for @homeSubmitVerificationCta.
  ///
  /// In en, this message translates to:
  /// **'Submit Verification'**
  String get homeSubmitVerificationCta;

  /// No description provided for @homeReviewNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Review Notes'**
  String get homeReviewNotesLabel;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'{greeting}, {firstName} 👋'**
  String homeGreeting(String greeting, String firstName);

  /// No description provided for @homeYourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your Balance'**
  String get homeYourBalance;

  /// No description provided for @homeRequestPayout.
  ///
  /// In en, this message translates to:
  /// **'Request Payout'**
  String get homeRequestPayout;

  /// No description provided for @homeCommissions.
  ///
  /// In en, this message translates to:
  /// **'Commissions'**
  String get homeCommissions;

  /// No description provided for @homeReferrals.
  ///
  /// In en, this message translates to:
  /// **'Referrals'**
  String get homeReferrals;

  /// No description provided for @homeAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get homeAnnouncements;

  /// No description provided for @homeMyPromoCodes.
  ///
  /// In en, this message translates to:
  /// **'My Promo Codes'**
  String get homeMyPromoCodes;

  /// No description provided for @homeNoPromoCodes.
  ///
  /// In en, this message translates to:
  /// **'No promo codes yet'**
  String get homeNoPromoCodes;

  /// No description provided for @homePendingBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'Your verification is being reviewed. You can browse the app but cannot create promo codes, referrals, or request payouts until approved.'**
  String get homePendingBannerMessage;

  /// No description provided for @notificationsTrayTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTrayTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get notificationsEmptyMessage;

  /// No description provided for @notificationsNewSection.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get notificationsNewSection;

  /// No description provided for @notificationsEarlierSection.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notificationsEarlierSection;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @profileEditUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Profile editing is available once your account is verified.'**
  String get profileEditUnavailable;

  /// No description provided for @profileCompleteness.
  ///
  /// In en, this message translates to:
  /// **'Profile Completeness'**
  String get profileCompleteness;

  /// No description provided for @profileCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get profileCountry;

  /// No description provided for @profileCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get profileCity;

  /// No description provided for @profileYearsExperienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get profileYearsExperienceLabel;

  /// No description provided for @profileYearsExperienceValue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} year} other{{count} years}}'**
  String profileYearsExperienceValue(num count);

  /// No description provided for @profileMissingValue.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get profileMissingValue;

  /// No description provided for @profileLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get profileLanguages;

  /// No description provided for @profileSpecializations.
  ///
  /// In en, this message translates to:
  /// **'Specializations'**
  String get profileSpecializations;

  /// No description provided for @profileBio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get profileBio;

  /// No description provided for @profileNoBio.
  ///
  /// In en, this message translates to:
  /// **'No bio added yet.'**
  String get profileNoBio;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent and cannot be undone. Are you sure?'**
  String get profileDeleteConfirm;

  /// No description provided for @profileWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get profileWallet;

  /// No description provided for @profileViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all →'**
  String get profileViewAll;

  /// No description provided for @profileAvailableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get profileAvailableBalance;

  /// No description provided for @profilePayoutAccount.
  ///
  /// In en, this message translates to:
  /// **'Payout Account'**
  String get profilePayoutAccount;

  /// No description provided for @profileManage.
  ///
  /// In en, this message translates to:
  /// **'Manage →'**
  String get profileManage;

  /// No description provided for @profileSetupPayoutAccount.
  ///
  /// In en, this message translates to:
  /// **'Set up payout account'**
  String get profileSetupPayoutAccount;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccess;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @editProfileChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get editProfileChangePhoto;

  /// No description provided for @editProfileSelectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get editProfileSelectCountry;

  /// No description provided for @editProfileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get editProfileSaveChanges;

  /// No description provided for @editProfileSelectCountryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get editProfileSelectCountryTitle;

  /// No description provided for @editProfileSearchCountryHint.
  ///
  /// In en, this message translates to:
  /// **'Search country...'**
  String get editProfileSearchCountryHint;

  /// No description provided for @editProfileSelectItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Select {title}'**
  String editProfileSelectItemTitle(String title);

  /// No description provided for @editProfileDoneCount.
  ///
  /// In en, this message translates to:
  /// **'Done ({count})'**
  String editProfileDoneCount(int count);

  /// No description provided for @editProfileSearchGenericHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get editProfileSearchGenericHint;

  /// No description provided for @editProfileApplyCount.
  ///
  /// In en, this message translates to:
  /// **'Apply ({count} selected)'**
  String editProfileApplyCount(int count);

  /// No description provided for @editProfileAddChip.
  ///
  /// In en, this message translates to:
  /// **'+ Add'**
  String get editProfileAddChip;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get verificationTitle;

  /// No description provided for @verificationDocumentDetails.
  ///
  /// In en, this message translates to:
  /// **'Document Details'**
  String get verificationDocumentDetails;

  /// No description provided for @verificationNationalIdLabel.
  ///
  /// In en, this message translates to:
  /// **'National ID Number'**
  String get verificationNationalIdLabel;

  /// No description provided for @verificationLicenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Guide License Number'**
  String get verificationLicenseLabel;

  /// No description provided for @verificationUploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get verificationUploadDocuments;

  /// No description provided for @verificationUploadCaption.
  ///
  /// In en, this message translates to:
  /// **'Please upload clear, legible copies of your documents.'**
  String get verificationUploadCaption;

  /// No description provided for @verificationIdFrontTitle.
  ///
  /// In en, this message translates to:
  /// **'National ID — Front'**
  String get verificationIdFrontTitle;

  /// No description provided for @verificationIdFrontSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Front side of your national ID card'**
  String get verificationIdFrontSubtitle;

  /// No description provided for @verificationFormatMax2mb.
  ///
  /// In en, this message translates to:
  /// **'JPEG or PNG • Max 2 MB'**
  String get verificationFormatMax2mb;

  /// No description provided for @verificationIdBackTitle.
  ///
  /// In en, this message translates to:
  /// **'National ID — Back'**
  String get verificationIdBackTitle;

  /// No description provided for @verificationIdBackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Back side of your national ID card'**
  String get verificationIdBackSubtitle;

  /// No description provided for @verificationLicenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Guide License'**
  String get verificationLicenseTitle;

  /// No description provided for @verificationLicenseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Official tour guide license document'**
  String get verificationLicenseSubtitle;

  /// No description provided for @verificationFormatMax5mb.
  ///
  /// In en, this message translates to:
  /// **'JPEG or PNG • Max 5 MB'**
  String get verificationFormatMax5mb;

  /// No description provided for @verificationSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit for Verification'**
  String get verificationSubmitButton;

  /// No description provided for @verificationUploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get verificationUploaded;

  /// No description provided for @verificationTapToUpload.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload'**
  String get verificationTapToUpload;

  /// No description provided for @verificationRejectedBanner.
  ///
  /// In en, this message translates to:
  /// **'Your documents were rejected. Please resubmit.'**
  String get verificationRejectedBanner;

  /// No description provided for @verificationPendingBanner.
  ///
  /// In en, this message translates to:
  /// **'Your documents are under review. We\'ll notify you.'**
  String get verificationPendingBanner;

  /// No description provided for @verificationSubmittedDocuments.
  ///
  /// In en, this message translates to:
  /// **'Submitted Documents'**
  String get verificationSubmittedDocuments;

  /// No description provided for @verificationVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Identity Verified'**
  String get verificationVerifiedTitle;

  /// No description provided for @verificationVerifiedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your identity has been successfully verified.'**
  String get verificationVerifiedSubtitle;

  /// No description provided for @verificationSuccessHeading.
  ///
  /// In en, this message translates to:
  /// **'Documents Submitted'**
  String get verificationSuccessHeading;

  /// No description provided for @verificationSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'Your verification documents have been submitted successfully. Our team will review them and notify you of the result.'**
  String get verificationSuccessBody;

  /// No description provided for @verificationSuccessInfoBanner.
  ///
  /// In en, this message translates to:
  /// **'Review typically takes 1–3 business days.'**
  String get verificationSuccessInfoBanner;

  /// No description provided for @verificationGoHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get verificationGoHome;

  /// No description provided for @marketplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get marketplaceTitle;

  /// No description provided for @marketplaceSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search apps...'**
  String get marketplaceSearchHint;

  /// No description provided for @marketplaceEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No apps available'**
  String get marketplaceEmptyTitle;

  /// No description provided for @marketplaceEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Check back later for new apps.'**
  String get marketplaceEmptyMessage;

  /// No description provided for @marketplaceViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details →'**
  String get marketplaceViewDetails;

  /// No description provided for @appDetailsCouldNotOpenStore.
  ///
  /// In en, this message translates to:
  /// **'Could not open store link'**
  String get appDetailsCouldNotOpenStore;

  /// No description provided for @appDetailsGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Google Play'**
  String get appDetailsGooglePlay;

  /// No description provided for @appDetailsAppStore.
  ///
  /// In en, this message translates to:
  /// **'App Store'**
  String get appDetailsAppStore;

  /// No description provided for @appDetailsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get appDetailsAbout;

  /// No description provided for @appDetailsAvailablePlans.
  ///
  /// In en, this message translates to:
  /// **'Available Plans'**
  String get appDetailsAvailablePlans;

  /// No description provided for @appDetailsPromoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Promo codes are available once your account is verified.'**
  String get appDetailsPromoUnavailable;

  /// No description provided for @appDetailsGenerateButton.
  ///
  /// In en, this message translates to:
  /// **'+ Generate'**
  String get appDetailsGenerateButton;

  /// No description provided for @appDetailsFailedLoadPromoCodes.
  ///
  /// In en, this message translates to:
  /// **'Failed to load promo codes.'**
  String get appDetailsFailedLoadPromoCodes;

  /// No description provided for @appDetailsGenerateHint.
  ///
  /// In en, this message translates to:
  /// **'Tap \"+ Generate\" to create your first code.'**
  String get appDetailsGenerateHint;

  /// No description provided for @appDetailsFailedGeneratePromo.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate promo code. Please try again.'**
  String get appDetailsFailedGeneratePromo;

  /// No description provided for @appDetailsCopyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get appDetailsCopyTooltip;

  /// No description provided for @appDetailsFailedLoadUsage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load usage.'**
  String get appDetailsFailedLoadUsage;

  /// No description provided for @appDetailsNoUsage.
  ///
  /// In en, this message translates to:
  /// **'No usage yet'**
  String get appDetailsNoUsage;

  /// No description provided for @appDetailsCreatePromoTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Promo Code'**
  String get appDetailsCreatePromoTitle;

  /// No description provided for @appDetailsCreatePromoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a custom name for your promo code, or leave it empty to auto-generate one.'**
  String get appDetailsCreatePromoSubtitle;

  /// No description provided for @appDetailsPromoNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Promo Code Name (optional)'**
  String get appDetailsPromoNameLabel;

  /// No description provided for @appDetailsPromoNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. AHMED20 — leave empty to auto-generate'**
  String get appDetailsPromoNameHint;

  /// No description provided for @appDetailsGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get appDetailsGenerate;

  /// No description provided for @appDetailsPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get appDetailsPreview;

  /// No description provided for @appDetailsFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get appDetailsFree;

  /// No description provided for @walletTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletTitle;

  /// No description provided for @walletTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get walletTransactionHistory;

  /// No description provided for @walletNoTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get walletNoTransactions;

  /// No description provided for @walletNoTransactionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your transaction history will appear here.'**
  String get walletNoTransactionsMessage;

  /// No description provided for @walletPayoutRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payout Requests'**
  String get walletPayoutRequestsTitle;

  /// No description provided for @walletPayoutRequestsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage your payouts'**
  String get walletPayoutRequestsSubtitle;

  /// No description provided for @payoutProfileSaved.
  ///
  /// In en, this message translates to:
  /// **'Payout profile saved!'**
  String get payoutProfileSaved;

  /// No description provided for @payoutRequestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Payout request submitted'**
  String get payoutRequestSubmitted;

  /// No description provided for @payoutMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payout Method'**
  String get payoutMethodTitle;

  /// No description provided for @payoutPaymentDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get payoutPaymentDetailsTitle;

  /// No description provided for @payoutManageAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage Payment Account'**
  String get payoutManageAccount;

  /// No description provided for @payoutHistorySection.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get payoutHistorySection;

  /// No description provided for @payoutNoRequests.
  ///
  /// In en, this message translates to:
  /// **'No payout requests yet'**
  String get payoutNoRequests;

  /// No description provided for @payoutNoRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'Your payout requests will appear here.'**
  String get payoutNoRequestsMessage;

  /// No description provided for @payoutChooseMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to receive your money.'**
  String get payoutChooseMethod;

  /// No description provided for @payoutNoMethodsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No payout methods available'**
  String get payoutNoMethodsAvailable;

  /// No description provided for @payoutInfoBanner.
  ///
  /// In en, this message translates to:
  /// **'This info is saved to your payout profile and used for all future withdrawals.'**
  String get payoutInfoBanner;

  /// No description provided for @payoutSaveContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get payoutSaveContinue;

  /// No description provided for @payoutAvailableAmount.
  ///
  /// In en, this message translates to:
  /// **'Available: {amount}'**
  String payoutAvailableAmount(String amount);

  /// No description provided for @payoutChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get payoutChange;

  /// No description provided for @payoutAmountHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get payoutAmountHint;

  /// No description provided for @payoutMinimumHelper.
  ///
  /// In en, this message translates to:
  /// **'Minimum payout amount is \$10'**
  String get payoutMinimumHelper;

  /// No description provided for @payoutSubmitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get payoutSubmitRequest;

  /// No description provided for @payoutAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount (USD)'**
  String get payoutAmountLabel;

  /// No description provided for @paymentMethodsSaved.
  ///
  /// In en, this message translates to:
  /// **'Payment account saved!'**
  String get paymentMethodsSaved;

  /// No description provided for @paymentMethodsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethodsTitle;

  /// No description provided for @paymentMethodsNoneAvailable.
  ///
  /// In en, this message translates to:
  /// **'No payment methods available'**
  String get paymentMethodsNoneAvailable;

  /// No description provided for @paymentMethodsChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose a payment method'**
  String get paymentMethodsChoose;

  /// No description provided for @paymentMethodsAll.
  ///
  /// In en, this message translates to:
  /// **'All Methods'**
  String get paymentMethodsAll;

  /// No description provided for @paymentMethodsActiveBadge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get paymentMethodsActiveBadge;

  /// No description provided for @paymentMethodsSetUp.
  ///
  /// In en, this message translates to:
  /// **'Set up'**
  String get paymentMethodsSetUp;

  /// No description provided for @paymentMethodsUpdateInfo.
  ///
  /// In en, this message translates to:
  /// **'Update your saved payment details for {methodName}.'**
  String paymentMethodsUpdateInfo(String methodName);

  /// No description provided for @paymentMethodsBecomeActiveInfo.
  ///
  /// In en, this message translates to:
  /// **'This will become your active payout account.'**
  String get paymentMethodsBecomeActiveInfo;

  /// No description provided for @paymentMethodsSetActiveButton.
  ///
  /// In en, this message translates to:
  /// **'Set as Active Account'**
  String get paymentMethodsSetActiveButton;

  /// No description provided for @commissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Commissions'**
  String get commissionsTitle;

  /// No description provided for @commissionsTotalEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Commissions Earned'**
  String get commissionsTotalEarned;

  /// No description provided for @commissionsTransactionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} transaction} other{{count} transactions}}'**
  String commissionsTransactionsCount(num count);

  /// No description provided for @commissionsHistorySection.
  ///
  /// In en, this message translates to:
  /// **'Commission History'**
  String get commissionsHistorySection;

  /// No description provided for @commissionsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No commissions yet'**
  String get commissionsEmptyTitle;

  /// No description provided for @commissionsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your earned commissions will appear here.'**
  String get commissionsEmptyMessage;

  /// No description provided for @commissionsPromoCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Promo code: {code}'**
  String commissionsPromoCodeLabel(String code);

  /// No description provided for @commissionsDirectSale.
  ///
  /// In en, this message translates to:
  /// **'Direct sale'**
  String get commissionsDirectSale;

  /// No description provided for @referralsTitle.
  ///
  /// In en, this message translates to:
  /// **'Referrals'**
  String get referralsTitle;

  /// No description provided for @referralsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total Referrals'**
  String get referralsTotal;

  /// No description provided for @referralsTotalEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Earned'**
  String get referralsTotalEarned;

  /// No description provided for @referralsGenerateNew.
  ///
  /// In en, this message translates to:
  /// **'Generate New Referral Code'**
  String get referralsGenerateNew;

  /// No description provided for @referralsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Referral links are available once your account is verified.'**
  String get referralsUnavailable;

  /// No description provided for @referralsCodesSection.
  ///
  /// In en, this message translates to:
  /// **'Referral Codes'**
  String get referralsCodesSection;

  /// No description provided for @referralsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No referrals yet'**
  String get referralsEmptyTitle;

  /// No description provided for @referralsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Generate a code and share it to start earning!'**
  String get referralsEmptyMessage;

  /// No description provided for @referralsCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied!'**
  String get referralsCodeCopied;

  /// No description provided for @referralsUsedBy.
  ///
  /// In en, this message translates to:
  /// **'Used by {user}'**
  String referralsUsedBy(String user);

  /// No description provided for @referralsNotUsedYet.
  ///
  /// In en, this message translates to:
  /// **'Not used yet'**
  String get referralsNotUsedYet;

  /// No description provided for @referralsRegisteredOn.
  ///
  /// In en, this message translates to:
  /// **'Registered {date}'**
  String referralsRegisteredOn(String date);

  /// No description provided for @referralsLinkGeneratedTitle.
  ///
  /// In en, this message translates to:
  /// **'Referral Link Generated'**
  String get referralsLinkGeneratedTitle;

  /// No description provided for @referralsShareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share your code or link to start earning.'**
  String get referralsShareSubtitle;

  /// No description provided for @referralsCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Referral Code'**
  String get referralsCodeLabel;

  /// No description provided for @referralsLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Referral Link'**
  String get referralsLinkLabel;

  /// No description provided for @referralsLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied!'**
  String get referralsLinkCopied;

  /// No description provided for @referralsActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Referred User Activity'**
  String get referralsActivityTitle;

  /// No description provided for @referralsNoActivityData.
  ///
  /// In en, this message translates to:
  /// **'No activity data'**
  String get referralsNoActivityData;

  /// No description provided for @referralsActivityWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Activity will appear once the user is active.'**
  String get referralsActivityWillAppear;

  /// No description provided for @referralsWindowSection.
  ///
  /// In en, this message translates to:
  /// **'Referral Window'**
  String get referralsWindowSection;

  /// No description provided for @referralsSubscriptionsCount.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions ({count})'**
  String referralsSubscriptionsCount(int count);

  /// No description provided for @referralsAppUsageEventsCount.
  ///
  /// In en, this message translates to:
  /// **'App Usage Events ({count})'**
  String referralsAppUsageEventsCount(int count);

  /// No description provided for @referralsPromoRedemptionsCount.
  ///
  /// In en, this message translates to:
  /// **'Promo Redemptions ({count})'**
  String referralsPromoRedemptionsCount(int count);

  /// No description provided for @referralsNoActivityYet.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get referralsNoActivityYet;

  /// No description provided for @referralsItemFallback.
  ///
  /// In en, this message translates to:
  /// **'Item {index}'**
  String referralsItemFallback(int index);

  /// No description provided for @supportTicketsTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Tickets'**
  String get supportTicketsTitle;

  /// No description provided for @supportFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get supportFilterAll;

  /// No description provided for @supportFilterOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get supportFilterOpen;

  /// No description provided for @supportFilterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get supportFilterPending;

  /// No description provided for @supportFilterClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get supportFilterClosed;

  /// No description provided for @supportEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No tickets yet'**
  String get supportEmptyTitle;

  /// No description provided for @supportEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap + to open a new support ticket.'**
  String get supportEmptyMessage;

  /// No description provided for @newTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'New Ticket'**
  String get newTicketTitle;

  /// No description provided for @newTicketSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Ticket submitted successfully!'**
  String get newTicketSubmitted;

  /// No description provided for @newTicketCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get newTicketCategoryLabel;

  /// No description provided for @newTicketPriorityLabel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get newTicketPriorityLabel;

  /// No description provided for @newTicketSubjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get newTicketSubjectLabel;

  /// No description provided for @newTicketSubjectRequired.
  ///
  /// In en, this message translates to:
  /// **'Subject is required'**
  String get newTicketSubjectRequired;

  /// No description provided for @newTicketMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get newTicketMessageLabel;

  /// No description provided for @newTicketMessageRequired.
  ///
  /// In en, this message translates to:
  /// **'Message is required'**
  String get newTicketMessageRequired;

  /// No description provided for @newTicketSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Ticket'**
  String get newTicketSubmitButton;

  /// No description provided for @newTicketCategoryTechnical.
  ///
  /// In en, this message translates to:
  /// **'Technical'**
  String get newTicketCategoryTechnical;

  /// No description provided for @newTicketCategoryPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get newTicketCategoryPayment;

  /// No description provided for @newTicketPriorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get newTicketPriorityNormal;

  /// No description provided for @newTicketPriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get newTicketPriorityHigh;

  /// No description provided for @newTicketPriorityUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get newTicketPriorityUrgent;

  /// No description provided for @ticketDetailRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get ticketDetailRefreshTooltip;

  /// No description provided for @ticketDetailNoReplies.
  ///
  /// In en, this message translates to:
  /// **'No replies yet.'**
  String get ticketDetailNoReplies;

  /// No description provided for @ticketDetailTeamWillRespond.
  ///
  /// In en, this message translates to:
  /// **'Our team will respond shortly.'**
  String get ticketDetailTeamWillRespond;

  /// No description provided for @ticketDetailReplyHint.
  ///
  /// In en, this message translates to:
  /// **'Type a reply...'**
  String get ticketDetailReplyHint;

  /// No description provided for @ticketDetailClosed.
  ///
  /// In en, this message translates to:
  /// **'This ticket is closed.'**
  String get ticketDetailClosed;

  /// No description provided for @agreementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Legal Agreements'**
  String get agreementsTitle;

  /// No description provided for @agreementsAccepted.
  ///
  /// In en, this message translates to:
  /// **'Agreement accepted'**
  String get agreementsAccepted;

  /// No description provided for @agreementsAllAcceptedTitle.
  ///
  /// In en, this message translates to:
  /// **'All agreements accepted!'**
  String get agreementsAllAcceptedTitle;

  /// No description provided for @agreementsNoPending.
  ///
  /// In en, this message translates to:
  /// **'You have no pending agreements.'**
  String get agreementsNoPending;

  /// No description provided for @agreementsAcceptedStatus.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get agreementsAcceptedStatus;

  /// No description provided for @agreementsPendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending your acceptance'**
  String get agreementsPendingStatus;

  /// No description provided for @agreementsCheckboxLabel.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the terms above'**
  String get agreementsCheckboxLabel;

  /// No description provided for @agreementsAcceptButton.
  ///
  /// In en, this message translates to:
  /// **'Accept Agreement'**
  String get agreementsAcceptButton;

  /// No description provided for @knowledgeCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Knowledge Center'**
  String get knowledgeCenterTitle;

  /// No description provided for @knowledgeCenterCategoryGettingStarted.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get knowledgeCenterCategoryGettingStarted;

  /// No description provided for @knowledgeCenterCategoryPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get knowledgeCenterCategoryPayments;

  /// No description provided for @knowledgeCenterCategoryAppsTools.
  ///
  /// In en, this message translates to:
  /// **'Apps & Tools'**
  String get knowledgeCenterCategoryAppsTools;

  /// No description provided for @knowledgeCenterCategoryAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get knowledgeCenterCategoryAccount;

  /// No description provided for @knowledgeCenterEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No articles yet'**
  String get knowledgeCenterEmptyTitle;

  /// No description provided for @knowledgeCenterEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Check back later for new content.'**
  String get knowledgeCenterEmptyMessage;

  /// No description provided for @subscriptionPageStub.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions Page'**
  String get subscriptionPageStub;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
