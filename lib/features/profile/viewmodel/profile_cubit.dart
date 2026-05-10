import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/profile/model/profile_model.dart';
import 'package:tourguide_app/features/profile/repository/i_profile_repository.dart';

// ---------- States ----------

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  ProfileLoaded(this.profile);
}

class ProfileUpdated extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class ProfileCubit extends Cubit<ProfileState> {
  final IProfileRepository _repository;

  ProfileCubit(this._repository) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await _repository.getProfile();
      emit(ProfileLoaded(profile));
    } on DioException catch (e) {
      emit(ProfileError(e.response?.data['message'] ?? 'Failed to load profile'));
    } catch (_) {
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    emit(ProfileLoading());
    try {
      await _repository.updateProfile(data);
      await loadProfile();
    } on DioException catch (e) {
      emit(ProfileError(e.response?.data['message'] ?? 'Failed to update profile'));
    } catch (_) {
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }

  Future<void> uploadPhoto(File photo) async {
    emit(ProfileLoading());
    try {
      await _repository.uploadPhoto(photo);
      await loadProfile(); // refresh after upload
    } on DioException catch (e) {
      emit(ProfileError(e.response?.data['message'] ?? 'Failed to upload photo'));
    } catch (_) {
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }

  Future<void> deleteAccount({String? reason}) async {
    emit(ProfileLoading());
    try {
      await _repository.deleteAccount(reason: reason);
      emit(ProfileUpdated());
    } on DioException catch (e) {
      emit(ProfileError(e.response?.data['message'] ?? 'Failed to delete account'));
    } catch (_) {
      emit(ProfileError('Something went wrong. Please try again.'));
    }
  }
}
