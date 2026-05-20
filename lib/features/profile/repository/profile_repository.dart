import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tourguide_app/core/cache/cache_service.dart';
import 'package:tourguide_app/core/constants/storage_keys.dart';
import 'package:tourguide_app/features/profile/model/profile_model.dart';
import 'package:tourguide_app/features/profile/repository/i_profile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final Dio _dio;

  ProfileRepository(this._dio);

  @override
  Future<ProfileModel?> getCachedProfile() async {
    final data = await CacheService.get(
      StorageKeys.profileCache,
      ttl: CacheTTL.profile,
    );
    if (data == null) return null;
    return ProfileModel.fromJson(data);
  }

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _dio.get('/guide/profile');
    final data = response.data['data'] as Map<String, dynamic>;
    CacheService.set(StorageKeys.profileCache, data).ignore();
    return ProfileModel.fromJson(data);
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _dio.patch('/guide/profile', data: data);
  }

  @override
  Future<String> uploadPhoto(File photo) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        photo.path,
        filename: photo.path.split('/').last,
      ),
    });
    final response = await _dio.post('/guide/profile/photo', data: formData);
    return response.data['photo_url'] as String;
  }

  @override
  Future<void> deleteAccount({String? reason}) async {
    await _dio.delete('/guide/account', data: {'reason': reason});
  }
}
