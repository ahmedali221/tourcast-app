// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'NileTech للمرشدين السياحيين';

  @override
  String get commonOk => 'موافق';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get commonTryAgain => 'حاول مرة أخرى';

  @override
  String get commonLoading => 'جارٍ التحميل...';

  @override
  String get commonSubmit => 'إرسال';

  @override
  String get commonNext => 'التالي';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonDone => 'تم';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonActive => 'نشط';

  @override
  String get commonCopied => 'تم النسخ!';

  @override
  String get commonContactSupport => 'تواصل مع الدعم';

  @override
  String get commonPayoutsUnavailable =>
      'تتوفر عمليات السحب بمجرد التحقق من حسابك.';

  @override
  String get commonPleaseContactSupport => 'يرجى التواصل مع الدعم.';

  @override
  String get commonLogout => 'تسجيل الخروج';

  @override
  String get commonLogoutConfirm => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get commonSomethingWentWrong => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageSubtitle => 'اختر لغتك المفضلة';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageChinese => 'الصينية';

  @override
  String get languageRussian => 'الروسية';

  @override
  String get languageGerman => 'الألمانية';

  @override
  String get languageFrench => 'الفرنسية';

  @override
  String get languageTurkish => 'التركية';

  @override
  String get languageItalian => 'الإيطالية';

  @override
  String get languageSpanish => 'الإسبانية';

  @override
  String get languageJapanese => 'اليابانية';

  @override
  String get languageKorean => 'الكورية';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navMarketplace => 'المتجر';

  @override
  String get navWallet => 'المحفظة';

  @override
  String get navSupport => 'الدعم';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get validatorEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get validatorEmailInvalid => 'أدخل بريدًا إلكترونيًا صالحًا';

  @override
  String get validatorPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String get validatorPasswordTooShort => 'يجب ألا تقل كلمة المرور عن 8 أحرف';

  @override
  String get validatorConfirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get validatorPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String validatorFieldRequired(String field) {
    return '$field مطلوب';
  }

  @override
  String get validatorDefaultFieldName => 'هذا الحقل';

  @override
  String get validatorAmountRequired => 'المبلغ مطلوب';

  @override
  String get validatorAmountInvalid => 'أدخل مبلغًا صالحًا';

  @override
  String validatorMinimumAmount(String min) {
    return 'الحد الأدنى للمبلغ هو \$$min';
  }

  @override
  String get authTagline => 'دليلك. مشروعك.';

  @override
  String get loginWelcomeBack => 'مرحبًا بعودتك';

  @override
  String get loginSubtitle => 'سجّل الدخول إلى حساب المرشد الخاص بك';

  @override
  String get loginEmailLabel => 'البريد الإلكتروني';

  @override
  String get loginPasswordLabel => 'كلمة المرور';

  @override
  String get loginForgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginNoAccount => 'ليس لديك حساب؟';

  @override
  String get loginRegisterLink => 'إنشاء حساب';

  @override
  String get registerHeading => 'إنشاء حساب';

  @override
  String get registerSubtitle => 'انضم إلى NileTech كمرشد سياحي';

  @override
  String get registerFullNameLabel => 'الاسم الكامل';

  @override
  String get registerEmailLabel => 'البريد الإلكتروني';

  @override
  String get registerPasswordLabel => 'كلمة المرور';

  @override
  String get registerConfirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get registerReferralCodeLabel => 'رمز الإحالة (اختياري)';

  @override
  String get registerButton => 'إنشاء حساب';

  @override
  String get registerAlreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get registerLoginLink => 'تسجيل الدخول';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgotPasswordHeading => 'إعادة تعيين كلمة المرور';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة التعيين.';

  @override
  String get forgotPasswordEmailLabel => 'البريد الإلكتروني';

  @override
  String get forgotPasswordSendButton => 'إرسال رابط إعادة التعيين';

  @override
  String get forgotPasswordSuccessHeading => 'تحقق من بريدك الوارد';

  @override
  String get forgotPasswordSuccessBody =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.';

  @override
  String get verifyEmailResentSnackbar => 'تم إعادة إرسال بريد التحقق';

  @override
  String get verifyEmailHeading => 'تحقق من بريدك الإلكتروني';

  @override
  String get verifyEmailBody =>
      'أرسلنا رابط تحقق إلى بريدك الإلكتروني. يرجى التحقق من بريدك الوارد والنقر على الرابط لتفعيل حسابك.';

  @override
  String get verifyEmailContinueButton => 'لقد أكدت، متابعة';

  @override
  String get verifyEmailResendButton => 'إعادة إرسال البريد';

  @override
  String get homeVerificationRequiredTitle => 'التحقق مطلوب';

  @override
  String get homeAccountUnderReviewTitle => 'الحساب قيد المراجعة';

  @override
  String get homeApplicationRejectedTitle => 'تم رفض الطلب';

  @override
  String get homeVerificationRequiredMessage =>
      'يجب عليك تقديم مستندات التحقق قبل أن تتمكن من استخدام التطبيق.';

  @override
  String get homePendingReviewMessage =>
      'يقوم فريقنا بمراجعة طلب انضمامك كمرشد. سيتم إشعارك فور الموافقة.';

  @override
  String get homeRejectedMessage =>
      'لم تتم الموافقة على طلبك. يرجى مراجعة الملاحظات أدناه والتواصل مع الدعم.';

  @override
  String get homeSubmitVerificationCta => 'تقديم التحقق';

  @override
  String get homeReviewNotesLabel => 'ملاحظات المراجعة';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'طاب يومك';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting، $firstName 👋';
  }

  @override
  String get homeYourBalance => 'رصيدك';

  @override
  String get homeRequestPayout => 'طلب سحب';

  @override
  String get homeCommissions => 'العمولات';

  @override
  String get homeReferrals => 'الإحالات';

  @override
  String get homeAnnouncements => 'الإعلانات';

  @override
  String get homeMyPromoCodes => 'رموز الخصم الخاصة بي';

  @override
  String get homeNoPromoCodes => 'لا توجد رموز خصم بعد';

  @override
  String get homePendingBannerMessage =>
      'التحقق من حسابك قيد المراجعة. يمكنك تصفح التطبيق، لكن لا يمكنك إنشاء رموز خصم أو إحالات أو طلب سحب حتى تتم الموافقة.';

  @override
  String get notificationsTrayTitle => 'الإشعارات';

  @override
  String get notificationsMarkAllRead => 'تعليم الكل كمقروء';

  @override
  String get notificationsEmptyTitle => 'لا توجد إشعارات بعد';

  @override
  String get notificationsEmptyMessage => 'لقد اطلعت على كل شيء!';

  @override
  String get notificationsNewSection => 'جديد';

  @override
  String get notificationsEarlierSection => 'سابقًا';

  @override
  String get profileTitle => 'ملفي الشخصي';

  @override
  String get profileEditUnavailable =>
      'يتوفر تعديل الملف الشخصي بمجرد التحقق من حسابك.';

  @override
  String get profileCompleteness => 'اكتمال الملف الشخصي';

  @override
  String get profileCountry => 'الدولة';

  @override
  String get profileCity => 'المدينة';

  @override
  String get profileYearsExperienceLabel => 'سنوات الخبرة';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سنوات',
      one: '$count سنة',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'اللغات';

  @override
  String get profileSpecializations => 'التخصصات';

  @override
  String get profileBio => 'نبذة';

  @override
  String get profileNoBio => 'لم تتم إضافة نبذة بعد.';

  @override
  String get profileDeleteAccount => 'حذف الحساب';

  @override
  String get profileDeleteConfirm =>
      'هذا الإجراء نهائي ولا يمكن التراجع عنه. هل أنت متأكد؟';

  @override
  String get profileWallet => 'المحفظة';

  @override
  String get profileViewAll => 'عرض الكل →';

  @override
  String get profileAvailableBalance => 'الرصيد المتاح';

  @override
  String get profilePayoutAccount => 'حساب السحب';

  @override
  String get profileManage => 'إدارة →';

  @override
  String get profileSetupPayoutAccount => 'إعداد حساب السحب';

  @override
  String get profileUpdatedSuccess => 'تم تحديث الملف الشخصي بنجاح!';

  @override
  String get editProfileTitle => 'تعديل الملف الشخصي';

  @override
  String get editProfileChangePhoto => 'تغيير الصورة';

  @override
  String get editProfileSelectCountry => 'اختر الدولة';

  @override
  String get editProfileSaveChanges => 'حفظ التغييرات';

  @override
  String get editProfileSelectCountryTitle => 'اختيار الدولة';

  @override
  String get editProfileSearchCountryHint => 'ابحث عن دولة...';

  @override
  String editProfileSelectItemTitle(String title) {
    return 'اختر $title';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'تم ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'بحث...';

  @override
  String editProfileApplyCount(int count) {
    return 'تطبيق ($count محدد)';
  }

  @override
  String get editProfileAddChip => '+ إضافة';

  @override
  String get verificationTitle => 'التحقق من الهوية';

  @override
  String get verificationDocumentDetails => 'تفاصيل المستند';

  @override
  String get verificationNationalIdLabel => 'رقم الهوية الوطنية';

  @override
  String get verificationLicenseLabel => 'رقم رخصة المرشد السياحي';

  @override
  String get verificationUploadDocuments => 'رفع المستندات';

  @override
  String get verificationUploadCaption =>
      'يرجى رفع نسخ واضحة وقابلة للقراءة من مستنداتك.';

  @override
  String get verificationIdFrontTitle => 'الهوية الوطنية — الوجه الأمامي';

  @override
  String get verificationIdFrontSubtitle =>
      'الوجه الأمامي لبطاقة هويتك الوطنية';

  @override
  String get verificationFormatMax2mb => 'JPEG أو PNG • بحد أقصى 2 ميجابايت';

  @override
  String get verificationIdBackTitle => 'الهوية الوطنية — الوجه الخلفي';

  @override
  String get verificationIdBackSubtitle => 'الوجه الخلفي لبطاقة هويتك الوطنية';

  @override
  String get verificationLicenseTitle => 'رخصة المرشد السياحي';

  @override
  String get verificationLicenseSubtitle =>
      'مستند الرخصة الرسمية للمرشد السياحي';

  @override
  String get verificationFormatMax5mb => 'JPEG أو PNG • بحد أقصى 5 ميجابايت';

  @override
  String get verificationSubmitButton => 'إرسال للتحقق';

  @override
  String get verificationUploaded => 'تم الرفع';

  @override
  String get verificationTapToUpload => 'اضغط للرفع';

  @override
  String get verificationRejectedBanner =>
      'تم رفض مستنداتك. يرجى إعادة الإرسال.';

  @override
  String get verificationPendingBanner =>
      'مستنداتك قيد المراجعة. سنقوم بإشعارك.';

  @override
  String get verificationSubmittedDocuments => 'المستندات المُرسلة';

  @override
  String get verificationVerifiedTitle => 'تم التحقق من الهوية';

  @override
  String get verificationVerifiedSubtitle => 'تم التحقق من هويتك بنجاح.';

  @override
  String get verificationSuccessHeading => 'تم إرسال المستندات';

  @override
  String get verificationSuccessBody =>
      'تم إرسال مستندات التحقق الخاصة بك بنجاح. سيقوم فريقنا بمراجعتها وإشعارك بالنتيجة.';

  @override
  String get verificationSuccessInfoBanner =>
      'تستغرق المراجعة عادةً من 1 إلى 3 أيام عمل.';

  @override
  String get verificationGoHome => 'الذهاب إلى الرئيسية';

  @override
  String get marketplaceTitle => 'المتجر';

  @override
  String get marketplaceSearchHint => 'ابحث عن تطبيقات...';

  @override
  String get marketplaceEmptyTitle => 'لا توجد تطبيقات متاحة';

  @override
  String get marketplaceEmptyMessage =>
      'تحقق لاحقًا للاطلاع على تطبيقات جديدة.';

  @override
  String get marketplaceViewDetails => 'عرض التفاصيل →';

  @override
  String get appDetailsCouldNotOpenStore => 'تعذّر فتح رابط المتجر';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => 'نبذة';

  @override
  String get appDetailsAvailablePlans => 'الباقات المتاحة';

  @override
  String get appDetailsPromoUnavailable =>
      'تتوفر رموز الخصم بمجرد التحقق من حسابك.';

  @override
  String get appDetailsGenerateButton => '+ إنشاء';

  @override
  String get appDetailsFailedLoadPromoCodes => 'فشل تحميل رموز الخصم.';

  @override
  String get appDetailsGenerateHint =>
      'اضغط على \"+ إنشاء\" لإنشاء أول رمز خاص بك.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'فشل إنشاء رمز الخصم. يرجى المحاولة مرة أخرى.';

  @override
  String get appDetailsCopyTooltip => 'نسخ';

  @override
  String get appDetailsFailedLoadUsage => 'فشل تحميل بيانات الاستخدام.';

  @override
  String get appDetailsNoUsage => 'لا يوجد استخدام بعد';

  @override
  String get appDetailsCreatePromoTitle => 'إنشاء رمز خصم';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'أدخل اسمًا مخصصًا لرمز الخصم، أو اتركه فارغًا لإنشائه تلقائيًا.';

  @override
  String get appDetailsPromoNameLabel => 'اسم رمز الخصم (اختياري)';

  @override
  String get appDetailsPromoNameHint =>
      'مثال: AHMED20 — اتركه فارغًا للإنشاء التلقائي';

  @override
  String get appDetailsGenerate => 'إنشاء';

  @override
  String get appDetailsPreview => 'معاينة';

  @override
  String get appDetailsFree => 'مجاني';

  @override
  String get walletTitle => 'المحفظة';

  @override
  String get walletTransactionHistory => 'سجل المعاملات';

  @override
  String get walletNoTransactions => 'لا توجد معاملات بعد';

  @override
  String get walletNoTransactionsMessage => 'سيظهر سجل معاملاتك هنا.';

  @override
  String get walletPayoutRequestsTitle => 'طلبات السحب';

  @override
  String get walletPayoutRequestsSubtitle => 'عرض عمليات السحب وإدارتها';

  @override
  String get payoutProfileSaved => 'تم حفظ ملف السحب!';

  @override
  String get payoutRequestSubmitted => 'تم إرسال طلب السحب';

  @override
  String get payoutMethodTitle => 'طريقة السحب';

  @override
  String get payoutPaymentDetailsTitle => 'تفاصيل الدفع';

  @override
  String get payoutManageAccount => 'إدارة حساب الدفع';

  @override
  String get payoutHistorySection => 'السجل';

  @override
  String get payoutNoRequests => 'لا توجد طلبات سحب بعد';

  @override
  String get payoutNoRequestsMessage => 'ستظهر طلبات السحب الخاصة بك هنا.';

  @override
  String get payoutChooseMethod => 'اختر الطريقة التي تريد بها استلام أموالك.';

  @override
  String get payoutNoMethodsAvailable => 'لا توجد طرق سحب متاحة';

  @override
  String get payoutInfoBanner =>
      'يتم حفظ هذه المعلومات في ملف السحب الخاص بك واستخدامها في جميع عمليات السحب المستقبلية.';

  @override
  String get payoutSaveContinue => 'حفظ ومتابعة';

  @override
  String payoutAvailableAmount(String amount) {
    return 'المتاح: $amount';
  }

  @override
  String get payoutChange => 'تغيير';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => 'الحد الأدنى لمبلغ السحب هو 10\$';

  @override
  String get payoutSubmitRequest => 'إرسال الطلب';

  @override
  String get payoutAmountLabel => 'المبلغ (دولار أمريكي)';

  @override
  String get paymentMethodsSaved => 'تم حفظ حساب الدفع!';

  @override
  String get paymentMethodsTitle => 'طرق الدفع';

  @override
  String get paymentMethodsNoneAvailable => 'لا توجد طرق دفع متاحة';

  @override
  String get paymentMethodsChoose => 'اختر طريقة دفع';

  @override
  String get paymentMethodsAll => 'جميع الطرق';

  @override
  String get paymentMethodsActiveBadge => 'نشط';

  @override
  String get paymentMethodsSetUp => 'إعداد';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return 'حدّث بيانات الدفع المحفوظة لـ $methodName.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'سيصبح هذا حساب السحب النشط الخاص بك.';

  @override
  String get paymentMethodsSetActiveButton => 'تعيين كحساب نشط';

  @override
  String get commissionsTitle => 'العمولات';

  @override
  String get commissionsTotalEarned => 'إجمالي العمولات المكتسبة';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count معاملات',
      one: '$count معاملة',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => 'سجل العمولات';

  @override
  String get commissionsEmptyTitle => 'لا توجد عمولات بعد';

  @override
  String get commissionsEmptyMessage => 'ستظهر عمولاتك المكتسبة هنا.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'رمز الخصم: $code';
  }

  @override
  String get commissionsDirectSale => 'بيع مباشر';

  @override
  String get referralsTitle => 'الإحالات';

  @override
  String get referralsTotal => 'إجمالي الإحالات';

  @override
  String get referralsTotalEarned => 'إجمالي الأرباح';

  @override
  String get referralsGenerateNew => 'إنشاء رمز إحالة جديد';

  @override
  String get referralsUnavailable =>
      'تتوفر روابط الإحالة بمجرد التحقق من حسابك.';

  @override
  String get referralsCodesSection => 'رموز الإحالة';

  @override
  String get referralsEmptyTitle => 'لا توجد إحالات بعد';

  @override
  String get referralsEmptyMessage => 'أنشئ رمزًا وشاركه لتبدأ بالربح!';

  @override
  String get referralsCodeCopied => 'تم نسخ الرمز!';

  @override
  String referralsUsedBy(String user) {
    return 'استخدمه $user';
  }

  @override
  String get referralsNotUsedYet => 'لم يُستخدم بعد';

  @override
  String referralsRegisteredOn(String date) {
    return 'تم التسجيل في $date';
  }

  @override
  String get referralsLinkGeneratedTitle => 'تم إنشاء رابط الإحالة';

  @override
  String get referralsShareSubtitle => 'شارك رمزك أو رابطك لتبدأ بالربح.';

  @override
  String get referralsCodeLabel => 'رمز الإحالة';

  @override
  String get referralsLinkLabel => 'رابط الإحالة';

  @override
  String get referralsLinkCopied => 'تم نسخ الرابط!';

  @override
  String get referralsActivityTitle => 'نشاط المستخدم المُحال';

  @override
  String get referralsNoActivityData => 'لا توجد بيانات نشاط';

  @override
  String get referralsActivityWillAppear =>
      'سيظهر النشاط بمجرد أن يصبح المستخدم نشطًا.';

  @override
  String get referralsWindowSection => 'فترة الإحالة';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'الاشتراكات ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'أحداث استخدام التطبيق ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'استخدامات رموز الخصم ($count)';
  }

  @override
  String get referralsNoActivityYet => 'لا يوجد نشاط بعد';

  @override
  String referralsItemFallback(int index) {
    return 'العنصر $index';
  }

  @override
  String get supportTicketsTitle => 'تذاكر الدعم';

  @override
  String get supportFilterAll => 'الكل';

  @override
  String get supportFilterOpen => 'مفتوحة';

  @override
  String get supportFilterPending => 'قيد الانتظار';

  @override
  String get supportFilterClosed => 'مغلقة';

  @override
  String get supportEmptyTitle => 'لا توجد تذاكر بعد';

  @override
  String get supportEmptyMessage => 'اضغط على + لفتح تذكرة دعم جديدة.';

  @override
  String get newTicketTitle => 'تذكرة جديدة';

  @override
  String get newTicketSubmitted => 'تم إرسال التذكرة بنجاح!';

  @override
  String get newTicketCategoryLabel => 'الفئة';

  @override
  String get newTicketPriorityLabel => 'الأولوية';

  @override
  String get newTicketSubjectLabel => 'الموضوع';

  @override
  String get newTicketSubjectRequired => 'الموضوع مطلوب';

  @override
  String get newTicketMessageLabel => 'الرسالة';

  @override
  String get newTicketMessageRequired => 'الرسالة مطلوبة';

  @override
  String get newTicketSubmitButton => 'إرسال التذكرة';

  @override
  String get newTicketCategoryTechnical => 'تقني';

  @override
  String get newTicketCategoryPayment => 'الدفع';

  @override
  String get newTicketPriorityNormal => 'عادية';

  @override
  String get newTicketPriorityHigh => 'عالية';

  @override
  String get newTicketPriorityUrgent => 'عاجلة';

  @override
  String get ticketDetailRefreshTooltip => 'تحديث';

  @override
  String get ticketDetailNoReplies => 'لا توجد ردود بعد.';

  @override
  String get ticketDetailTeamWillRespond => 'سيرد فريقنا قريبًا.';

  @override
  String get ticketDetailReplyHint => 'اكتب ردًا...';

  @override
  String get ticketDetailClosed => 'هذه التذكرة مغلقة.';

  @override
  String get agreementsTitle => 'الاتفاقيات القانونية';

  @override
  String get agreementsAccepted => 'تم قبول الاتفاقية';

  @override
  String get agreementsAllAcceptedTitle => 'تم قبول جميع الاتفاقيات!';

  @override
  String get agreementsNoPending => 'ليس لديك اتفاقيات معلّقة.';

  @override
  String get agreementsAcceptedStatus => 'مقبولة';

  @override
  String get agreementsPendingStatus => 'بانتظار موافقتك';

  @override
  String get agreementsCheckboxLabel => 'لقد قرأت الشروط أعلاه وأوافق عليها';

  @override
  String get agreementsAcceptButton => 'قبول الاتفاقية';

  @override
  String get knowledgeCenterTitle => 'مركز المعرفة';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'البدء';

  @override
  String get knowledgeCenterCategoryPayments => 'المدفوعات';

  @override
  String get knowledgeCenterCategoryAppsTools => 'التطبيقات والأدوات';

  @override
  String get knowledgeCenterCategoryAccount => 'الحساب';

  @override
  String get knowledgeCenterEmptyTitle => 'لا توجد مقالات بعد';

  @override
  String get knowledgeCenterEmptyMessage =>
      'تحقق لاحقًا للاطلاع على محتوى جديد.';

  @override
  String get subscriptionPageStub => 'صفحة الاشتراكات';
}
