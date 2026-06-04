// GET /api/guide/wallet
class WalletModel {
  final double balance;
  final List<TransactionModel> transactions;

  WalletModel({required this.balance, required this.transactions});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: num.parse(json['balance'].toString()).toDouble(),
      transactions: (json['transactions'] as List? ?? [])
          .map((t) => TransactionModel.fromJson(t as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TransactionModel {
  final int id;
  final String type;
  final double amount;
  final String status;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      amount: num.parse(json['amount'].toString()).toDouble(),
      status: json['status'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
