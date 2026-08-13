// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'NileTech ツアーガイド';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonSave => '保存';

  @override
  String get commonRetry => '再試行';

  @override
  String get commonTryAgain => 'もう一度試してください';

  @override
  String get commonLoading => '読み込み中...';

  @override
  String get commonSubmit => '送信';

  @override
  String get commonNext => '次へ';

  @override
  String get commonBack => '戻る';

  @override
  String get commonDone => '完了';

  @override
  String get commonDelete => '削除';

  @override
  String get commonEdit => '編集';

  @override
  String get commonActive => 'アクティブ';

  @override
  String get commonCopied => 'コピーしました！';

  @override
  String get commonContactSupport => 'サポートに連絡する';

  @override
  String get commonPayoutsUnavailable => 'アカウントが認証されると、支払いが可能になります。';

  @override
  String get commonPleaseContactSupport => 'サポートにお問い合わせください。';

  @override
  String get commonLogout => 'ログアウト';

  @override
  String get commonLogoutConfirm => 'ログアウトしてもよろしいですか?';

  @override
  String get commonSomethingWentWrong => '問題が発生しました';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageSubtitle => '希望する言語を選択してください';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageArabic => 'アラビア語';

  @override
  String get languageChinese => '中国語';

  @override
  String get languageRussian => 'ロシア語';

  @override
  String get languageGerman => 'ドイツ語';

  @override
  String get languageFrench => 'フランス語';

  @override
  String get languageTurkish => 'トルコ語';

  @override
  String get languageItalian => 'イタリア語';

  @override
  String get languageSpanish => 'スペイン語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageKorean => '韓国語';

  @override
  String get navHome => 'ホーム';

  @override
  String get navMarketplace => 'マーケットプレイス';

  @override
  String get navWallet => '財布';

  @override
  String get navSupport => 'サポート';

  @override
  String get navProfile => 'プロフィール';

  @override
  String get validatorEmailRequired => 'メールアドレスは必須です';

  @override
  String get validatorEmailInvalid => '有効なメールアドレスを入力してください';

  @override
  String get validatorPasswordRequired => 'パスワードが必要です';

  @override
  String get validatorPasswordTooShort => 'パスワードは8文字以上である必要があります';

  @override
  String get validatorConfirmPasswordRequired => 'パスワードを確認してください';

  @override
  String get validatorPasswordMismatch => 'パスワードが一致しません';

  @override
  String validatorFieldRequired(String field) {
    return '$fieldは必須です';
  }

  @override
  String get validatorDefaultFieldName => 'このフィールド';

  @override
  String get validatorAmountRequired => '金額は必須です';

  @override
  String get validatorAmountInvalid => '有効な金額を入力してください';

  @override
  String validatorMinimumAmount(String min) {
    return '最小金額は \$$min です';
  }

  @override
  String get authTagline => 'あなたのガイド。あなたのビジネス。';

  @override
  String get loginWelcomeBack => 'おかえりなさい';

  @override
  String get loginSubtitle => 'ガイドアカウントにログインします';

  @override
  String get loginEmailLabel => 'メールアドレス';

  @override
  String get loginPasswordLabel => 'パスワード';

  @override
  String get loginForgotPassword => 'パスワードをお忘れですか?';

  @override
  String get loginButton => 'ログイン';

  @override
  String get loginNoAccount => 'アカウントをお持ちでない場合は、';

  @override
  String get loginRegisterLink => '登録する';

  @override
  String get registerHeading => 'アカウントの作成';

  @override
  String get registerSubtitle => 'NileTech にツアーガイドとして参加する';

  @override
  String get registerFullNameLabel => 'フルネーム';

  @override
  String get registerEmailLabel => '電子メール';

  @override
  String get registerPasswordLabel => 'パスワード';

  @override
  String get registerConfirmPasswordLabel => 'パスワードの確認';

  @override
  String get registerReferralCodeLabel => '紹介コード (オプション)';

  @override
  String get registerButton => 'アカウントの作成';

  @override
  String get registerAlreadyHaveAccount => 'すでにアカウントをお持ちですか?';

  @override
  String get registerLoginLink => 'ログイン';

  @override
  String get forgotPasswordTitle => 'パスワードを忘れた場合';

  @override
  String get forgotPasswordHeading => 'パスワードをリセットする';

  @override
  String get forgotPasswordSubtitle => 'メールアドレスを入力してください。リセット用のリンクが送信されます。';

  @override
  String get forgotPasswordEmailLabel => 'メールアドレス';

  @override
  String get forgotPasswordSendButton => 'リセットリンクを送信する';

  @override
  String get forgotPasswordSuccessHeading => '受信箱を確認してください';

  @override
  String get forgotPasswordSuccessBody => 'パスワードリセットリンクがあなたの電子メールアドレスに送信されました。';

  @override
  String get verifyEmailResentSnackbar => '確認メールを再送信しました';

  @override
  String get verifyEmailHeading => 'メールアドレスを確認してください';

  @override
  String get verifyEmailBody =>
      'あなたの電子メールに確認リンクを送信しました。受信箱を確認し、リンクをクリックしてアカウントを有効にしてください。';

  @override
  String get verifyEmailContinueButton => '確認しました、続行します';

  @override
  String get verifyEmailResendButton => 'メールを再送信する';

  @override
  String get homeVerificationRequiredTitle => '検証が必要です';

  @override
  String get homeAccountUnderReviewTitle => 'レビュー中のアカウント';

  @override
  String get homeApplicationRejectedTitle => '申請は拒否されました';

  @override
  String get homeVerificationRequiredMessage =>
      'アプリにアクセスするには、事前に確認書類を提出する必要があります。';

  @override
  String get homePendingReviewMessage =>
      'あなたのガイド申請書は私たちのチームによって審査されています。承認されると通知が届きます。';

  @override
  String get homeRejectedMessage =>
      'あなたの申請は承認されませんでした。以下の注意事項をご確認の上、サポートにお問い合わせください。';

  @override
  String get homeSubmitVerificationCta => '検証の送信';

  @override
  String get homeReviewNotesLabel => 'レビューノート';

  @override
  String get greetingMorning => 'おはようございます';

  @override
  String get greetingAfternoon => 'こんにちは';

  @override
  String get greetingEvening => 'こんばんは。';

  @override
  String homeGreeting(String greeting, String firstName) {
    return '$greeting, $firstName 👋';
  }

  @override
  String get homeYourBalance => 'あなたの残高';

  @override
  String get homeRequestPayout => '支払いのリクエスト';

  @override
  String get homeCommissions => '手数料';

  @override
  String get homeReferrals => '紹介';

  @override
  String get homeAnnouncements => 'お知らせ';

  @override
  String get homeMyPromoCodes => '私のプロモーション コード';

  @override
  String get homeNoPromoCodes => 'プロモーション コードはまだありません';

  @override
  String get homePendingBannerMessage =>
      'あなたの認証は審査中です。アプリを閲覧することはできますが、承認されるまでプロモーション コードや紹介を作成したり、支払いをリクエストしたりすることはできません。';

  @override
  String get notificationsTrayTitle => '通知';

  @override
  String get notificationsMarkAllRead => 'すべて既読としてマークする';

  @override
  String get notificationsEmptyTitle => 'まだ通知はありません';

  @override
  String get notificationsEmptyMessage => '皆さんも追い込まれていますね！';

  @override
  String get notificationsNewSection => '新しい';

  @override
  String get notificationsEarlierSection => '以前';

  @override
  String get profileTitle => '私のプロフィール';

  @override
  String get profileEditUnavailable => 'アカウントが認証されると、プロフィールの編集が可能になります。';

  @override
  String get profileCompleteness => 'プロファイルの完全性';

  @override
  String get profileCountry => '国';

  @override
  String get profileCity => '市';

  @override
  String get profileYearsExperienceLabel => '長年の経験';

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
  String get profileLanguages => '言語';

  @override
  String get profileSpecializations => '専門分野';

  @override
  String get profileBio => '略歴';

  @override
  String get profileNoBio => 'まだバイオは追加されていません。';

  @override
  String get profileDeleteAccount => 'アカウントの削除';

  @override
  String get profileDeleteConfirm => 'このアクションは永続的であり、元に戻すことはできません。本気ですか？';

  @override
  String get profileWallet => '財布';

  @override
  String get profileViewAll => 'すべて表示';

  @override
  String get profileAvailableBalance => '利用可能残高';

  @override
  String get profilePayoutAccount => '支払い口座';

  @override
  String get profileManage => '→ を管理する';

  @override
  String get profileSetupPayoutAccount => '支払いアカウントを設定する';

  @override
  String get profileUpdatedSuccess => 'プロフィールが正常に更新されました。';

  @override
  String get editProfileTitle => 'プロフィールの編集';

  @override
  String get editProfileChangePhoto => '写真を変更する';

  @override
  String get editProfileSelectCountry => '国を選択してください';

  @override
  String get editProfileSaveChanges => '変更を保存';

  @override
  String get editProfileSelectCountryTitle => '国を選択してください';

  @override
  String get editProfileSearchCountryHint => '国を検索...';

  @override
  String editProfileSelectItemTitle(String title) {
    return '$titleを選択してください';
  }

  @override
  String editProfileDoneCount(int count) {
    return '完了 ($count)';
  }

  @override
  String get editProfileSearchGenericHint => '検索...';

  @override
  String editProfileApplyCount(int count) {
    return '適用 ($count が選択されました)';
  }

  @override
  String get editProfileAddChip => '+追加';

  @override
  String get verificationTitle => '本人確認';

  @override
  String get verificationDocumentDetails => '文書の詳細';

  @override
  String get verificationNationalIdLabel => '国民ID番号';

  @override
  String get verificationLicenseLabel => 'ガイドライセンス番号';

  @override
  String get verificationUploadDocuments => '書類のアップロード';

  @override
  String get verificationUploadCaption => '書類の鮮明で読みやすいコピーをアップロードしてください。';

  @override
  String get verificationIdFrontTitle => '国民 ID — 前面';

  @override
  String get verificationIdFrontSubtitle => '国民IDカードの表面';

  @override
  String get verificationFormatMax2mb => 'JPEG または PNG • 最大 2 MB';

  @override
  String get verificationIdBackTitle => '国民 ID — 戻る';

  @override
  String get verificationIdBackSubtitle => '国民IDカードの裏面';

  @override
  String get verificationLicenseTitle => 'ガイドライセンス';

  @override
  String get verificationLicenseSubtitle => '公式ツアーガイドライセンス書類';

  @override
  String get verificationFormatMax5mb => 'JPEG または PNG • 最大 5 MB';

  @override
  String get verificationSubmitButton => '検証のために送信する';

  @override
  String get verificationUploaded => 'アップロードされました';

  @override
  String get verificationTapToUpload => 'タップしてアップロード';

  @override
  String get verificationRejectedBanner => 'あなたの書類は拒否されました。再提出してください。';

  @override
  String get verificationPendingBanner => 'あなたの書類は審査中です。お知らせいたします。';

  @override
  String get verificationSubmittedDocuments => '提出書類';

  @override
  String get verificationVerifiedTitle => '本人確認済み';

  @override
  String get verificationVerifiedSubtitle => 'あなたの身元は正常に確認されました。';

  @override
  String get verificationSuccessHeading => '提出書類';

  @override
  String get verificationSuccessBody =>
      '確認書類は正常に提出されました。私たちのチームがそれらを検討し、結果をお知らせします。';

  @override
  String get verificationSuccessInfoBanner => 'レビューには通常 1 ～ 3 営業日かかります。';

  @override
  String get verificationGoHome => 'ホームへ行く';

  @override
  String get marketplaceTitle => 'マーケットプレイス';

  @override
  String get marketplaceSearchHint => 'アプリを検索...';

  @override
  String get marketplaceEmptyTitle => '利用可能なアプリはありません';

  @override
  String get marketplaceEmptyMessage => '新しいアプリがないか、後でもう一度確認してください。';

  @override
  String get marketplaceViewDetails => '詳細を表示';

  @override
  String get appDetailsCouldNotOpenStore => 'ストアリンクを開けませんでした';

  @override
  String get appDetailsGooglePlay => 'Googleプレイ';

  @override
  String get appDetailsAppStore => 'アプリストア';

  @override
  String get appDetailsAbout => 'について';

  @override
  String get appDetailsAvailablePlans => '利用可能なプラン';

  @override
  String get appDetailsPromoUnavailable =>
      'アカウントが認証されると、プロモーション コードが利用可能になります。';

  @override
  String get appDetailsGenerateButton => '+ 生成';

  @override
  String get appDetailsFailedLoadPromoCodes => 'プロモーション コードの読み込みに失敗しました。';

  @override
  String get appDetailsGenerateHint => '「+ 生成」をタップして最初のコードを作成します。';

  @override
  String get appDetailsFailedGeneratePromo =>
      'プロモーション コードの生成に失敗しました。もう一度試してください。';

  @override
  String get appDetailsCopyTooltip => 'コピー';

  @override
  String get appDetailsFailedLoadUsage => '使用状況の読み込みに失敗しました。';

  @override
  String get appDetailsNoUsage => 'まだ使用されていません';

  @override
  String get appDetailsCreatePromoTitle => 'プロモーションコードの作成';

  @override
  String get appDetailsCreatePromoSubtitle =>
      'プロモーション コードのカスタム名を入力するか、空のままにして自動生成します。';

  @override
  String get appDetailsPromoNameLabel => 'プロモーション コード名 (オプション)';

  @override
  String get appDetailsPromoNameHint => '例: AHMED20 — 自動生成するには空のままにしておきます';

  @override
  String get appDetailsGenerate => '生成する';

  @override
  String get appDetailsPreview => 'プレビュー';

  @override
  String get appDetailsFree => '無料';

  @override
  String get walletTitle => '財布';

  @override
  String get walletTransactionHistory => '取引履歴';

  @override
  String get walletNoTransactions => 'まだ取引はありません';

  @override
  String get walletNoTransactionsMessage => 'ここに取引履歴が表示されます。';

  @override
  String get walletPayoutRequestsTitle => '支払いリクエスト';

  @override
  String get walletPayoutRequestsSubtitle => '支払いの表示と管理';

  @override
  String get payoutProfileSaved => '支払いプロファイルが保存されました!';

  @override
  String get payoutRequestSubmitted => '支払いリクエストが送信されました';

  @override
  String get payoutMethodTitle => '支払い方法';

  @override
  String get payoutPaymentDetailsTitle => 'お支払い詳細';

  @override
  String get payoutManageAccount => '支払いアカウントの管理';

  @override
  String get payoutHistorySection => '歴史';

  @override
  String get payoutNoRequests => 'まだ支払いリクエストはありません';

  @override
  String get payoutNoRequestsMessage => '支払いリクエストがここに表示されます。';

  @override
  String get payoutChooseMethod => 'お金の受け取り方法を選択してください。';

  @override
  String get payoutNoMethodsAvailable => '利用可能な支払い方法はありません';

  @override
  String get payoutInfoBanner => 'この情報は支払いプロファイルに保存され、今後のすべての出金に使用されます。';

  @override
  String get payoutSaveContinue => '保存して続行';

  @override
  String payoutAvailableAmount(String amount) {
    return '利用可能: $amount';
  }

  @override
  String get payoutChange => '変更';

  @override
  String get payoutAmountHint => '0.00';

  @override
  String get payoutMinimumHelper => '最低支払額は10ドルです';

  @override
  String get payoutSubmitRequest => 'リクエストの送信';

  @override
  String get payoutAmountLabel => '金額（米ドル）';

  @override
  String get paymentMethodsSaved => '支払いアカウントが保存されました!';

  @override
  String get paymentMethodsTitle => 'お支払い方法';

  @override
  String get paymentMethodsNoneAvailable => '利用できる支払い方法がありません';

  @override
  String get paymentMethodsChoose => '支払い方法を選択してください';

  @override
  String get paymentMethodsAll => 'すべてのメソッド';

  @override
  String get paymentMethodsActiveBadge => 'アクティブ';

  @override
  String get paymentMethodsSetUp => 'セットアップ';

  @override
  String paymentMethodsUpdateInfo(String methodName) {
    return '$methodName に保存されている支払いの詳細を更新します。';
  }

  @override
  String get paymentMethodsBecomeActiveInfo => 'これがアクティブな支払いアカウントになります。';

  @override
  String get paymentMethodsSetActiveButton => 'アクティブなアカウントとして設定';

  @override
  String get commissionsTitle => '手数料';

  @override
  String get commissionsTotalEarned => '獲得したコミッションの合計';

  @override
  String commissionsTransactionsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件の取引',
      one: '$count 件の取引',
    );
    return '$_temp0';
  }

  @override
  String get commissionsHistorySection => '委員会の歴史';

  @override
  String get commissionsEmptyTitle => 'まだコミッションはありません';

  @override
  String get commissionsEmptyMessage => '獲得したコミッションはここに表示されます。';

  @override
  String commissionsPromoCodeLabel(String code) {
    return 'プロモーションコード: $code';
  }

  @override
  String get commissionsDirectSale => '直販';

  @override
  String get referralsTitle => '紹介';

  @override
  String get referralsTotal => '合計紹介数';

  @override
  String get referralsTotalEarned => '獲得総額';

  @override
  String get referralsGenerateNew => '新しい紹介コードを生成する';

  @override
  String get referralsUnavailable => 'アカウントが認証されると、紹介リンクが利用可能になります。';

  @override
  String get referralsCodesSection => '紹介コード';

  @override
  String get referralsEmptyTitle => 'まだ紹介はありません';

  @override
  String get referralsEmptyMessage => 'コードを生成して共有すると、収入が得られます。';

  @override
  String get referralsCodeCopied => 'コードがコピーされました!';

  @override
  String referralsUsedBy(String user) {
    return '$user によって使用されます';
  }

  @override
  String get referralsNotUsedYet => 'まだ使用されていません';

  @override
  String referralsRegisteredOn(String date) {
    return '登録済み $date';
  }

  @override
  String get referralsLinkGeneratedTitle => '紹介リンクが生成されました';

  @override
  String get referralsShareSubtitle => 'コードまたはリンクを共有して収益を稼ぎましょう。';

  @override
  String get referralsCodeLabel => '紹介コード';

  @override
  String get referralsLinkLabel => '紹介リンク';

  @override
  String get referralsLinkCopied => 'リンクがコピーされました!';

  @override
  String get referralsActivityTitle => '参照されたユーザーのアクティビティ';

  @override
  String get referralsNoActivityData => 'アクティビティデータがありません';

  @override
  String get referralsActivityWillAppear => 'ユーザーがアクティブになると、アクティビティが表示されます。';

  @override
  String get referralsWindowSection => '紹介ウィンドウ';

  @override
  String referralsSubscriptionsCount(int count) {
    return 'サブスクリプション ($count)';
  }

  @override
  String referralsAppUsageEventsCount(int count) {
    return 'アプリ使用状況イベント ($count)';
  }

  @override
  String referralsPromoRedemptionsCount(int count) {
    return 'プロモーション特典 ($count)';
  }

  @override
  String get referralsNoActivityYet => 'まだ活動はありません';

  @override
  String referralsItemFallback(int index) {
    return 'アイテム $index';
  }

  @override
  String get supportTicketsTitle => 'サポートチケット';

  @override
  String get supportFilterAll => 'すべて';

  @override
  String get supportFilterOpen => '開く';

  @override
  String get supportFilterPending => '保留中';

  @override
  String get supportFilterClosed => '閉店';

  @override
  String get supportEmptyTitle => 'まだチケットはありません';

  @override
  String get supportEmptyMessage => '+ をタップして新しいサポート チケットを開きます。';

  @override
  String get newTicketTitle => '新しいチケット';

  @override
  String get newTicketSubmitted => 'チケットは正常に送信されました。';

  @override
  String get newTicketCategoryLabel => 'カテゴリ';

  @override
  String get newTicketPriorityLabel => '優先順位';

  @override
  String get newTicketSubjectLabel => '件名';

  @override
  String get newTicketSubjectRequired => '件名は必須です';

  @override
  String get newTicketMessageLabel => 'メッセージ';

  @override
  String get newTicketMessageRequired => 'メッセージは必須です';

  @override
  String get newTicketSubmitButton => 'チケットを送信する';

  @override
  String get newTicketCategoryTechnical => '技術的な';

  @override
  String get newTicketCategoryPayment => 'お支払い';

  @override
  String get newTicketPriorityNormal => 'ノーマル';

  @override
  String get newTicketPriorityHigh => '高';

  @override
  String get newTicketPriorityUrgent => '緊急';

  @override
  String get ticketDetailRefreshTooltip => 'リフレッシュ';

  @override
  String get ticketDetailNoReplies => 'まだ返信はありません。';

  @override
  String get ticketDetailTeamWillRespond => '私たちのチームがすぐに対応させていただきます。';

  @override
  String get ticketDetailReplyHint => '返信を入力してください...';

  @override
  String get ticketDetailClosed => 'このチケットはクローズされています。';

  @override
  String get agreementsTitle => '法的合意';

  @override
  String get agreementsAccepted => '同意が受け入れられました';

  @override
  String get agreementsAllAcceptedTitle => 'すべての合意が受け入れられました!';

  @override
  String get agreementsNoPending => '保留中の契約はありません。';

  @override
  String get agreementsAcceptedStatus => '承認されました';

  @override
  String get agreementsPendingStatus => '承認待ちです';

  @override
  String get agreementsCheckboxLabel => '上記の規約を読み、同意します';

  @override
  String get agreementsAcceptButton => '契約に同意する';

  @override
  String get knowledgeCenterTitle => 'ナレッジセンター';

  @override
  String get knowledgeCenterCategoryGettingStarted => 'はじめに';

  @override
  String get knowledgeCenterCategoryPayments => '支払い';

  @override
  String get knowledgeCenterCategoryAppsTools => 'アプリとツール';

  @override
  String get knowledgeCenterCategoryAccount => 'アカウント';

  @override
  String get knowledgeCenterEmptyTitle => 'まだ記事がありません';

  @override
  String get knowledgeCenterEmptyMessage => '新しいコンテンツについては、後でもう一度確認してください。';

  @override
  String get subscriptionPageStub => '定期購入ページ';
}
