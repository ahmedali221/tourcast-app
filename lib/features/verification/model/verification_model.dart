// GET /api/guide/verification
class VerificationModel {
  final String status; // PENDING | VERIFIED | REJECTED
  final String? rejectionReason;
  final String? passportNumber;
  final String? nationalId;
  final String? guideLicenseNumber;
  final List<String> documentUrls;

  VerificationModel({
    required this.status,
    this.rejectionReason,
    this.passportNumber,
    this.nationalId,
    this.guideLicenseNumber,
    required this.documentUrls,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      status: json['status'] as String,
      rejectionReason: json['rejection_reason'] as String?,
      passportNumber: json['passport_number'] as String?,
      nationalId: json['national_id'] as String?,
      guideLicenseNumber: json['guide_license_number'] as String?,
      documentUrls: List<String>.from(json['document_urls'] ?? []),
    );
  }
}
