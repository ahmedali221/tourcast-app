// GET /api/guide/referrals
class ReferralEntryModel {
  final int id;
  final String referralCode;
  final String? referredUser;
  final double rewardAmount;
  final String status; // INVITED | REGISTERED | COMPLETED | etc.
  final DateTime? referredAt; // only present when status == REGISTERED
  final DateTime createdAt;

  ReferralEntryModel({
    required this.id,
    required this.referralCode,
    this.referredUser,
    required this.rewardAmount,
    required this.status,
    this.referredAt,
    required this.createdAt,
  });

  factory ReferralEntryModel.fromJson(Map<String, dynamic> json) {
    return ReferralEntryModel(
      id: (json['id'] as num).toInt(),
      referralCode: json['referral_code'] as String,
      referredUser: json['referred_user'] as String?,
      rewardAmount: (json['reward_amount'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'INVITED',
      referredAt: json['referred_at'] != null
          ? DateTime.tryParse(json['referred_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

// GET /api/guide/referrals/{referralId}/activity
class ReferralActivityModel {
  final Map<String, dynamic> windowMetadata;
  final List<Map<String, dynamic>> subscriptions;
  final List<Map<String, dynamic>> appUsageEvents;
  final List<Map<String, dynamic>> promoRedemptions;

  ReferralActivityModel({
    required this.windowMetadata,
    required this.subscriptions,
    required this.appUsageEvents,
    required this.promoRedemptions,
  });

  factory ReferralActivityModel.fromJson(Map<String, dynamic> json) {
    return ReferralActivityModel(
      windowMetadata: json['window_metadata'] as Map<String, dynamic>? ?? {},
      subscriptions: (json['subscriptions'] as List? ?? [])
          .cast<Map<String, dynamic>>(),
      appUsageEvents: (json['app_usage_events'] as List? ?? [])
          .cast<Map<String, dynamic>>(),
      promoRedemptions: (json['promo_redemptions'] as List? ?? [])
          .cast<Map<String, dynamic>>(),
    );
  }
}

// Aggregated view used by the page
class ReferralModel {
  final List<ReferralEntryModel> entries;
  final int total;

  ReferralModel({required this.entries, required this.total});

  double get totalEarned =>
      entries.fold(0, (sum, e) => sum + e.rewardAmount);

  int get totalReferred => total;
}
