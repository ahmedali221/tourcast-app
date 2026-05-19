import 'dart:io';
import 'package:tourguide_app/features/profile/model/profile_model.dart';

abstract class IProfileRepository {
  Future<ProfileModel?> getCachedProfile();

  Future<ProfileModel> getProfile();

  Future<void> updateProfile(Map<String, dynamic> data);

  Future<String> uploadPhoto(File photo); // returns new photo URL

  Future<void> deleteAccount({String? reason});
}
