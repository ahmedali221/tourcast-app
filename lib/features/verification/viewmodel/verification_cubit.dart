import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/core/cache/cache_service.dart';
import 'package:tourguide_app/core/constants/storage_keys.dart';
import 'package:tourguide_app/core/storage/app_storage.dart';
import 'package:tourguide_app/features/verification/model/verification_model.dart';
import 'package:tourguide_app/features/verification/repository/i_verification_repository.dart';

// ---------- States ----------

abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationLoaded extends VerificationState {
  final VerificationModel? verification; // null means not submitted yet
  VerificationLoaded(this.verification);
}

class VerificationSubmitted extends VerificationState {}

class VerificationError extends VerificationState {
  final String message;
  VerificationError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class VerificationCubit extends Cubit<VerificationState> {
  final IVerificationRepository _repository;

  VerificationCubit(this._repository) : super(VerificationInitial());

  Future<void> loadStatus() async {
    if (isClosed) return;

    // Show cached status immediately — eliminates PENDING → VERIFIED flicker.
    final cached = await _repository.getCachedStatus();
    if (!isClosed) {
      if (cached != null) {
        emit(VerificationLoaded(cached));
      } else {
        emit(VerificationLoading());
      }
    }

    // Always refresh from network in the background.
    try {
      final verification = await _repository.getStatus();
      if (verification?.status != null) {
        await AppStorage.saveVerificationStatus(verification!.status);
      }
      if (!isClosed) emit(VerificationLoaded(verification));
    } on DioException catch (e) {
      if (cached == null && !isClosed) {
        emit(VerificationError(e.response?.data['message'] ?? 'Failed to load status'));
      }
    } catch (_) {
      if (cached == null && !isClosed) {
        emit(VerificationError('Something went wrong. Please try again.'));
      }
    }
  }

  Future<void> submitVerification({
    required String passportNumber,
    required String nationalId,
    required String guideLicenseNumber,
    File? nationalIdFrontFile,
    File? nationalIdBackFile,
    File? licenseFile,
  }) async {
    if (isClosed) return;
    emit(VerificationLoading());
    try {
      await _repository.submit(
        passportNumber: passportNumber,
        nationalId: nationalId,
        guideLicenseNumber: guideLicenseNumber,
        nationalIdFrontFile: nationalIdFrontFile,
        nationalIdBackFile: nationalIdBackFile,
        licenseFile: licenseFile,
      );
      // Stale cache would show old status — invalidate so next loadStatus fetches fresh.
      await CacheService.invalidate(StorageKeys.verificationCache);
      if (!isClosed) emit(VerificationSubmitted());
    } on DioException catch (e) {
      if (!isClosed) emit(VerificationError(e.response?.data['message'] ?? 'Submission failed'));
    } catch (_) {
      if (!isClosed) emit(VerificationError('Something went wrong. Please try again.'));
    }
  }
}
