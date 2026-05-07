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
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      photoUrl: json['photo_url'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      languages: List<String>.from(json['languages'] ?? []),
      specializations: List<String>.from(json['specializations'] ?? []),
      yearsOfExperience: json['years_of_experience'] as int?,
      bio: json['bio'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      completenessPercent: json['completeness_percent'] as int? ?? 0,
      verificationStatus: json['verification_status'] as String? ?? 'PENDING',
    );
  }
}
