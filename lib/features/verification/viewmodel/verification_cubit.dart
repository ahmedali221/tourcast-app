import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    emit(VerificationLoading());
    try {
      final verification = await _repository.getStatus();
      emit(VerificationLoaded(verification));
    } on DioException catch (e) {
      emit(VerificationError(e.response?.data['message'] ?? 'Failed to load status'));
    } catch (_) {
      emit(VerificationError('Something went wrong. Please try again.'));
    }
  }

  Future<void> submitVerification({
    required String passportNumber,
    required String nationalId,
    required String guideLicenseNumber,
    File? nationalIdFile,
    File? licenseFile,
  }) async {
    emit(VerificationLoading());
    try {
      await _repository.submit(
        passportNumber: passportNumber,
        nationalId: nationalId,
        guideLicenseNumber: guideLicenseNumber,
        nationalIdFile: nationalIdFile,
        licenseFile: licenseFile,
      );
      emit(VerificationSubmitted());
    } on DioException catch (e) {
      emit(VerificationError(e.response?.data['message'] ?? 'Submission failed'));
    } catch (_) {
      emit(VerificationError('Something went wrong. Please try again.'));
    }
  }
}
