// GET /api/guide/applications
class AppModel {
  final int id;
  final String name;
  final String description;
  final String? iconUrl;
  final String? category;
  final String status;
  final List<PlanModel> plans;

  AppModel({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
    this.category,
    required this.status,
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
