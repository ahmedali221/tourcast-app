// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'NileTech 导游';

  @override
  String get commonOk => '确定';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '保存';

  @override
  String get commonRetry => '重试';

  @override
  String get commonTryAgain => '再试一次';

  @override
  String get commonLoading => '加载中…';

  @override
  String get commonSubmit => '提交';

  @override
  String get commonNext => '下一步';

  @override
  String get commonBack => '返回';

  @override
  String get commonDone => '完成';

  @override
  String get commonDelete => '删除';

  @override
  String get commonEdit => '编辑';

  @override
  String get commonActive => '已启用';

  @override
  String get commonCopied => '已复制！';

  @override
  String get commonContactSupport => '联系客服';

  @override
  String get commonPayoutsUnavailable => '账户通过验证后即可使用提现功能。';

  @override
  String get commonPleaseContactSupport => '请联系客服。';

  @override
  String get commonLogout => '退出登录';

  @override
  String get commonLogoutConfirm => '确定要退出登录吗？';

  @override
  String get commonSomethingWentWrong => '出错了，请重试。';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageSubtitle => '选择您的首选语言';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageArabic => '阿拉伯语';

  @override
  String get languageChinese => '中文';

  @override
  String get languageRussian => '俄语';

  @override
  String get languageGerman => '德语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageTurkish => '土耳其语';

  @override
  String get languageItalian => '意大利语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageJapanese => '日语';

  @override
  String get languageKorean => '韩语';

  @override
  String get navHome => '首页';

  @override
  String get navMarketplace => '应用市场';

  @override
  String get navWallet => '钱包';

  @override
  String get navSupport => '客服';

  @override
  String get navProfile => '我的';

  @override
  String get validatorEmailRequired => '请输入邮箱地址';

  @override
  String get validatorEmailInvalid => '请输入有效的邮箱地址';

  @override
  String get validatorPasswordRequired => '请输入密码';

  @override
  String get validatorPasswordTooShort => '密码至少需要 8 个字符';

  @override
  String get validatorConfirmPasswordRequired => '请确认您的密码';

  @override
  String get validatorPasswordMismatch => '两次输入的密码不一致';

  @override
  String validatorFieldRequired(String field) {
    return '$field为必填项';
  }

  @override
  String get validatorDefaultFieldName => '该字段';

  @override
  String get validatorAmountRequired => '请输入金额';

  @override
  String get validatorAmountInvalid => '请输入有效的金额';

  @override
  String validatorMinimumAmount(String min) {
    return '最低金额为 \$$min';
  }

  @override
  String get authTagline => '您的向导。您的事业。';

  @override
  String get loginWelcomeBack => '欢迎回来';

  @override
  String get loginSubtitle => '登录您的导游账户';

  @override
  String get loginEmailLabel => '邮箱地址';

  @override
  String get loginPasswordLabel => '密码';

  @override
  String get loginForgotPassword => '忘记密码？';

  @override
  String get loginButton => '登录';

  @override
  String get loginNoAccount => '还没有账户？';

  @override
  String get loginRegisterLink => '注册';

  @override
  String get registerHeading => '创建账户';

  @override
  String get registerSubtitle => '加入 NileTech，成为一名导游';

  @override
  String get registerFullNameLabel => '姓名';

  @override
  String get registerEmailLabel => '邮箱';

  @override
  String get registerPasswordLabel => '密码';

  @override
  String get registerConfirmPasswordLabel => '确认密码';

  @override
  String get registerReferralCodeLabel => '推荐码（可选）';

  @override
  String get registerButton => '创建账户';

  @override
  String get registerAlreadyHaveAccount => '已有账户？';

  @override
  String get registerLoginLink => '登录';

  @override
  String get forgotPasswordTitle => '忘记密码';

  @override
  String get forgotPasswordHeading => '重置您的密码';

  @override
  String get forgotPasswordSubtitle => '请输入您的邮箱，我们将发送重置链接给您。';

  @override
  String get forgotPasswordEmailLabel => '邮箱地址';

  @override
  String get forgotPasswordSendButton => '发送重置链接';

  @override
  String get forgotPasswordSuccessHeading => '请查收邮件';

  @override
  String get forgotPasswordSuccessBody => '密码重置链接已发送至您的邮箱地址。';

  @override
  String get verifyEmailResentSnackbar => '验证邮件已重新发送';

  @override
  String get verifyEmailHeading => '验证您的邮箱';

  @override
  String get verifyEmailBody => '我们已向您的邮箱发送了验证链接。请查收邮件并点击链接以激活您的账户。';

  @override
  String get verifyEmailContinueButton => '我已验证，继续';

  @override
  String get verifyEmailResendButton => '重新发送邮件';

  @override
  String get homeVerificationRequiredTitle => '需要验证';

  @override
  String get homeAccountUnderReviewTitle => '账户审核中';

  @override
  String get homeApplicationRejectedTitle => '申请被拒绝';

  @override
  String get homeVerificationRequiredMessage => '您需要先提交验证文件，才能使用本应用。';

  @override
  String get homePendingReviewMessage => '您的导游申请正在由我们的团队审核，审核通过后会通知您。';

  @override
  String get homeRejectedMessage => '您的申请未获通过，请查看下方备注并联系客服。';

  @override
  String get homeSubmitVerificationCta => '提交验证';

  @override
  String get homeReviewNotesLabel => '审核备注';

  @override
  String get greetingMorning => '早上好';

  @override
  String get greetingAfternoon => '下午好';

  @override
  String get greetingEvening => '晚上好';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting，$firstName 👋';
  }

  @override
  String get homeYourBalance => '您的余额';

  @override
  String get homeRequestPayout => '申请提现';

  @override
  String get homeCommissions => '佣金';

  @override
  String get homeReferrals => '推荐';

  @override
  String get homeAnnouncements => '公告';

  @override
  String get homeMyPromoCodes => '我的优惠码';

  @override
  String get homeNoPromoCodes => '暂无优惠码';

  @override
  String get homePendingBannerMessage =>
      '您的验证正在审核中。审核通过前，您可以浏览应用，但无法创建优惠码、发起推荐或申请提现。';

  @override
  String get notificationsTrayTitle => '通知';

  @override
  String get notificationsMarkAllRead => '全部标为已读';

  @override
  String get notificationsEmptyTitle => '暂无通知';

  @override
  String get notificationsEmptyMessage => '太棒了，暂无新通知！';

  @override
  String get notificationsNewSection => '最新';

  @override
  String get notificationsEarlierSection => '更早';

  @override
  String get profileTitle => '我的资料';

  @override
  String get profileEditUnavailable => '账户通过验证后即可编辑资料。';

  @override
  String get profileCompleteness => '资料完整度';

  @override
  String get profileCountry => '国家';

  @override
  String get profileCity => '城市';

  @override
  String get profileYearsExperienceLabel => '从业年限';

  @override
  String profileYearsExperienceValue(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 年',
      one: '$count 年',
    );
    return '$_temp0';
  }

  @override
  String get profileMissingValue => '—';

  @override
  String get profileLanguages => '语言';

  @override
  String get profileSpecializations => '专长领域';

  @override
  String get profileBio => '简介';

  @override
  String get profileNoBio => '暂未添加简介。';

  @override
  String get profileDeleteAccount => '删除账户';

  @override
  String get profileDeleteConfirm => '此操作为永久操作，无法撤销。确定要继续吗？';

  @override
  String get profileWallet => '钱包';

  @override
  String get profileViewAll => '查看全部 →';

  @override
  String get profileAvailableBalance => '可用余额';

  @override
  String get profilePayoutAccount => '提现账户';

  @override
  String get profileManage => '管理 →';

  @override
  String get profileSetupPayoutAccount => '设置提现账户';

  @override
  String get profileUpdatedSuccess => '资料更新成功！';

  @override
  String get editProfileTitle => '编辑资料';

  @override
  String get editProfileChangePhoto => '更换照片';

  @override
  String get editProfileSelectCountry => '选择国家';

  @override
  String get editProfileSaveChanges => '保存更改';

  @override
  String get editProfileSelectCountryTitle => '选择国家';

  @override
  String get editProfileSearchCountryHint => '搜索国家…';

  @override
  String editProfileSelectItemTitle(String title) {
    return '选择$title';
  }

  @override
  String editProfileDoneCount(int count) {
    return '完成（$count）';
  }

  @override
  String get editProfileSearchGenericHint => '搜索…';

  @override
  String editProfileApplyCount(int count) {
    return '应用（已选 $count 项）';
  }

  @override
  String get editProfileAddChip => '+ 添加';

  @override
  String get verificationTitle => '身份验证';

  @override
  String get verificationDocumentDetails => '证件信息';

  @override
  String get verificationNationalIdLabel => '身份证号码';

  @override
  String get verificationLicenseLabel => '导游证号码';

  @override
  String get verificationUploadDocuments => '上传证件';

  @override
  String get verificationUploadCaption => '请上传清晰可辨认的证件照片。';

  @override
  String get verificationIdFrontTitle => '身份证 — 正面';

  @override
  String get verificationIdFrontSubtitle => '您身份证的正面照片';

  @override
  String get verificationFormatMax2mb => 'JPEG 或 PNG 格式 • 最大 2 MB';

  @override
  String get verificationIdBackTitle => '身份证 — 背面';

  @override
  String get verificationIdBackSubtitle => '您身份证的背面照片';

  @override
  String get verificationLicenseTitle => '导游证';

  @override
  String get verificationLicenseSubtitle => '官方导游证文件';

  @override
  String get verificationFormatMax5mb => 'JPEG 或 PNG 格式 • 最大 5 MB';

  @override
  String get verificationSubmitButton => '提交验证';

  @override
  String get verificationUploaded => '已上传';

  @override
  String get verificationTapToUpload => '点击上传';

  @override
  String get verificationRejectedBanner => '您的证件未通过审核，请重新提交。';

  @override
  String get verificationPendingBanner => '您的证件正在审核中，我们会及时通知您。';

  @override
  String get verificationSubmittedDocuments => '已提交的证件';

  @override
  String get verificationVerifiedTitle => '身份已验证';

  @override
  String get verificationVerifiedSubtitle => '您的身份已成功通过验证。';

  @override
  String get verificationSuccessHeading => '证件已提交';

  @override
  String get verificationSuccessBody => '您的验证证件已成功提交，我们的团队将进行审核，并将结果通知您。';

  @override
  String get verificationSuccessInfoBanner => '审核通常需要 1–3 个工作日。';

  @override
  String get verificationGoHome => '返回首页';

  @override
  String get marketplaceTitle => '应用市场';

  @override
  String get marketplaceSearchHint => '搜索应用…';

  @override
  String get marketplaceEmptyTitle => '暂无可用应用';

  @override
  String get marketplaceEmptyMessage => '请稍后再来查看新应用。';

  @override
  String get marketplaceViewDetails => '查看详情 →';

  @override
  String get appDetailsCouldNotOpenStore => '无法打开商店链接';

  @override
  String get appDetailsGooglePlay => 'Google Play';

  @override
  String get appDetailsAppStore => 'App Store';

  @override
  String get appDetailsAbout => '简介';

  @override
  String get appDetailsAvailablePlans => '可选套餐';

  @override
  String get appDetailsPromoUnavailable => '账户通过验证后即可使用优惠码功能。';

  @override
  String get appDetailsGenerateButton => '+ 生成';

  @override
  String get appDetailsFailedLoadPromoCodes => '加载优惠码失败。';

  @override
  String get appDetailsGenerateHint => '点击“+ 生成”即可创建您的第一个优惠码。';

  @override
  String get appDetailsFailedGeneratePromo => '生成优惠码失败，请重试。';

  @override
  String get appDetailsCopyTooltip => '复制';

  @override
  String get appDetailsFailedLoadUsage => '加载使用情况失败。';

  @override
  String get appDetailsNoUsage => '暂无使用记录';

  @override
  String get appDetailsCreatePromoTitle => '创建优惠码';

  @override
  String get appDetailsCreatePromoSubtitle => '为您的优惠码输入自定义名称，留空则自动生成。';

  @override
  String get appDetailsPromoNameLabel => '优惠码名称（可选）';

  @override
  String get appDetailsPromoNameHint => '例如 AHMED20 — 留空则自动生成';

  @override
  String get appDetailsGenerate => '生成';

  @override
  String get appDetailsPreview => '预览';

  @override
  String get appDetailsFree => '免费';

  @override
  String get walletTitle => '钱包';

  @override
  String get walletTransactionHistory => '交易记录';

  @override
  String get walletNoTransactions => '暂无交易记录';

  @override
  String get walletNoTransactionsMessage => '您的交易记录将显示在此处。';

  @override
  String get walletPayoutRequestsTitle => '提现申请';

  @override
  String get walletPayoutRequestsSubtitle => '查看并管理您的提现';

  @override
  String get payoutProfileSaved => '提现资料已保存！';

  @override
  String get payoutRequestSubmitted => '提现申请已提交';

  @override
  String get payoutMethodTitle => '提现方式';

  @override
  String get payoutPaymentDetailsTitle => '收款信息';

  @override
  String get payoutManageAccount => '管理收款账户';

  @override
  String get payoutHistorySection => '历史记录';

  @override
  String get payoutNoRequests => '暂无提现申请';

  @override
  String get payoutNoRequestsMessage => '您的提现申请将显示在此处。';

  @override
  String get payoutChooseMethod => '选择您希望收款的方式。';

  @override
  String get payoutNoMethodsAvailable => '暂无可用的提现方式';

  @override
  String get payoutInfoBanner => '此信息将保存至您的提现资料，并用于日后所有提现。';

  @override
  String get payoutSaveContinue => '保存并继续';

  @override
  String payoutAvailableAmount(String amount) {
    return '可用金额：$amount';
  }

  @override
  String get payoutChange => '更改';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => '最低提现金额为 \$10';

  @override
  String get payoutSubmitRequest => '提交申请';

  @override
  String get payoutAmountLabel => '金额（美元）';

  @override
  String get paymentMethodsSaved => '收款账户已保存！';

  @override
  String get paymentMethodsTitle => '收款方式';

  @override
  String get paymentMethodsNoneAvailable => '暂无可用的收款方式';

  @override
  String get paymentMethodsChoose => '选择一种收款方式';

  @override
  String get paymentMethodsAll => '全部方式';

  @override
  String get paymentMethodsActiveBadge => '已启用';

  @override
  String get paymentMethodsSetUp => '设置';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return '更新您为 $methodName 保存的收款信息。';
  }

  @override
  String get paymentMethodsBecomeActiveInfo => '此账户将成为您的提现账户。';

  @override
  String get paymentMethodsSetActiveButton => '设为提现账户';

  @override
  String get commissionsTitle => '佣金';

  @override
  String get commissionsTotalEarned => '累计佣金收入';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 笔交易',
      one: '$count 笔交易',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => '佣金记录';

  @override
  String get commissionsEmptyTitle => '暂无佣金记录';

  @override
  String get commissionsEmptyMessage => '您获得的佣金将显示在此处。';

  @override
  String commissionsPromoCodeLabel(String code) {
    return '优惠码：$code';
  }

  @override
  String get commissionsDirectSale => '直接销售';

  @override
  String get referralsTitle => '推荐';

  @override
  String get referralsTotal => '推荐总数';

  @override
  String get referralsTotalEarned => '累计收入';

  @override
  String get referralsGenerateNew => '生成新推荐码';

  @override
  String get referralsUnavailable => '账户通过验证后即可使用推荐链接功能。';

  @override
  String get referralsCodesSection => '推荐码';

  @override
  String get referralsEmptyTitle => '暂无推荐记录';

  @override
  String get referralsEmptyMessage => '生成一个推荐码并分享，即可开始赚取收益！';

  @override
  String get referralsCodeCopied => '推荐码已复制！';

  @override
  String referralsUsedBy(String user) {
    return '使用者：$user';
  }

  @override
  String get referralsNotUsedYet => '尚未使用';

  @override
  String referralsRegisteredOn(String date) {
    return '注册于 $date';
  }

  @override
  String get referralsLinkGeneratedTitle => '推荐链接已生成';

  @override
  String get referralsShareSubtitle => '分享您的推荐码或链接，开始赚取收益。';

  @override
  String get referralsCodeLabel => '推荐码';

  @override
  String get referralsLinkLabel => '推荐链接';

  @override
  String get referralsLinkCopied => '链接已复制！';

  @override
  String get referralsActivityTitle => '被推荐用户动态';

  @override
  String get referralsNoActivityData => '暂无动态数据';

  @override
  String get referralsActivityWillAppear => '用户开始活跃后，动态将在此显示。';

  @override
  String get referralsWindowSection => '推荐周期';

  @override
  String referralsSubscriptionsCount(int count) {
    return '订阅（$count）';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return '应用使用事件（$count）';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return '优惠码兑换（$count）';
  }

  @override
  String get referralsNoActivityYet => '暂无动态';

  @override
  String referralsItemFallback(int index) {
    return '项目 $index';
  }

  @override
  String get supportTicketsTitle => '支持工单';

  @override
  String get supportFilterAll => '全部';

  @override
  String get supportFilterOpen => '进行中';

  @override
  String get supportFilterPending => '待处理';

  @override
  String get supportFilterClosed => '已关闭';

  @override
  String get supportEmptyTitle => '暂无工单';

  @override
  String get supportEmptyMessage => '点击 + 创建新的支持工单。';

  @override
  String get newTicketTitle => '新建工单';

  @override
  String get newTicketSubmitted => '工单提交成功！';

  @override
  String get newTicketCategoryLabel => '类别';

  @override
  String get newTicketPriorityLabel => '优先级';

  @override
  String get newTicketSubjectLabel => '主题';

  @override
  String get newTicketSubjectRequired => '请输入主题';

  @override
  String get newTicketMessageLabel => '内容';

  @override
  String get newTicketMessageRequired => '请输入内容';

  @override
  String get newTicketSubmitButton => '提交工单';

  @override
  String get newTicketCategoryTechnical => '技术问题';

  @override
  String get newTicketCategoryPayment => '付款问题';

  @override
  String get newTicketPriorityNormal => '普通';

  @override
  String get newTicketPriorityHigh => '高';

  @override
  String get newTicketPriorityUrgent => '紧急';

  @override
  String get ticketDetailRefreshTooltip => '刷新';

  @override
  String get ticketDetailNoReplies => '暂无回复。';

  @override
  String get ticketDetailTeamWillRespond => '我们的团队将尽快回复。';

  @override
  String get ticketDetailReplyHint => '输入回复内容…';

  @override
  String get ticketDetailClosed => '该工单已关闭。';

  @override
  String get agreementsTitle => '法律协议';

  @override
  String get agreementsAccepted => '协议已接受';

  @override
  String get agreementsAllAcceptedTitle => '所有协议均已接受！';

  @override
  String get agreementsNoPending => '您没有待处理的协议。';

  @override
  String get agreementsAcceptedStatus => '已接受';

  @override
  String get agreementsPendingStatus => '待您接受';

  @override
  String get agreementsCheckboxLabel => '我已阅读并同意上述条款';

  @override
  String get agreementsAcceptButton => '接受协议';

  @override
  String get knowledgeCenterTitle => '知识中心';

  @override
  String get knowledgeCenterCategoryGettingStarted => '新手入门';

  @override
  String get knowledgeCenterCategoryPayments => '付款';

  @override
  String get knowledgeCenterCategoryAppsTools => '应用与工具';

  @override
  String get knowledgeCenterCategoryAccount => '账户';

  @override
  String get knowledgeCenterEmptyTitle => '暂无文章';

  @override
  String get knowledgeCenterEmptyMessage => '请稍后再来查看新内容。';

  @override
  String get subscriptionPageStub => '订阅页面';
}
