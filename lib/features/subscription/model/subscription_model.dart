// GET /api/guide/subscriptions
class SubscriptionModel {
  final int id;
  final String appName;
  final String planName;
  final double price;
  final String status; // active | expired | cancelled
  final DateTime startsAt;
  final DateTime endsAt;

  SubscriptionModel({
    required this.id,
    required this.appName,
    required this.planName,
    required this.price,
    required this.status,
    required this.startsAt,
    required this.endsAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: (json['id'] as num).toInt(),
      appName: json['app_name'] as String,
      planName: json['plan_name'] as String,
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
    );
  }
}
