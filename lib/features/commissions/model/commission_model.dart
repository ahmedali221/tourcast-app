// GET /api/guide/commissions
class CommissionModel {
  final int id;
  final double amount;
  final String promoCode;
  final String redeemedBy;
  final DateTime earnedAt;

  CommissionModel({
    required this.id,
    required this.amount,
    required this.promoCode,
    required this.redeemedBy,
    required this.earnedAt,
  });

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    return CommissionModel(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      promoCode: json['promo_code'] as String,
      redeemedBy: json['redeemed_by'] as String,
      earnedAt: DateTime.parse(json['earned_at'] as String),
    );
  }
}
