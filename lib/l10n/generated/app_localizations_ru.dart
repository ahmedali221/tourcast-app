// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'NileTech Tour Guide';

  @override
  String get commonOk => 'ОК';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonTryAgain => 'Попробовать снова';

  @override
  String get commonLoading => 'Загрузка...';

  @override
  String get commonSubmit => 'Отправить';

  @override
  String get commonNext => 'Далее';

  @override
  String get commonBack => 'Назад';

  @override
  String get commonDone => 'Готово';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonEdit => 'Изменить';

  @override
  String get commonActive => 'Активный';

  @override
  String get commonCopied => 'Скопировано!';

  @override
  String get commonContactSupport => 'Связаться с поддержкой';

  @override
  String get commonPayoutsUnavailable =>
      'Выплаты будут доступны после верификации вашего аккаунта.';

  @override
  String get commonPleaseContactSupport =>
      'Пожалуйста, свяжитесь с поддержкой.';

  @override
  String get commonLogout => 'Выйти';

  @override
  String get commonLogoutConfirm => 'Вы уверены, что хотите выйти?';

  @override
  String get commonSomethingWentWrong =>
      'Что-то пошло не так. Попробуйте ещё раз.';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSubtitle => 'Выберите предпочитаемый язык';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageArabic => 'Арабский';

  @override
  String get languageChinese => 'Китайский';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageGerman => 'Немецкий';

  @override
  String get languageFrench => 'Французский';

  @override
  String get languageTurkish => 'Турецкий';

  @override
  String get languageItalian => 'Итальянский';

  @override
  String get languageSpanish => 'Испанский';

  @override
  String get languageJapanese => 'Японский';

  @override
  String get languageKorean => 'Корейский';

  @override
  String get navHome => 'Главная';

  @override
  String get navMarketplace => 'Маркетплейс';

  @override
  String get navWallet => 'Кошелёк';

  @override
  String get navSupport => 'Поддержка';

  @override
  String get navProfile => 'Профиль';

  @override
  String get validatorEmailRequired => 'Укажите email';

  @override
  String get validatorEmailInvalid => 'Введите корректный email';

  @override
  String get validatorPasswordRequired => 'Укажите пароль';

  @override
  String get validatorPasswordTooShort =>
      'Пароль должен содержать не менее 8 символов';

  @override
  String get validatorConfirmPasswordRequired => 'Подтвердите пароль';

  @override
  String get validatorPasswordMismatch => 'Пароли не совпадают';

  @override
  String validatorFieldRequired(String field) {
    return 'Укажите $field';
  }

  @override
  String get validatorDefaultFieldName => 'Это поле';

  @override
  String get validatorAmountRequired => 'Укажите сумму';

  @override
  String get validatorAmountInvalid => 'Введите корректную сумму';

  @override
  String validatorMinimumAmount(String min) {
    return 'Минимальная сумма — \$$min';
  }

  @override
  String get authTagline => 'Ваш гид. Ваш бизнес.';

  @override
  String get loginWelcomeBack => 'С возвращением';

  @override
  String get loginSubtitle => 'Войдите в аккаунт гида';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Пароль';

  @override
  String get loginForgotPassword => 'Забыли пароль?';

  @override
  String get loginButton => 'Войти';

  @override
  String get loginNoAccount => 'Нет аккаунта?';

  @override
  String get loginRegisterLink => 'Регистрация';

  @override
  String get registerHeading => 'Создать аккаунт';

  @override
  String get registerSubtitle => 'Присоединяйтесь к NileTech в качестве гида';

  @override
  String get registerFullNameLabel => 'Полное имя';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerPasswordLabel => 'Пароль';

  @override
  String get registerConfirmPasswordLabel => 'Подтверждение пароля';

  @override
  String get registerReferralCodeLabel => 'Реферальный код (необязательно)';

  @override
  String get registerButton => 'Создать аккаунт';

  @override
  String get registerAlreadyHaveAccount => 'Уже есть аккаунт?';

  @override
  String get registerLoginLink => 'Войти';

  @override
  String get forgotPasswordTitle => 'Забыли пароль';

  @override
  String get forgotPasswordHeading => 'Сброс пароля';

  @override
  String get forgotPasswordSubtitle =>
      'Введите email, и мы отправим вам ссылку для сброса пароля.';

  @override
  String get forgotPasswordEmailLabel => 'Email';

  @override
  String get forgotPasswordSendButton => 'Отправить ссылку';

  @override
  String get forgotPasswordSuccessHeading => 'Проверьте почту';

  @override
  String get forgotPasswordSuccessBody =>
      'Ссылка для сброса пароля отправлена на ваш email.';

  @override
  String get verifyEmailResentSnackbar =>
      'Письмо с подтверждением отправлено повторно';

  @override
  String get verifyEmailHeading => 'Подтвердите email';

  @override
  String get verifyEmailBody =>
      'Мы отправили ссылку для подтверждения на ваш email. Проверьте почту и перейдите по ссылке, чтобы активировать аккаунт.';

  @override
  String get verifyEmailContinueButton => 'Подтверждено, продолжить';

  @override
  String get verifyEmailResendButton => 'Отправить письмо повторно';

  @override
  String get homeVerificationRequiredTitle => 'Требуется верификация';

  @override
  String get homeAccountUnderReviewTitle => 'Аккаунт на рассмотрении';

  @override
  String get homeApplicationRejectedTitle => 'Заявка отклонена';

  @override
  String get homeVerificationRequiredMessage =>
      'Перед началом работы в приложении необходимо отправить документы для верификации.';

  @override
  String get homePendingReviewMessage =>
      'Ваша заявка гида рассматривается нашей командой. Мы уведомим вас после одобрения.';

  @override
  String get homeRejectedMessage =>
      'Ваша заявка не была одобрена. Ознакомьтесь с примечаниями ниже и свяжитесь с поддержкой.';

  @override
  String get homeSubmitVerificationCta => 'Отправить документы';

  @override
  String get homeReviewNotesLabel => 'Примечания к проверке';

  @override
  String get greetingMorning => 'Доброе утро';

  @override
  String get greetingAfternoon => 'Добрый день';

  @override
  String get greetingEvening => 'Добрый вечер';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'Ваш баланс';

  @override
  String get homeRequestPayout => 'Запросить выплату';

  @override
  String get homeCommissions => 'Комиссии';

  @override
  String get homeReferrals => 'Рефералы';

  @override
  String get homeAnnouncements => 'Объявления';

  @override
  String get homeMyPromoCodes => 'Мои промокоды';

  @override
  String get homeNoPromoCodes => 'Пока нет промокодов';

  @override
  String get homePendingBannerMessage =>
      'Ваша верификация проверяется. Вы можете пользоваться приложением, но не сможете создавать промокоды, приглашать рефералов или запрашивать выплаты до одобрения.';

  @override
  String get notificationsTrayTitle => 'Уведомления';

  @override
  String get notificationsMarkAllRead => 'Отметить все как прочитанные';

  @override
  String get notificationsEmptyTitle => 'Пока нет уведомлений';

  @override
  String get notificationsEmptyMessage => 'Все уведомления прочитаны!';

  @override
  String get notificationsNewSection => 'Новые';

  @override
  String get notificationsEarlierSection => 'Ранее';

  @override
  String get profileTitle => 'Мой профиль';

  @override
  String get profileEditUnavailable =>
      'Редактирование профиля будет доступно после верификации аккаунта.';

  @override
  String get profileCompleteness => 'Заполненность профиля';

  @override
  String get profileCountry => 'Страна';

  @override
  String get profileCity => 'Город';

  @override
  String get profileYearsExperienceLabel => 'Опыт работы';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count лет',
      one: '$count год',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => 'Языки';

  @override
  String get profileSpecializations => 'Специализации';

  @override
  String get profileBio => 'О себе';

  @override
  String get profileNoBio => 'Информация о себе ещё не добавлена.';

  @override
  String get profileDeleteAccount => 'Удалить аккаунт';

  @override
  String get profileDeleteConfirm =>
      'Это действие необратимо и не может быть отменено. Вы уверены?';

  @override
  String get profileWallet => 'Кошелёк';

  @override
  String get profileViewAll => 'Смотреть все →';

  @override
  String get profileAvailableBalance => 'Доступный баланс';

  @override
  String get profilePayoutAccount => 'Счёт для выплат';

  @override
  String get profileManage => 'Управление →';

  @override
  String get profileSetupPayoutAccount => 'Настроить счёт для выплат';

  @override
  String get profileUpdatedSuccess => 'Профиль успешно обновлён!';

  @override
  String get editProfileTitle => 'Редактировать профиль';

  @override
  String get editProfileChangePhoto => 'Изменить фото';

  @override
  String get editProfileSelectCountry => 'Выберите страну';

  @override
  String get editProfileSaveChanges => 'Сохранить изменения';

  @override
  String get editProfileSelectCountryTitle => 'Выбор страны';

  @override
  String get editProfileSearchCountryHint => 'Поиск страны...';

  @override
  String editProfileSelectItemTitle(String title) {
    return 'Выберите $title';
  }

  @override
  String editProfileDoneCount(int count) {
    return 'Готово ($count)';
  }

  @override
  String get editProfileSearchGenericHint => 'Поиск...';

  @override
  String editProfileApplyCount(int count) {
    return 'Применить ($count выбрано)';
  }

  @override
  String get editProfileAddChip => '+ Добавить';

  @override
  String get verificationTitle => 'Верификация личности';

  @override
  String get verificationDocumentDetails => 'Данные документа';

  @override
  String get verificationNationalIdLabel => 'Номер удостоверения личности';

  @override
  String get verificationLicenseLabel => 'Номер лицензии гида';

  @override
  String get verificationUploadDocuments => 'Загрузка документов';

  @override
  String get verificationUploadCaption =>
      'Загрузите чёткие, читаемые копии ваших документов.';

  @override
  String get verificationIdFrontTitle =>
      'Удостоверение личности — лицевая сторона';

  @override
  String get verificationIdFrontSubtitle =>
      'Лицевая сторона вашего удостоверения личности';

  @override
  String get verificationFormatMax2mb => 'JPEG или PNG • Макс. 2 МБ';

  @override
  String get verificationIdBackTitle =>
      'Удостоверение личности — оборотная сторона';

  @override
  String get verificationIdBackSubtitle =>
      'Оборотная сторона вашего удостоверения личности';

  @override
  String get verificationLicenseTitle => 'Лицензия гида';

  @override
  String get verificationLicenseSubtitle =>
      'Официальный документ — лицензия туристического гида';

  @override
  String get verificationFormatMax5mb => 'JPEG или PNG • Макс. 5 МБ';

  @override
  String get verificationSubmitButton => 'Отправить на верификацию';

  @override
  String get verificationUploaded => 'Загружено';

  @override
  String get verificationTapToUpload => 'Нажмите, чтобы загрузить';

  @override
  String get verificationRejectedBanner =>
      'Ваши документы были отклонены. Пожалуйста, отправьте их снова.';

  @override
  String get verificationPendingBanner =>
      'Ваши документы находятся на проверке. Мы вас уведомим.';

  @override
  String get verificationSubmittedDocuments => 'Отправленные документы';

  @override
  String get verificationVerifiedTitle => 'Личность подтверждена';

  @override
  String get verificationVerifiedSubtitle =>
      'Ваша личность была успешно подтверждена.';

  @override
  String get verificationSuccessHeading => 'Документы отправлены';

  @override
  String get verificationSuccessBody =>
      'Ваши документы для верификации успешно отправлены. Наша команда рассмотрит их и сообщит вам о результате.';

  @override
  String get verificationSuccessInfoBanner =>
      'Рассмотрение обычно занимает 1–3 рабочих дня.';

  @override
  String get verificationGoHome => 'На главную';

  @override
  String get marketplaceTitle => 'Маркетплейс';

  @override
  String get marketplaceSearchHint => 'Поиск приложений...';

  @override
  String get marketplaceEmptyTitle => 'Нет доступных приложений';

  @override
  String get marketplaceEmptyMessage =>
      'Загляните позже — здесь появятся новые приложения.';

  @override
  String get marketplaceViewDetails => 'Подробнее →';

  @override
  String get appDetailsCouldNotOpenStore =>
      'Не удалось открыть ссылку на магазин';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => 'О приложении';

  @override
  String get appDetailsAvailablePlans => 'Доступные тарифы';

  @override
  String get appDetailsPromoUnavailable =>
      'Промокоды будут доступны после верификации вашего аккаунта.';

  @override
  String get appDetailsGenerateButton => '+ Создать';

  @override
  String get appDetailsFailedLoadPromoCodes =>
      'Не удалось загрузить промокоды.';

  @override
  String get appDetailsGenerateHint =>
      'Нажмите «+ Создать», чтобы создать свой первый код.';

  @override
  String get appDetailsFailedGeneratePromo =>
      'Не удалось создать промокод. Попробуйте ещё раз.';

  @override
  String get appDetailsCopyTooltip => 'Копировать';

  @override
  String get appDetailsFailedLoadUsage =>
      'Не удалось загрузить данные об использовании.';

  @override
  String get appDetailsNoUsage => 'Пока нет данных об использовании';

  @override
  String get appDetailsCreatePromoTitle => 'Создание промокода';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'Введите собственное название промокода или оставьте поле пустым для автоматической генерации.';

  @override
  String get appDetailsPromoNameLabel => 'Название промокода (необязательно)';

  @override
  String get appDetailsPromoNameHint =>
      'например, AHMED20 — оставьте пустым для автогенерации';

  @override
  String get appDetailsGenerate => 'Создать';

  @override
  String get appDetailsPreview => 'Предпросмотр';

  @override
  String get appDetailsFree => 'Бесплатно';

  @override
  String get walletTitle => 'Кошелёк';

  @override
  String get walletTransactionHistory => 'История операций';

  @override
  String get walletNoTransactions => 'Пока нет операций';

  @override
  String get walletNoTransactionsMessage =>
      'Здесь будет отображаться история ваших операций.';

  @override
  String get walletPayoutRequestsTitle => 'Запросы на выплату';

  @override
  String get walletPayoutRequestsSubtitle => 'Просмотр и управление выплатами';

  @override
  String get payoutProfileSaved => 'Профиль для выплат сохранён!';

  @override
  String get payoutRequestSubmitted => 'Запрос на выплату отправлен';

  @override
  String get payoutMethodTitle => 'Способ выплаты';

  @override
  String get payoutPaymentDetailsTitle => 'Платёжные реквизиты';

  @override
  String get payoutManageAccount => 'Управление платёжным счётом';

  @override
  String get payoutHistorySection => 'История';

  @override
  String get payoutNoRequests => 'Пока нет запросов на выплату';

  @override
  String get payoutNoRequestsMessage =>
      'Здесь будут отображаться ваши запросы на выплату.';

  @override
  String get payoutChooseMethod => 'Выберите способ получения денег.';

  @override
  String get payoutNoMethodsAvailable => 'Нет доступных способов выплаты';

  @override
  String get payoutInfoBanner =>
      'Эта информация сохраняется в вашем профиле выплат и используется для всех будущих выводов средств.';

  @override
  String get payoutSaveContinue => 'Сохранить и продолжить';

  @override
  String payoutAvailableAmount(String amount) {
    return 'Доступно: $amount';
  }

  @override
  String get payoutChange => 'Изменить';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => 'Минимальная сумма выплаты — \$10';

  @override
  String get payoutSubmitRequest => 'Отправить запрос';

  @override
  String get payoutAmountLabel => 'Сумма (USD)';

  @override
  String get paymentMethodsSaved => 'Платёжный счёт сохранён!';

  @override
  String get paymentMethodsTitle => 'Способы оплаты';

  @override
  String get paymentMethodsNoneAvailable => 'Нет доступных способов оплаты';

  @override
  String get paymentMethodsChoose => 'Выберите способ оплаты';

  @override
  String get paymentMethodsAll => 'Все способы';

  @override
  String get paymentMethodsActiveBadge => 'АКТИВНО';

  @override
  String get paymentMethodsSetUp => 'Настроить';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return 'Обновите сохранённые платёжные данные для $methodName.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo =>
      'Это станет вашим активным счётом для выплат.';

  @override
  String get paymentMethodsSetActiveButton => 'Сделать активным счётом';

  @override
  String get commissionsTitle => 'Комиссии';

  @override
  String get commissionsTotalEarned => 'Всего заработано комиссий';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count транзакций',
      one: '$count транзакция',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => 'История комиссий';

  @override
  String get commissionsEmptyTitle => 'Пока нет комиссий';

  @override
  String get commissionsEmptyMessage =>
      'Здесь будут отображаться ваши заработанные комиссии.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'Промокод: $code';
  }

  @override
  String get commissionsDirectSale => 'Прямая продажа';

  @override
  String get referralsTitle => 'Рефералы';

  @override
  String get referralsTotal => 'Всего рефералов';

  @override
  String get referralsTotalEarned => 'Всего заработано';

  @override
  String get referralsGenerateNew => 'Создать новый реферальный код';

  @override
  String get referralsUnavailable =>
      'Реферальные ссылки будут доступны после верификации вашего аккаунта.';

  @override
  String get referralsCodesSection => 'Реферальные коды';

  @override
  String get referralsEmptyTitle => 'Пока нет рефералов';

  @override
  String get referralsEmptyMessage =>
      'Создайте код и поделитесь им, чтобы начать зарабатывать!';

  @override
  String get referralsCodeCopied => 'Код скопирован!';

  @override
  String referralsUsedBy(String user) {
    return 'Использован пользователем $user';
  }

  @override
  String get referralsNotUsedYet => 'Ещё не использован';

  @override
  String referralsRegisteredOn(String date) {
    return 'Зарегистрирован $date';
  }

  @override
  String get referralsLinkGeneratedTitle => 'Реферальная ссылка создана';

  @override
  String get referralsShareSubtitle =>
      'Поделитесь своим кодом или ссылкой, чтобы начать зарабатывать.';

  @override
  String get referralsCodeLabel => 'Реферальный код';

  @override
  String get referralsLinkLabel => 'Реферальная ссылка';

  @override
  String get referralsLinkCopied => 'Ссылка скопирована!';

  @override
  String get referralsActivityTitle => 'Активность приглашённого пользователя';

  @override
  String get referralsNoActivityData => 'Нет данных об активности';

  @override
  String get referralsActivityWillAppear =>
      'Активность появится, как только пользователь начнёт действовать.';

  @override
  String get referralsWindowSection => 'Реферальный период';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'Подписки ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'События использования приложения ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'Использования промокодов ($count)';
  }

  @override
  String get referralsNoActivityYet => 'Пока нет активности';

  @override
  String referralsItemFallback(int index) {
    return 'Элемент $index';
  }

  @override
  String get supportTicketsTitle => 'Обращения в поддержку';

  @override
  String get supportFilterAll => 'Все';

  @override
  String get supportFilterOpen => 'Открытые';

  @override
  String get supportFilterPending => 'В ожидании';

  @override
  String get supportFilterClosed => 'Закрытые';

  @override
  String get supportEmptyTitle => 'Пока нет обращений';

  @override
  String get supportEmptyMessage => 'Нажмите +, чтобы создать новое обращение.';

  @override
  String get newTicketTitle => 'Новое обращение';

  @override
  String get newTicketSubmitted => 'Обращение успешно отправлено!';

  @override
  String get newTicketCategoryLabel => 'Категория';

  @override
  String get newTicketPriorityLabel => 'Приоритет';

  @override
  String get newTicketSubjectLabel => 'Тема';

  @override
  String get newTicketSubjectRequired => 'Укажите тему';

  @override
  String get newTicketMessageLabel => 'Сообщение';

  @override
  String get newTicketMessageRequired => 'Укажите сообщение';

  @override
  String get newTicketSubmitButton => 'Отправить обращение';

  @override
  String get newTicketCategoryTechnical => 'Техническая';

  @override
  String get newTicketCategoryPayment => 'Оплата';

  @override
  String get newTicketPriorityNormal => 'Обычный';

  @override
  String get newTicketPriorityHigh => 'Высокий';

  @override
  String get newTicketPriorityUrgent => 'Срочный';

  @override
  String get ticketDetailRefreshTooltip => 'Обновить';

  @override
  String get ticketDetailNoReplies => 'Пока нет ответов.';

  @override
  String get ticketDetailTeamWillRespond => 'Наша команда скоро ответит.';

  @override
  String get ticketDetailReplyHint => 'Введите ответ...';

  @override
  String get ticketDetailClosed => 'Это обращение закрыто.';

  @override
  String get agreementsTitle => 'Юридические соглашения';

  @override
  String get agreementsAccepted => 'Соглашение принято';

  @override
  String get agreementsAllAcceptedTitle => 'Все соглашения приняты!';

  @override
  String get agreementsNoPending => 'У вас нет соглашений, ожидающих принятия.';

  @override
  String get agreementsAcceptedStatus => 'Принято';

  @override
  String get agreementsPendingStatus => 'Ожидает вашего принятия';

  @override
  String get agreementsCheckboxLabel =>
      'Я прочитал(а) и согласен(на) с условиями выше';

  @override
  String get agreementsAcceptButton => 'Принять соглашение';

  @override
  String get knowledgeCenterTitle => 'Центр знаний';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'Начало работы';

  @override
  String get knowledgeCenterCategoryPayments => 'Платежи';

  @override
  String get knowledgeCenterCategoryAppsTools => 'Приложения и инструменты';

  @override
  String get knowledgeCenterCategoryAccount => 'Аккаунт';

  @override
  String get knowledgeCenterEmptyTitle => 'Пока нет статей';

  @override
  String get knowledgeCenterEmptyMessage =>
      'Загляните позже за новыми материалами.';

  @override
  String get subscriptionPageStub => 'Страница подписок';
}
