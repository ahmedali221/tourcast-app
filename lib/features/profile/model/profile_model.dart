// GET /api/guide/profile
class ProfileModel {
  final int id;
  final String fullName;
  final String email;
  final String? photoUrl;
  final String? country;
  final String? city;
  final List<String> languages;
  final List<String> specializations;
  final int? yearsOfExperience;
  final String? bio;
  final double? rating;
  final int completenessPercent;
  final String verificationStatus; // PENDING | VERIFIED | REJECTED
  final String? rejectionReason;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.photoUrl,
    this.country,
    this.city,
    required this.languages,
    required this.specializations,
    this.yearsOfExperience,
    this.bio,
    this.rating,
    required this.completenessPercent,
    required this.verificationStatus,
    this.rejectionReason,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final p = (json['profile'] as Map?)?.cast<String, dynamic>() ?? {};
    return ProfileModel(
      id: (json['id'] as num).toInt(),
      fullName: p['full_name'] as String? ?? json['name'] as String? ?? '',
      email: json['email'] as String,
      photoUrl: p['photo_url'] as String?,
      country: p['country'] as String?,
      city: p['city'] as String?,
      languages: List<String>.from(p['languages'] ?? []),
      specializations: List<String>.from(p['specializations'] ?? []),
      yearsOfExperience: (p['years_of_experience'] as num?)?.toInt(),
      bio: p['bio'] as String?,
      rating: (p['rating'] as num?)?.toDouble(),
      completenessPercent: (p['profile_completeness_score'] as num?)?.toInt() ?? 0,
      verificationStatus: (p['verification_status'] ?? json['verification_status']) as String? ?? 'PENDING',
      rejectionReason: p['rejection_reason'] as String?,
    );
  }
}
