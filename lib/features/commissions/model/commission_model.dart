// GET /api/guide/commissions
class CommissionModel {
  final int id;
  final double amount;
  final double baseAmount;
  final num commissionPercent;
  final String status;
  final String source;
  final String? promoCode;
  final DateTime createdAt;

  CommissionModel({
    required this.id,
    required this.amount,
    required this.baseAmount,
    required this.commissionPercent,
    required this.status,
    required this.source,
    this.promoCode,
    required this.createdAt,
  });

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    return CommissionModel(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      baseAmount: (json['base_amount'] as num? ?? 0).toDouble(),
      commissionPercent: json['commission_percent'] as num? ?? 0,
      status: json['status'] as String? ?? '',
      source: json['source'] as String? ?? '',
      promoCode: json['promo_code'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
