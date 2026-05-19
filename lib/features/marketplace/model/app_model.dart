// GET /api/affiliate/promo-codes
class PromoCodeModel {
  final int id;
  final String code;
  final String discountType;
  final num discountValue;
  final int? maxUses;
  final int usedCount;
  final bool singleUsePerUser;

  PromoCodeModel({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    this.maxUses,
    required this.usedCount,
    required this.singleUsePerUser,
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
    );
  }

  String get discountLabel => discountType == 'percent'
      ? '${discountValue.toStringAsFixed(0)}%'
      : '${discountValue.toStringAsFixed(0)} USD';
}

// GET /api/affiliate/redemptions
class RedemptionModel {
  final String userName;
  final String? project;
  final num commissionBase;
  final DateTime redeemedAt;

  RedemptionModel({
    required this.userName,
    this.project,
    required this.commissionBase,
    required this.redeemedAt,
  });

  factory RedemptionModel.fromJson(Map<String, dynamic> json) {
    final user = json['redeemed_by_user'];
    final proj = json['project'];
    return RedemptionModel(
      userName: (user is Map ? user['name'] : null) as String? ?? 'Unknown',
      project: (proj is Map ? proj['name'] : null) as String?,
      commissionBase: json['commission_base'] as num? ?? 0,
      redeemedAt: DateTime.parse(json['redeemed_at'] as String),
    );
  }
}

// GET /api/guide/applications
class AppModel {
  final int id;
  final String name;
  final String description;
  final String? iconUrl;
  final String? category;
  final String status;
  final bool havePromoCode;
  final String? discountType;
  final num? discountValue;
  final List<PlanModel> plans;

  AppModel({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
    this.category,
    required this.status,
    required this.havePromoCode,
    this.discountType,
    this.discountValue,
    required this.plans,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['short_description'] as String? ?? '',
      iconUrl: json['icon_url'] as String?,
      category: json['category'] as String?,
      status: json['status'] as String? ?? '',
      havePromoCode: json['have_promo_code'] as bool? ?? false,
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as num?,
      plans: (json['plans'] as List? ?? [])
          .map((p) => PlanModel.fromJson(p as Map<String, dynamic>))
          .toList(),
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
