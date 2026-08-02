
// GET /api/affiliate/redemptions
class RedemptionModel {
  final String promoCode;
  final String userName;
  final String userEmail;
  final String project;
  final num originalPrice;
  final num discountedPrice;
  final num commissionBase;
  final DateTime redeemedAt;

  RedemptionModel({
    required this.promoCode,
    required this.userName,
    required this.userEmail,
    required this.project,
    required this.originalPrice,
    required this.discountedPrice,
    required this.commissionBase,
    required this.redeemedAt,
  });

  factory RedemptionModel.fromJson(Map<String, dynamic> json) {
    final user = json['redeemed_by_user'] as Map<String, dynamic>?;
    final project = json['project'] as Map<String, dynamic>?;
    return RedemptionModel(
      promoCode: json['promo_code'] as String? ?? '',
      userName: user?['name'] as String? ?? 'Unknown',
      userEmail: user?['email'] as String? ?? '',
      project: project?['name'] as String? ?? '',
      originalPrice: json['original_price'] as num? ?? 0,
      discountedPrice: json['discounted_price'] as num? ?? 0,
      commissionBase: json['commission_base'] as num? ?? 0,
      redeemedAt: DateTime.parse(json['redeemed_at'] as String),
    );
  }
}

// GET /api/affiliate/promo-codes
class PromoCodeModel {
  final int id;
  final String code;
  final String discountType;
  final num discountValue;
  final int? maxUses;
  final int usedCount;
  final bool singleUsePerUser;
  final String appName;

  PromoCodeModel({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    this.maxUses,
    required this.usedCount,
    required this.singleUsePerUser,
    this.appName = 'App',
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      discountType: json['discount_type'] as String,
      discountValue: json['discount_value'] as num,
      maxUses: (json['max_uses'] as num?)?.toInt(),
      usedCount: (json['used_count'] as num? ?? 0).toInt(),
      singleUsePerUser: json['single_use_per_user'] as bool? ?? false,
      appName: json['app_name'] as String? ?? 'App',
    );
  }

  String get discountLabel => discountType == 'percent'
      ? '${discountValue.toStringAsFixed(0)}%'
      : '${discountValue.toStringAsFixed(0)} USD';
}

// GET /api/guide/applications
class AppModel {
  final int id;
  final String name;
  final String description;
  final String? fullDescription;
  final String? iconUrl;
  final String? videoUrl;
  final String? category;
  final String status;
  final bool havePromoCode;
  final String? discountType;
  final num? discountValue;
  final List<PlanModel> plans;
  final String? androidUrl;
  final String? iosUrl;

  AppModel({
    required this.id,
    required this.name,
    required this.description,
    this.fullDescription,
    this.iconUrl,
    this.videoUrl,
    this.category,
    required this.status,
    required this.havePromoCode,
    this.discountType,
    this.discountValue,
    required this.plans,
    this.androidUrl,
    this.iosUrl,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['short_description'] as String? ?? '',
      fullDescription: json['description'] as String?,
      iconUrl: json['icon_url'] as String?,
      videoUrl: json['video_url'] as String?,
      category: json['category'] as String?,
      status: json['status'] as String? ?? '',
      havePromoCode: json['have_promo_code'] as bool? ?? false,
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as num?,
      plans: (json['plans'] as List? ?? [])
          .map((p) => PlanModel.fromJson(p as Map<String, dynamic>))
          .toList(),
      androidUrl: json['google_play_store_url'] as String?,
      iosUrl: json['apple_store_url'] as String?,
    );
  }
}

class PlanModel {
  final int id;
  final String name;
  final double price;
  final String currency;
  final String planType;
  final int? durationDays;

  PlanModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.planType,
    this.durationDays,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      planType: json['plan_type'] as String? ?? '',
      durationDays: (json['duration_days'] as num?)?.toInt(),
    );
  }
}
