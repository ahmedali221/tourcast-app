// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'NileTech 투어 가이드';

  @override
  String get commonOk => '확인';

  @override
  String get commonCancel => '취소';

  @override
  String get commonSave => '저장';

  @override
  String get commonRetry => '재시도';

  @override
  String get commonTryAgain => '다시 시도';

  @override
  String get commonLoading => '로딩 중...';

  @override
  String get commonSubmit => '제출';

  @override
  String get commonNext => '다음';

  @override
  String get commonBack => '뒤로';

  @override
  String get commonDone => '완료';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonEdit => '편집';

  @override
  String get commonActive => '활성';

  @override
  String get commonCopied => '복사됨!';

  @override
  String get commonContactSupport => '고객 지원팀 문의';

  @override
  String get commonPayoutsUnavailable => '계정이 인증되면 정산을 이용할 수 있습니다.';

  @override
  String get commonPleaseContactSupport => '고객 지원팀에 문의해 주세요.';

  @override
  String get commonLogout => '로그아웃';

  @override
  String get commonLogoutConfirm => '정말 로그아웃하시겠습니까?';

  @override
  String get commonSomethingWentWrong => '문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get settingsLanguage => '언어';

  @override
  String get settingsLanguageSubtitle => '선호하는 언어를 선택하세요';

  @override
  String get languageEnglish => '영어';

  @override
  String get languageArabic => '아랍어';

  @override
  String get languageChinese => '중국어';

  @override
  String get languageRussian => '러시아어';

  @override
  String get languageGerman => '독일어';

  @override
  String get languageFrench => '프랑스어';

  @override
  String get languageTurkish => '터키어';

  @override
  String get languageItalian => '이탈리아어';

  @override
  String get languageSpanish => '스페인어';

  @override
  String get languageJapanese => '일본어';

  @override
  String get languageKorean => '한국어';

  @override
  String get navHome => '홈';

  @override
  String get navMarketplace => '마켓플레이스';

  @override
  String get navWallet => '지갑';

  @override
  String get navSupport => '지원';

  @override
  String get navProfile => '프로필';

  @override
  String get validatorEmailRequired => '이메일을 입력해 주세요';

  @override
  String get validatorEmailInvalid => '유효한 이메일 주소를 입력해 주세요';

  @override
  String get validatorPasswordRequired => '비밀번호를 입력해 주세요';

  @override
  String get validatorPasswordTooShort => '비밀번호는 8자 이상이어야 합니다';

  @override
  String get validatorConfirmPasswordRequired => '비밀번호를 확인해 주세요';

  @override
  String get validatorPasswordMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String validatorFieldRequired(String field) {
    return '$field은(는) 필수 항목입니다';
  }

  @override
  String get validatorDefaultFieldName => '이 항목';

  @override
  String get validatorAmountRequired => '금액을 입력해 주세요';

  @override
  String get validatorAmountInvalid => '유효한 금액을 입력해 주세요';

  @override
  String validatorMinimumAmount(String min) {
    return '최소 금액은 \$$min입니다';
  }

  @override
  String get authTagline => '당신의 가이드. 당신의 비즈니스.';

  @override
  String get loginWelcomeBack => '다시 오신 것을 환영합니다';

  @override
  String get loginSubtitle => '가이드 계정으로 로그인하세요';

  @override
  String get loginEmailLabel => '이메일 주소';

  @override
  String get loginPasswordLabel => '비밀번호';

  @override
  String get loginForgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get loginButton => '로그인';

  @override
  String get loginNoAccount => '계정이 없으신가요?';

  @override
  String get loginRegisterLink => '회원가입';

  @override
  String get registerHeading => '계정 만들기';

  @override
  String get registerSubtitle => 'NileTech에 투어 가이드로 가입하세요';

  @override
  String get registerFullNameLabel => '이름';

  @override
  String get registerEmailLabel => '이메일';

  @override
  String get registerPasswordLabel => '비밀번호';

  @override
  String get registerConfirmPasswordLabel => '비밀번호 확인';

  @override
  String get registerReferralCodeLabel => '추천 코드 (선택 사항)';

  @override
  String get registerButton => '계정 만들기';

  @override
  String get registerAlreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get registerLoginLink => '로그인';

  @override
  String get forgotPasswordTitle => '비밀번호 찾기';

  @override
  String get forgotPasswordHeading => '비밀번호 재설정';

  @override
  String get forgotPasswordSubtitle => '이메일을 입력하시면 재설정 링크를 보내드립니다.';

  @override
  String get forgotPasswordEmailLabel => '이메일 주소';

  @override
  String get forgotPasswordSendButton => '재설정 링크 보내기';

  @override
  String get forgotPasswordSuccessHeading => '받은 편지함을 확인하세요';

  @override
  String get forgotPasswordSuccessBody => '비밀번호 재설정 링크가 이메일 주소로 전송되었습니다.';

  @override
  String get verifyEmailResentSnackbar => '인증 이메일을 재전송했습니다';

  @override
  String get verifyEmailHeading => '이메일 인증';

  @override
  String get verifyEmailBody =>
      '이메일로 인증 링크를 보내드렸습니다. 받은 편지함을 확인하고 링크를 클릭하여 계정을 활성화해 주세요.';

  @override
  String get verifyEmailContinueButton => '인증 완료, 계속하기';

  @override
  String get verifyEmailResendButton => '이메일 재전송';

  @override
  String get homeVerificationRequiredTitle => '인증 필요';

  @override
  String get homeAccountUnderReviewTitle => '계정 심사 중';

  @override
  String get homeApplicationRejectedTitle => '신청 거절됨';

  @override
  String get homeVerificationRequiredMessage => '앱을 이용하려면 먼저 인증 서류를 제출해야 합니다.';

  @override
  String get homePendingReviewMessage =>
      '가이드 신청서를 저희 팀에서 검토하고 있습니다. 승인되면 알려드리겠습니다.';

  @override
  String get homeRejectedMessage =>
      '신청이 승인되지 않았습니다. 아래 검토 노트를 확인하고 고객 지원팀에 문의해 주세요.';

  @override
  String get homeSubmitVerificationCta => '인증 제출하기';

  @override
  String get homeReviewNotesLabel => '검토 노트';

  @override
  String get greetingMorning => '좋은 아침이에요';

  @override
  String get greetingAfternoon => '좋은 오후예요';

  @override
  String get greetingEvening => '좋은 저녁이에요';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName님 👋';
  }

  @override
  String get homeYourBalance => '내 잔액';

  @override
  String get homeRequestPayout => '정산 요청';

  @override
  String get homeCommissions => '수수료';

  @override
  String get homeReferrals => '추천';

  @override
  String get homeAnnouncements => '공지사항';

  @override
  String get homeMyPromoCodes => '내 프로모션 코드';

  @override
  String get homeNoPromoCodes => '아직 프로모션 코드가 없습니다';

  @override
  String get homePendingBannerMessage =>
      '인증이 검토 중입니다. 승인될 때까지 앱을 둘러볼 수는 있지만 프로모션 코드 생성, 추천, 정산 요청은 이용할 수 없습니다.';

  @override
  String get notificationsTrayTitle => '알림';

  @override
  String get notificationsMarkAllRead => '모두 읽음으로 표시';

  @override
  String get notificationsEmptyTitle => '아직 알림이 없습니다';

  @override
  String get notificationsEmptyMessage => '모든 알림을 확인했습니다!';

  @override
  String get notificationsNewSection => '새 알림';

  @override
  String get notificationsEarlierSection => '이전 알림';

  @override
  String get profileTitle => '내 프로필';

  @override
  String get profileEditUnavailable => '계정이 인증되면 프로필을 편집할 수 있습니다.';

  @override
  String get profileCompleteness => '프로필 완성도';

  @override
  String get profileCountry => '국가';

  @override
  String get profileCity => '도시';

  @override
  String get profileYearsExperienceLabel => '경력 연수';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count년',
      one: '$count년',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => '언어';

  @override
  String get profileSpecializations => '전문 분야';

  @override
  String get profileBio => '소개';

  @override
  String get profileNoBio => '아직 등록된 소개가 없습니다.';

  @override
  String get profileDeleteAccount => '계정 삭제';

  @override
  String get profileDeleteConfirm => '이 작업은 영구적이며 되돌릴 수 없습니다. 계속하시겠습니까?';

  @override
  String get profileWallet => '지갑';

  @override
  String get profileViewAll => '전체 보기 →';

  @override
  String get profileAvailableBalance => '출금 가능 잔액';

  @override
  String get profilePayoutAccount => '정산 계좌';

  @override
  String get profileManage => '관리 →';

  @override
  String get profileSetupPayoutAccount => '정산 계좌 설정하기';

  @override
  String get profileUpdatedSuccess => '프로필이 성공적으로 업데이트되었습니다!';

  @override
  String get editProfileTitle => '프로필 편집';

  @override
  String get editProfileChangePhoto => '사진 변경';

  @override
  String get editProfileSelectCountry => '국가 선택';

  @override
  String get editProfileSaveChanges => '변경 사항 저장';

  @override
  String get editProfileSelectCountryTitle => '국가 선택';

  @override
  String get editProfileSearchCountryHint => '국가 검색...';

  @override
  String editProfileSelectItemTitle(String title) {
    return '$title 선택';
  }

  @override
  String editProfileDoneCount(int count) {
    return '완료 ($count)';
  }

  @override
  String get editProfileSearchGenericHint => '검색...';

  @override
  String editProfileApplyCount(int count) {
    return '적용 ($count개 선택됨)';
  }

  @override
  String get editProfileAddChip => '+ 추가';

  @override
  String get verificationTitle => '신원 인증';

  @override
  String get verificationDocumentDetails => '서류 정보';

  @override
  String get verificationNationalIdLabel => '신분증 번호';

  @override
  String get verificationLicenseLabel => '가이드 자격증 번호';

  @override
  String get verificationUploadDocuments => '서류 업로드';

  @override
  String get verificationUploadCaption => '선명하고 판독 가능한 서류 사본을 업로드해 주세요.';

  @override
  String get verificationIdFrontTitle => '신분증 — 앞면';

  @override
  String get verificationIdFrontSubtitle => '신분증 앞면';

  @override
  String get verificationFormatMax2mb => 'JPEG 또는 PNG • 최대 2MB';

  @override
  String get verificationIdBackTitle => '신분증 — 뒷면';

  @override
  String get verificationIdBackSubtitle => '신분증 뒷면';

  @override
  String get verificationLicenseTitle => '가이드 자격증';

  @override
  String get verificationLicenseSubtitle => '공식 투어 가이드 자격증 서류';

  @override
  String get verificationFormatMax5mb => 'JPEG 또는 PNG • 최대 5MB';

  @override
  String get verificationSubmitButton => '인증 제출';

  @override
  String get verificationUploaded => '업로드됨';

  @override
  String get verificationTapToUpload => '탭하여 업로드';

  @override
  String get verificationRejectedBanner => '제출하신 서류가 반려되었습니다. 다시 제출해 주세요.';

  @override
  String get verificationPendingBanner => '제출하신 서류를 검토 중입니다. 결과가 나오면 알려드리겠습니다.';

  @override
  String get verificationSubmittedDocuments => '제출된 서류';

  @override
  String get verificationVerifiedTitle => '신원 인증 완료';

  @override
  String get verificationVerifiedSubtitle => '신원 인증이 성공적으로 완료되었습니다.';

  @override
  String get verificationSuccessHeading => '서류 제출 완료';

  @override
  String get verificationSuccessBody =>
      '인증 서류가 성공적으로 제출되었습니다. 저희 팀이 검토 후 결과를 알려드리겠습니다.';

  @override
  String get verificationSuccessInfoBanner => '검토에는 영업일 기준 1~3일이 소요됩니다.';

  @override
  String get verificationGoHome => '홈으로 이동';

  @override
  String get marketplaceTitle => '마켓플레이스';

  @override
  String get marketplaceSearchHint => '앱 검색...';

  @override
  String get marketplaceEmptyTitle => '이용 가능한 앱이 없습니다';

  @override
  String get marketplaceEmptyMessage => '새로운 앱이 등록되면 다시 확인해 주세요.';

  @override
  String get marketplaceViewDetails => '자세히 보기 →';

  @override
  String get appDetailsCouldNotOpenStore => '스토어 링크를 열 수 없습니다';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => '소개';

  @override
  String get appDetailsAvailablePlans => '이용 가능한 요금제';

  @override
  String get appDetailsPromoUnavailable => '계정이 인증되면 프로모션 코드를 이용할 수 있습니다.';

  @override
  String get appDetailsGenerateButton => '+ 생성';

  @override
  String get appDetailsFailedLoadPromoCodes => '프로모션 코드를 불러오지 못했습니다.';

  @override
  String get appDetailsGenerateHint => '\"+ 생성\"을 탭하여 첫 코드를 만들어 보세요.';

  @override
  String get appDetailsFailedGeneratePromo => '프로모션 코드 생성에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get appDetailsCopyTooltip => '복사';

  @override
  String get appDetailsFailedLoadUsage => '사용 내역을 불러오지 못했습니다.';

  @override
  String get appDetailsNoUsage => '아직 사용 내역이 없습니다';

  @override
  String get appDetailsCreatePromoTitle => '프로모션 코드 만들기';

  @override
  String get appDetailsCreatePromoSubtitle =>
      '프로모션 코드의 사용자 지정 이름을 입력하거나, 비워 두면 자동으로 생성됩니다.';

  @override
  String get appDetailsPromoNameLabel => '프로모션 코드 이름 (선택 사항)';

  @override
  String get appDetailsPromoNameHint => '예: AHMED20 — 비워 두면 자동 생성됩니다';

  @override
  String get appDetailsGenerate => '생성';

  @override
  String get appDetailsPreview => '미리보기';

  @override
  String get appDetailsFree => '무료';

  @override
  String get walletTitle => '지갑';

  @override
  String get walletTransactionHistory => '거래 내역';

  @override
  String get walletNoTransactions => '아직 거래 내역이 없습니다';

  @override
  String get walletNoTransactionsMessage => '거래 내역이 여기에 표시됩니다.';

  @override
  String get walletPayoutRequestsTitle => '정산 요청';

  @override
  String get walletPayoutRequestsSubtitle => '정산 내역을 확인하고 관리하세요';

  @override
  String get payoutProfileSaved => '정산 프로필이 저장되었습니다!';

  @override
  String get payoutRequestSubmitted => '정산 요청이 제출되었습니다';

  @override
  String get payoutMethodTitle => '정산 방법';

  @override
  String get payoutPaymentDetailsTitle => '결제 정보';

  @override
  String get payoutManageAccount => '결제 계좌 관리';

  @override
  String get payoutHistorySection => '내역';

  @override
  String get payoutNoRequests => '아직 정산 요청이 없습니다';

  @override
  String get payoutNoRequestsMessage => '정산 요청 내역이 여기에 표시됩니다.';

  @override
  String get payoutChooseMethod => '출금 방법을 선택하세요.';

  @override
  String get payoutNoMethodsAvailable => '이용 가능한 정산 방법이 없습니다';

  @override
  String get payoutInfoBanner => '이 정보는 정산 프로필에 저장되며 이후 모든 출금에 사용됩니다.';

  @override
  String get payoutSaveContinue => '저장 후 계속';

  @override
  String payoutAvailableAmount(String amount) {
    return '출금 가능: $amount';
  }

  @override
  String get payoutChange => '변경';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => '최소 정산 금액은 \$10입니다';

  @override
  String get payoutSubmitRequest => '요청 제출';

  @override
  String get payoutAmountLabel => '금액 (USD)';

  @override
  String get paymentMethodsSaved => '결제 계좌가 저장되었습니다!';

  @override
  String get paymentMethodsTitle => '결제 방법';

  @override
  String get paymentMethodsNoneAvailable => '이용 가능한 결제 방법이 없습니다';

  @override
  String get paymentMethodsChoose => '결제 방법을 선택하세요';

  @override
  String get paymentMethodsAll => '전체 방법';

  @override
  String get paymentMethodsActiveBadge => '활성';

  @override
  String get paymentMethodsSetUp => '설정';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return '$methodName의 저장된 결제 정보를 업데이트하세요.';
  }

  @override
  String get paymentMethodsBecomeActiveInfo => '이 계좌가 활성 정산 계좌로 설정됩니다.';

  @override
  String get paymentMethodsSetActiveButton => '활성 계좌로 설정';

  @override
  String get commissionsTitle => '수수료';

  @override
  String get commissionsTotalEarned => '총 획득 수수료';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '거래 $count건',
      one: '거래 $count건',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => '수수료 내역';

  @override
  String get commissionsEmptyTitle => '아직 수수료가 없습니다';

  @override
  String get commissionsEmptyMessage => '획득한 수수료가 여기에 표시됩니다.';

  @override
  String commissionsPromoCodeLabel(String code) {
    return '프로모션 코드: $code';
  }

  @override
  String get commissionsDirectSale => '직접 판매';

  @override
  String get referralsTitle => '추천';

  @override
  String get referralsTotal => '총 추천 수';

  @override
  String get referralsTotalEarned => '총 획득 금액';

  @override
  String get referralsGenerateNew => '새 추천 코드 생성';

  @override
  String get referralsUnavailable => '계정이 인증되면 추천 링크를 이용할 수 있습니다.';

  @override
  String get referralsCodesSection => '추천 코드';

  @override
  String get referralsEmptyTitle => '아직 추천이 없습니다';

  @override
  String get referralsEmptyMessage => '코드를 생성하고 공유하여 수익을 시작해 보세요!';

  @override
  String get referralsCodeCopied => '코드가 복사되었습니다!';

  @override
  String referralsUsedBy(String user) {
    return '$user님이 사용함';
  }

  @override
  String get referralsNotUsedYet => '아직 사용되지 않음';

  @override
  String referralsRegisteredOn(String date) {
    return '$date에 등록됨';
  }

  @override
  String get referralsLinkGeneratedTitle => '추천 링크 생성됨';

  @override
  String get referralsShareSubtitle => '코드나 링크를 공유하여 수익을 시작하세요.';

  @override
  String get referralsCodeLabel => '추천 코드';

  @override
  String get referralsLinkLabel => '추천 링크';

  @override
  String get referralsLinkCopied => '링크가 복사되었습니다!';

  @override
  String get referralsActivityTitle => '추천된 사용자 활동';

  @override
  String get referralsNoActivityData => '활동 데이터가 없습니다';

  @override
  String get referralsActivityWillAppear => '사용자가 활동을 시작하면 여기에 표시됩니다.';

  @override
  String get referralsWindowSection => '추천 기간';

  @override
  String referralsSubscriptionsCount(int count) {
    return '구독 ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return '앱 사용 이벤트 ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return '프로모션 코드 사용 ($count)';
  }

  @override
  String get referralsNoActivityYet => '아직 활동이 없습니다';

  @override
  String referralsItemFallback(int index) {
    return '항목 $index';
  }

  @override
  String get supportTicketsTitle => '지원 티켓';

  @override
  String get supportFilterAll => '전체';

  @override
  String get supportFilterOpen => '열림';

  @override
  String get supportFilterPending => '대기 중';

  @override
  String get supportFilterClosed => '종료됨';

  @override
  String get supportEmptyTitle => '아직 티켓이 없습니다';

  @override
  String get supportEmptyMessage => '+를 탭하여 새 지원 티켓을 열어보세요.';

  @override
  String get newTicketTitle => '새 티켓';

  @override
  String get newTicketSubmitted => '티켓이 성공적으로 제출되었습니다!';

  @override
  String get newTicketCategoryLabel => '카테고리';

  @override
  String get newTicketPriorityLabel => '우선순위';

  @override
  String get newTicketSubjectLabel => '제목';

  @override
  String get newTicketSubjectRequired => '제목을 입력해 주세요';

  @override
  String get newTicketMessageLabel => '메시지';

  @override
  String get newTicketMessageRequired => '메시지를 입력해 주세요';

  @override
  String get newTicketSubmitButton => '티켓 제출';

  @override
  String get newTicketCategoryTechnical => '기술 지원';

  @override
  String get newTicketCategoryPayment => '결제';

  @override
  String get newTicketPriorityNormal => '보통';

  @override
  String get newTicketPriorityHigh => '높음';

  @override
  String get newTicketPriorityUrgent => '긴급';

  @override
  String get ticketDetailRefreshTooltip => '새로고침';

  @override
  String get ticketDetailNoReplies => '아직 답변이 없습니다.';

  @override
  String get ticketDetailTeamWillRespond => '저희 팀이 곧 답변드리겠습니다.';

  @override
  String get ticketDetailReplyHint => '답변을 입력하세요...';

  @override
  String get ticketDetailClosed => '이 티켓은 종료되었습니다.';

  @override
  String get agreementsTitle => '법적 계약';

  @override
  String get agreementsAccepted => '동의 완료';

  @override
  String get agreementsAllAcceptedTitle => '모든 계약에 동의했습니다!';

  @override
  String get agreementsNoPending => '대기 중인 계약이 없습니다.';

  @override
  String get agreementsAcceptedStatus => '동의함';

  @override
  String get agreementsPendingStatus => '동의 대기 중';

  @override
  String get agreementsCheckboxLabel => '위 약관을 읽었으며 이에 동의합니다';

  @override
  String get agreementsAcceptButton => '계약 동의';

  @override
  String get knowledgeCenterTitle => '도움말 센터';

  @override
  String get knowledgeCenterCategoryGettingStarted => '시작하기';

  @override
  String get knowledgeCenterCategoryPayments => '결제';

  @override
  String get knowledgeCenterCategoryAppsTools => '앱 및 도구';

  @override
  String get knowledgeCenterCategoryAccount => '계정';

  @override
  String get knowledgeCenterEmptyTitle => '아직 게시글이 없습니다';

  @override
  String get knowledgeCenterEmptyMessage => '새로운 콘텐츠가 등록되면 다시 확인해 주세요.';

  @override
  String get subscriptionPageStub => '구독 페이지';
}
