// GET /api/guide/payout-methods
class PayoutMethodModel {
  final int id;
  final String name;
  final String? description;
  final List<PayoutFieldSchema> fieldSchema;

  PayoutMethodModel({
    required this.id,
    required this.name,
    this.description,
    required this.fieldSchema,
  });

  factory PayoutMethodModel.fromJson(Map<String, dynamic> json) {
    final schema = (json['field_schema'] as List? ?? [])
        .map((f) => PayoutFieldSchema.fromJson(f as Map<String, dynamic>))
        .toList();
    return PayoutMethodModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      fieldSchema: schema,
    );
  }
}

class PayoutFieldSchema {
  final String key;
  final String label;
  final String type; // text | number | phone | iban etc.
  final bool required;

  PayoutFieldSchema({
    required this.key,
    required this.label,
    required this.type,
    required this.required,
  });

  factory PayoutFieldSchema.fromJson(Map<String, dynamic> json) {
    return PayoutFieldSchema(
      key: json['key'] as String,
      label: json['label'] as String,
      type: json['type'] as String? ?? 'text',
      required: json['required'] as bool? ?? false,
    );
  }
}

// GET /api/guide/payout-profile
class PayoutProfileModel {
  final int payoutMethodId;
  final String methodName;
  final Map<String, dynamic> details;

  PayoutProfileModel({
    required this.payoutMethodId,
    required this.methodName,
    required this.details,
  });

  factory PayoutProfileModel.fromJson(Map<String, dynamic> json) {
    final method = json['payout_method'] as Map<String, dynamic>? ?? {};
    return PayoutProfileModel(
      payoutMethodId: (method['id'] as num).toInt(),
      methodName: method['name'] as String? ?? '',
      details: json['details'] as Map<String, dynamic>? ?? {},
    );
  }
}
