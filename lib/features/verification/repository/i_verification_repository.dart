import 'dart:io';
import 'package:tourguide_app/features/verification/model/verification_model.dart';

abstract class IVerificationRepository {
  Future<VerificationModel?> getStatus();

  Future<void> submit({
    required String passportNumber,
    required String nationalId,
    required String guideLicenseNumber,
    File? nationalIdFile,
    File? licenseFile,
  });
}
