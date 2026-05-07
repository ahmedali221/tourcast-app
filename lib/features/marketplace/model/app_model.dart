// GET /api/guide/apps
class AppModel {
  final int id;
  final String name;
  final String description;
  final String? iconUrl;
  final List<PlanModel> plans;

  AppModel({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
    required this.plans,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['icon_url'] as String?,
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
  final String billingCycle; // monthly | yearly

  PlanModel({
    required this.id,
    required this.name,
    required this.price,
    required this.billingCycle,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      billingCycle: json['billing_cycle'] as String,
    );
  }
}
