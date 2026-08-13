// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'NileTech Tur Rehberi';

  @override
  String get commonOk => 'Tamam';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonRetry => 'Yeniden Dene';

  @override
  String get commonTryAgain => 'Tekrar Dene';

  @override
  String get commonLoading => 'Yükleniyor...';

  @override
  String get commonSubmit => 'Gönder';

  @override
  String get commonNext => 'İleri';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonDone => 'Bitti';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get commonActive => 'Aktif';

  @override
  String get commonCopied => 'Kopyalandı!';

  @override
  String get commonContactSupport => 'Destek ile İletişime Geç';

  @override
  String get commonPayoutsUnavailable =>
      'Ödemeler, hesabınız doğrulandıktan sonra kullanılabilir olacaktır.';

  @override
  String get commonPleaseContactSupport =>
      'Lütfen destek ekibiyle iletişime geçin.';

  @override
  String get commonLogout => 'Çıkış Yap';

  @override
  String get commonLogoutConfirm => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get commonSomethingWentWrong =>
      'Bir şeyler ters gitti. Lütfen tekrar deneyin.';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSubtitle => 'Tercih ettiğiniz dili seçin';

  @override
  String get languageEnglish => 'İngilizce';

  @override
  String get languageArabic => 'Arapça';

  @override
  String get languageChinese => 'Çince';

  @override
  String get languageRussian => 'Rusça';

  @override
  String get languageGerman => 'Almanca';

  @override
  String get languageFrench => 'Fransızca';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageItalian => 'İtalyanca';

  @override
  String get languageSpanish => 'İspanyolca';

  @override
  String get languageJapanese => 'Japonca';

  @override
  String get languageKorean => 'Korece';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navMarketplace => 'Mağaza';

  @override
  String get navWallet => 'Cüzdan';

  @override
  String get navSupport => 'Destek';

  @override
  String get navProfile => 'Profil';

  @override
  String get validatorEmailRequired => 'E-posta adresi gereklidir';

  @override
  String get validatorEmailInvalid => 'Geçerli bir e-posta adresi girin';

  @override
  String get validatorPasswordRequired => 'Şifre gereklidir';

  @override
  String get validatorPasswordTooShort => 'Şifre en az 8 karakter olmalıdır';

  @override
  String get validatorConfirmPasswordRequired => 'Lütfen şifrenizi onaylayın';

  @override
  String get validatorPasswordMismatch => 'Şifreler eşleşmiyor';

  @override
  String validatorFieldRequired(String field) {
    return '$field gereklidir';
  }

  @override
  String get validatorDefaultFieldName => 'Bu alan';

  @override
  String get validatorAmountRequired => 'Tutar gereklidir';

  @override
  String get validatorAmountInvalid => 'Geçerli bir tutar girin';

  @override
  String validatorMinimumAmount(String min) {
    return 'Minimum tutar \$$min';
  }

  @override
  String get authTagline => 'Rehberiniz. İşletmeniz.';

  @override
  String get loginWelcomeBack => 'Tekrar Hoş Geldiniz';

  @override
  String get loginSubtitle => 'Rehber hesabınıza giriş yapın';

  @override
  String get loginEmailLabel => 'E-posta Adresi';

  @override
  String get loginPasswordLabel => 'Şifre';

  @override
  String get loginForgotPassword => 'Şifrenizi mi unuttunuz?';

  @override
  String get loginButton => 'Giriş Yap';

  @override
  String get loginNoAccount => 'Hesabınız yok mu?';

  @override
  String get loginRegisterLink => 'Kayıt Ol';

  @override
  String get registerHeading => 'Hesap Oluştur';

  @override
  String get registerSubtitle => 'Tur Rehberi olarak NileTech\'e katılın';

  @override
  String get registerFullNameLabel => 'Ad Soyad';

  @override
  String get registerEmailLabel => 'E-posta';

  @override
  String get registerPasswordLabel => 'Şifre';

  @override
  String get registerConfirmPasswordLabel => 'Şifreyi Onayla';

  @override
  String get registerReferralCodeLabel => 'Referans Kodu (İsteğe Bağlı)';

  @override
  String get registerButton => 'Hesap Oluştur';

  @override
  String get registerAlreadyHaveAccount => 'Zaten bir hesabınız var mı?';

  @override
  String get registerLoginLink => 'Giriş Yap';

  @override
  String get forgotPasswordTitle => 'Şifremi Unuttum';

  @override
  String get forgotPasswordHeading => 'Şifrenizi sıfırlayın';

  @override
  String get forgotPasswordSubtitle =>
      'E-postanızı girin, size bir sıfırlama bağlantısı gönderelim.';

  @override
  String get forgotPasswordEmailLabel => 'E-posta Adresi';

  @override
  String get forgotPasswordSendButton => 'Sıfırlama Bağlantısı Gönder';

  @override
  String get forgotPasswordSuccessHeading => 'Gelen kutunuzu kontrol edin';

  @override
  String get forgotPasswordSuccessBody =>
      'E-posta adresinize bir şifre sıfırlama bağlantısı gönderildi.';

  @override
  String get verifyEmailResentSnackbar =>
      'Doğrulama e-postası yeniden gönderildi';

  @override
  String get verifyEmailHeading => 'E-postanızı Doğrulayın';

  @override
  String get verifyEmailBody =>
      'E-posta adresinize bir doğrulama bağlantısı gönderdik. Lütfen gelen kutunuzu kontrol edin ve hesabınızı etkinleştirmek için bağlantıya tıklayın.';

  @override
  String get verifyEmailContinueButton => 'Doğruladım, Devam Et';

  @override
  String get verifyEmailResendButton => 'E-postayı Yeniden Gönder';

  @override
  String get homeVerificationRequiredTitle => 'Doğrulama Gerekli';

  @override
  String get homeAccountUnderReviewTitle => 'Hesap İnceleniyor';

  @override
  String get homeApplicationRejectedTitle => 'Başvuru Reddedildi';

  @override
  String get homeVerificationRequiredMessage =>
      'Uygulamaya erişebilmek için önce doğrulama belgelerinizi göndermeniz gerekir.';

  @override
  String get homePendingReviewMessage =>
      'Rehberlik başvurunuz ekibimiz tarafından inceleniyor. Onaylandığında bilgilendirileceksiniz.';

  @override
  String get homeRejectedMessage =>
      'Başvurunuz onaylanmadı. Lütfen aşağıdaki notları inceleyin ve destek ekibiyle iletişime geçin.';

  @override
  String get homeSubmitVerificationCta => 'Doğrulamayı Gönder';

  @override
  String get homeReviewNotesLabel => 'İnceleme Notları';

  @override
  String get greetingMorning => 'Günaydın';

  @override
  String get greetingAfternoon => 'İyi günler';

  @override
  String get greetingEvening => 'İyi akşamlar';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'Bakiyeniz';

  @override
  String get homeRequestPayout => 'Ödeme Talep Et';

  @override
  String get homeCommissions => 'Komisyonlar';

  @override
  String get homeReferrals => 'Referanslar';

  @override
  String get homeAnnouncements => 'Duyurular';

  @override
  String get homeMyPromoCodes => 'Promosyon Kodlarım';

  @override
  String get homeNoPromoCodes => 'Henüz promosyon kodu yok';

  @override
  String get homePendingBannerMessage =>
      'Doğrulamanız inceleniyor. Uygulamaya göz atabilirsiniz ancak onaylanana kadar promosyon kodu, referans oluşturamaz veya ödeme talep edemezsiniz.';

  @override
  String get notificationsTrayTitle => 'Bildirimler';

  @override
  String get notificationsMarkAllRead => 'Tümünü okundu işaretle';

  @override
  String get notificationsEmptyTitle => 'Henüz bildirim yok';

  @override
  String get notificationsEmptyMessage => 'Her şey güncel!';

  @override
  String get notificationsNewSection => 'Yeni';

  @override
  String get notificationsEarlierSection => 'Daha Önce';

  @override
  String get profileTitle => 'Profilim';

  @override
  String get profileEditUnavailable =>
      'Profil düzenleme, hesabınız doğrulandıktan sonra kullanılabilir olacaktır.';

  @override
  String get profileCompleteness => 'Profil Tamamlanma Oranı';

  @override
  String get profileCountry => 'Ülke';

  @override
  String get profileCity => 'Şehir';

  @override
  String get profileYearsExperienceLabel => 'Deneyim Yılı';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yıl',
      one: '$count yıl',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'Diller';

  @override
  String get profileSpecializations => 'Uzmanlık Alanları';

  @override
  String get profileBio => 'Biyografi';

  @override
  String get profileNoBio => 'Henüz biyografi eklenmedi.';

  @override
  String get profileDeleteAccount => 'Hesabı Sil';

  @override
  String get profileDeleteConfirm =>
      'Bu işlem kalıcıdır ve geri alınamaz. Emin misiniz?';

  @override
  String get profileWallet => 'Cüzdan';

  @override
  String get profileViewAll => 'Tümünü görüntüle →';

  @override
  String get profileAvailableBalance => 'Kullanılabilir Bakiye';

  @override
  String get profilePayoutAccount => 'Ödeme Hesabı';

  @override
  String get profileManage => 'Yönet →';

  @override
  String get profileSetupPayoutAccount => 'Ödeme hesabı oluştur';

  @override
  String get profileUpdatedSuccess => 'Profil başarıyla güncellendi!';

  @override
  String get editProfileTitle => 'Profili Düzenle';

  @override
  String get editProfileChangePhoto => 'Fotoğrafı Değiştir';

  @override
  String get editProfileSelectCountry => 'Ülke seçin';

  @override
  String get editProfileSaveChanges => 'Değişiklikleri Kaydet';

  @override
  String get editProfileSelectCountryTitle => 'Ülke Seçin';

  @override
  String get editProfileSearchCountryHint => 'Ülke ara...';

  @override
  String editProfileSelectItemTitle(String title) {
    return '$title Seçin';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'Bitti ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'Ara...';

  @override
  String editProfileApplyCount(int count) {
    return 'Uygula ($count seçildi)';
  }

  @override
  String get editProfileAddChip => '+ Ekle';

  @override
  String get verificationTitle => 'Kimlik Doğrulama';

  @override
  String get verificationDocumentDetails => 'Belge Detayları';

  @override
  String get verificationNationalIdLabel => 'Ulusal Kimlik Numarası';

  @override
  String get verificationLicenseLabel => 'Rehber Lisans Numarası';

  @override
  String get verificationUploadDocuments => 'Belgeleri Yükle';

  @override
  String get verificationUploadCaption =>
      'Lütfen belgelerinizin net ve okunaklı kopyalarını yükleyin.';

  @override
  String get verificationIdFrontTitle => 'Ulusal Kimlik — Ön Yüz';

  @override
  String get verificationIdFrontSubtitle => 'Kimlik kartınızın ön yüzü';

  @override
  String get verificationFormatMax2mb => 'JPEG veya PNG • Maks. 2 MB';

  @override
  String get verificationIdBackTitle => 'Ulusal Kimlik — Arka Yüz';

  @override
  String get verificationIdBackSubtitle => 'Kimlik kartınızın arka yüzü';

  @override
  String get verificationLicenseTitle => 'Rehber Lisansı';

  @override
  String get verificationLicenseSubtitle => 'Resmi tur rehberi lisans belgesi';

  @override
  String get verificationFormatMax5mb => 'JPEG veya PNG • Maks. 5 MB';

  @override
  String get verificationSubmitButton => 'Doğrulama İçin Gönder';

  @override
  String get verificationUploaded => 'Yüklendi';

  @override
  String get verificationTapToUpload => 'Yüklemek için dokunun';

  @override
  String get verificationRejectedBanner =>
      'Belgeleriniz reddedildi. Lütfen yeniden gönderin.';

  @override
  String get verificationPendingBanner =>
      'Belgeleriniz inceleniyor. Sizi bilgilendireceğiz.';

  @override
  String get verificationSubmittedDocuments => 'Gönderilen Belgeler';

  @override
  String get verificationVerifiedTitle => 'Kimlik Doğrulandı';

  @override
  String get verificationVerifiedSubtitle => 'Kimliğiniz başarıyla doğrulandı.';

  @override
  String get verificationSuccessHeading => 'Belgeler Gönderildi';

  @override
  String get verificationSuccessBody =>
      'Doğrulama belgeleriniz başarıyla gönderildi. Ekibimiz belgelerinizi inceleyecek ve sonucu size bildirecektir.';

  @override
  String get verificationSuccessInfoBanner =>
      'İnceleme genellikle 1–3 iş günü sürer.';

  @override
  String get verificationGoHome => 'Ana Sayfaya Git';

  @override
  String get marketplaceTitle => 'Mağaza';

  @override
  String get marketplaceSearchHint => 'Uygulama ara...';

  @override
  String get marketplaceEmptyTitle => 'Kullanılabilir uygulama yok';

  @override
  String get marketplaceEmptyMessage =>
      'Yeni uygulamalar için daha sonra tekrar kontrol edin.';

  @override
  String get marketplaceViewDetails => 'Detayları Görüntüle →';

  @override
  String get appDetailsCouldNotOpenStore => 'Mağaza bağlantısı açılamadı';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => 'Hakkında';

  @override
  String get appDetailsAvailablePlans => 'Kullanılabilir Planlar';

  @override
  String get appDetailsPromoUnavailable =>
      'Promosyon kodları, hesabınız doğrulandıktan sonra kullanılabilir olacaktır.';

  @override
  String get appDetailsGenerateButton => '+ Oluştur';

  @override
  String get appDetailsFailedLoadPromoCodes => 'Promosyon kodları yüklenemedi.';

  @override
  String get appDetailsGenerateHint =>
      'İlk kodunuzu oluşturmak için \"+ Oluştur\" öğesine dokunun.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'Promosyon kodu oluşturulamadı. Lütfen tekrar deneyin.';

  @override
  String get appDetailsCopyTooltip => 'Kopyala';

  @override
  String get appDetailsFailedLoadUsage => 'Kullanım verileri yüklenemedi.';

  @override
  String get appDetailsNoUsage => 'Henüz kullanım yok';

  @override
  String get appDetailsCreatePromoTitle => 'Promosyon Kodu Oluştur';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'Promosyon kodunuz için özel bir isim girin veya otomatik oluşturmak için boş bırakın.';

  @override
  String get appDetailsPromoNameLabel => 'Promosyon Kodu Adı (isteğe bağlı)';

  @override
  String get appDetailsPromoNameHint =>
      'örn. AHMED20 — otomatik oluşturmak için boş bırakın';

  @override
  String get appDetailsGenerate => 'Oluştur';

  @override
  String get appDetailsPreview => 'Önizleme';

  @override
  String get appDetailsFree => 'Ücretsiz';

  @override
  String get walletTitle => 'Cüzdan';

  @override
  String get walletTransactionHistory => 'İşlem Geçmişi';

  @override
  String get walletNoTransactions => 'Henüz işlem yok';

  @override
  String get walletNoTransactionsMessage =>
      'İşlem geçmişiniz burada görünecek.';

  @override
  String get walletPayoutRequestsTitle => 'Ödeme Talepleri';

  @override
  String get walletPayoutRequestsSubtitle =>
      'Ödemelerinizi görüntüleyin ve yönetin';

  @override
  String get payoutProfileSaved => 'Ödeme profili kaydedildi!';

  @override
  String get payoutRequestSubmitted => 'Ödeme talebi gönderildi';

  @override
  String get payoutMethodTitle => 'Ödeme Yöntemi';

  @override
  String get payoutPaymentDetailsTitle => 'Ödeme Bilgileri';

  @override
  String get payoutManageAccount => 'Ödeme Hesabını Yönet';

  @override
  String get payoutHistorySection => 'Geçmiş';

  @override
  String get payoutNoRequests => 'Henüz ödeme talebi yok';

  @override
  String get payoutNoRequestsMessage => 'Ödeme talepleriniz burada görünecek.';

  @override
  String get payoutChooseMethod => 'Ödemenizi nasıl almak istediğinizi seçin.';

  @override
  String get payoutNoMethodsAvailable => 'Kullanılabilir ödeme yöntemi yok';

  @override
  String get payoutInfoBanner =>
      'Bu bilgi ödeme profilinize kaydedilir ve tüm gelecekteki para çekme işlemlerinde kullanılır.';

  @override
  String get payoutSaveContinue => 'Kaydet ve Devam Et';

  @override
  String payoutAvailableAmount(String amount) {
    return 'Kullanılabilir: $amount';
  }

  @override
  String get payoutChange => 'Değiştir';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => 'Minimum ödeme tutarı \$10';

  @override
  String get payoutSubmitRequest => 'Talebi Gönder';

  @override
  String get payoutAmountLabel => 'Tutar (USD)';

  @override
  String get paymentMethodsSaved => 'Ödeme hesabı kaydedildi!';

  @override
  String get paymentMethodsTitle => 'Ödeme Yöntemleri';

  @override
  String get paymentMethodsNoneAvailable => 'Kullanılabilir ödeme yöntemi yok';

  @override
  String get paymentMethodsChoose => 'Bir ödeme yöntemi seçin';

  @override
  String get paymentMethodsAll => 'Tüm Yöntemler';

  @override
  String get paymentMethodsActiveBadge => 'AKTİF';

  @override
  String get paymentMethodsSetUp => 'Kur';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return '$methodName için kayıtlı ödeme bilgilerinizi güncelleyin.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'Bu, aktif ödeme hesabınız olacaktır.';

  @override
  String get paymentMethodsSetActiveButton => 'Aktif Hesap Olarak Ayarla';

  @override
  String get commissionsTitle => 'Komisyonlar';

  @override
  String get commissionsTotalEarned => 'Toplam Kazanılan Komisyon';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count işlem',
      one: '$count işlem',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => 'Komisyon Geçmişi';

  @override
  String get commissionsEmptyTitle => 'Henüz komisyon yok';

  @override
  String get commissionsEmptyMessage =>
      'Kazandığınız komisyonlar burada görünecek.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'Promosyon kodu: $code';
  }

  @override
  String get commissionsDirectSale => 'Doğrudan satış';

  @override
  String get referralsTitle => 'Referanslar';

  @override
  String get referralsTotal => 'Toplam Referans';

  @override
  String get referralsTotalEarned => 'Toplam Kazanç';

  @override
  String get referralsGenerateNew => 'Yeni Referans Kodu Oluştur';

  @override
  String get referralsUnavailable =>
      'Referans bağlantıları, hesabınız doğrulandıktan sonra kullanılabilir olacaktır.';

  @override
  String get referralsCodesSection => 'Referans Kodları';

  @override
  String get referralsEmptyTitle => 'Henüz referans yok';

  @override
  String get referralsEmptyMessage =>
      'Kazanmaya başlamak için bir kod oluşturun ve paylaşın!';

  @override
  String get referralsCodeCopied => 'Kod kopyalandı!';

  @override
  String referralsUsedBy(String user) {
    return '$user tarafından kullanıldı';
  }

  @override
  String get referralsNotUsedYet => 'Henüz kullanılmadı';

  @override
  String referralsRegisteredOn(String date) {
    return '$date tarihinde kaydoldu';
  }

  @override
  String get referralsLinkGeneratedTitle => 'Referans Bağlantısı Oluşturuldu';

  @override
  String get referralsShareSubtitle =>
      'Kazanmaya başlamak için kodunuzu veya bağlantınızı paylaşın.';

  @override
  String get referralsCodeLabel => 'Referans Kodu';

  @override
  String get referralsLinkLabel => 'Referans Bağlantısı';

  @override
  String get referralsLinkCopied => 'Bağlantı kopyalandı!';

  @override
  String get referralsActivityTitle => 'Yönlendirilen Kullanıcı Etkinliği';

  @override
  String get referralsNoActivityData => 'Etkinlik verisi yok';

  @override
  String get referralsActivityWillAppear =>
      'Kullanıcı aktif olduğunda etkinlik burada görünecek.';

  @override
  String get referralsWindowSection => 'Referans Penceresi';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'Abonelikler ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'Uygulama Kullanım Etkinlikleri ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'Promosyon Kullanımları ($count)';
  }

  @override
  String get referralsNoActivityYet => 'Henüz etkinlik yok';

  @override
  String referralsItemFallback(int index) {
    return 'Öğe $index';
  }

  @override
  String get supportTicketsTitle => 'Destek Talepleri';

  @override
  String get supportFilterAll => 'Tümü';

  @override
  String get supportFilterOpen => 'Açık';

  @override
  String get supportFilterPending => 'Beklemede';

  @override
  String get supportFilterClosed => 'Kapalı';

  @override
  String get supportEmptyTitle => 'Henüz talep yok';

  @override
  String get supportEmptyMessage =>
      'Yeni bir destek talebi açmak için + simgesine dokunun.';

  @override
  String get newTicketTitle => 'Yeni Talep';

  @override
  String get newTicketSubmitted => 'Talep başarıyla gönderildi!';

  @override
  String get newTicketCategoryLabel => 'Kategori';

  @override
  String get newTicketPriorityLabel => 'Öncelik';

  @override
  String get newTicketSubjectLabel => 'Konu';

  @override
  String get newTicketSubjectRequired => 'Konu gereklidir';

  @override
  String get newTicketMessageLabel => 'Mesaj';

  @override
  String get newTicketMessageRequired => 'Mesaj gereklidir';

  @override
  String get newTicketSubmitButton => 'Talebi Gönder';

  @override
  String get newTicketCategoryTechnical => 'Teknik';

  @override
  String get newTicketCategoryPayment => 'Ödeme';

  @override
  String get newTicketPriorityNormal => 'Normal';

  @override
  String get newTicketPriorityHigh => 'Yüksek';

  @override
  String get newTicketPriorityUrgent => 'Acil';

  @override
  String get ticketDetailRefreshTooltip => 'Yenile';

  @override
  String get ticketDetailNoReplies => 'Henüz yanıt yok.';

  @override
  String get ticketDetailTeamWillRespond =>
      'Ekibimiz kısa süre içinde yanıt verecektir.';

  @override
  String get ticketDetailReplyHint => 'Bir yanıt yazın...';

  @override
  String get ticketDetailClosed => 'Bu talep kapatıldı.';

  @override
  String get agreementsTitle => 'Yasal Sözleşmeler';

  @override
  String get agreementsAccepted => 'Sözleşme kabul edildi';

  @override
  String get agreementsAllAcceptedTitle => 'Tüm sözleşmeler kabul edildi!';

  @override
  String get agreementsNoPending => 'Bekleyen sözleşmeniz yok.';

  @override
  String get agreementsAcceptedStatus => 'Kabul Edildi';

  @override
  String get agreementsPendingStatus => 'Onayınız bekleniyor';

  @override
  String get agreementsCheckboxLabel =>
      'Yukarıdaki şartları okudum ve kabul ediyorum';

  @override
  String get agreementsAcceptButton => 'Sözleşmeyi Kabul Et';

  @override
  String get knowledgeCenterTitle => 'Bilgi Merkezi';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'Başlarken';

  @override
  String get knowledgeCenterCategoryPayments => 'Ödemeler';

  @override
  String get knowledgeCenterCategoryAppsTools => 'Uygulamalar & Araçlar';

  @override
  String get knowledgeCenterCategoryAccount => 'Hesap';

  @override
  String get knowledgeCenterEmptyTitle => 'Henüz makale yok';

  @override
  String get knowledgeCenterEmptyMessage =>
      'Yeni içerikler için daha sonra tekrar kontrol edin.';

  @override
  String get subscriptionPageStub => 'Abonelikler Sayfası';
}
