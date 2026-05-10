import 'package:dio/dio.dart';
import 'package:tourguide_app/features/verification/model/verification_model.dart';
import 'package:tourguide_app/features/verification/repository/i_verification_repository.dart';

class VerificationRepository implements IVerificationRepository {
  final Dio _dio;

  VerificationRepository(this._dio);

  @override
  Future<VerificationModel?> getStatus() async {
    final response = await _dio.get('/guide/verification');
    if (response.data['data'] == null) return null;
    return VerificationModel.fromJson(response.data['data']);
  }

  @override
  Future<void> submit({
    required String passportNumber,
    required String nationalId,
    required String guideLicenseNumber,
    required List<String> documentUrls,
  }) async {
    await _dio.post('/guide/verification', data: {
      'passport_number': passportNumber,
      'national_id': nationalId,
      'guide_license_number': guideLicenseNumber,
      'document_urls': documentUrls,
    });
  }
}
