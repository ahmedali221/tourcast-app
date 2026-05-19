import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tourguide_app/core/cache/cache_service.dart';
import 'package:tourguide_app/core/constants/storage_keys.dart';
import 'package:tourguide_app/features/verification/model/verification_model.dart';
import 'package:tourguide_app/features/verification/repository/i_verification_repository.dart';

class VerificationRepository implements IVerificationRepository {
  final Dio _dio;

  VerificationRepository(this._dio);

  @override
  Future<VerificationModel?> getCachedStatus() async {
    final data = await CacheService.get(
      StorageKeys.verificationCache,
      ttl: CacheTTL.verification,
    );
    if (data == null) return null;
    return VerificationModel.fromJson(data);
  }

  @override
  Future<VerificationModel?> getStatus() async {
    final response = await _dio.get('/guide/verification');
    if (response.data['data'] == null) return null;
    final data = response.data['data'] as Map<String, dynamic>;
    CacheService.set(StorageKeys.verificationCache, data).ignore();
    return VerificationModel.fromJson(data);
  }

  @override
  Future<void> submit({
    required String passportNumber,
    required String nationalId,
    required String guideLicenseNumber,
    File? nationalIdFile,
    File? licenseFile,
  }) async {
    final formData = FormData.fromMap({
      'passport_number': passportNumber,
      'national_id': nationalId,
      'guide_license_number': guideLicenseNumber,
      if (nationalIdFile != null)
        'national_id_photo': await MultipartFile.fromFile(
          nationalIdFile.path,
          filename: nationalIdFile.uri.pathSegments.last,
        ),
      if (licenseFile != null)
        'guide_license': await MultipartFile.fromFile(
          licenseFile.path,
          filename: licenseFile.uri.pathSegments.last,
        ),
    });
    await _dio.post('/guide/verification', data: formData);
  }
}
