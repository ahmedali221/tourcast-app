// GET /api/guide/referrals
class ReferralModel {
  final String referralCode;
  final String referralLink;
  final int totalReferred;
  final double totalEarned;
  final List<ReferredUserModel> referredUsers;

  ReferralModel({
    required this.referralCode,
    required this.referralLink,
    required this.totalReferred,
    required this.totalEarned,
    required this.referredUsers,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      referralCode: json['referral_code'] as String,
      referralLink: json['referral_link'] as String,
      totalReferred: json['total_referred'] as int? ?? 0,
      totalEarned: (json['total_earned'] as num?)?.toDouble() ?? 0,
      referredUsers: (json['referred_users'] as List? ?? [])
          .map((u) => ReferredUserModel.fromJson(u as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ReferredUserModel {
  final String name;
  final DateTime joinedAt;

  ReferredUserModel({required this.name, required this.joinedAt});

  factory ReferredUserModel.fromJson(Map<String, dynamic> json) {
    return ReferredUserModel(
      name: json['name'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
    );
  }
}
