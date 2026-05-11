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
    if (isClosed) return;
    emit(ProfileLoading());
    try {
      final profile = await _repository.getProfile();
      if (!isClosed) emit(ProfileLoaded(profile));
    } on DioException catch (e) {
      if (!isClosed) emit(ProfileError(e.response?.data['message'] ?? 'Failed to load profile'));
    } catch (_) {
      if (!isClosed) emit(ProfileError('Something went wrong. Please try again.'));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    if (isClosed) return;
    emit(ProfileLoading());
    try {
      await _repository.updateProfile(data);
      await loadProfile();
    } on DioException catch (e) {
      if (!isClosed) emit(ProfileError(e.response?.data['message'] ?? 'Failed to update profile'));
    } catch (_) {
      if (!isClosed) emit(ProfileError('Something went wrong. Please try again.'));
    }
  }

  Future<void> uploadPhoto(File photo) async {
    if (isClosed) return;
    emit(ProfileLoading());
    try {
      await _repository.uploadPhoto(photo);
      await loadProfile();
    } on DioException catch (e) {
      if (!isClosed) emit(ProfileError(e.response?.data['message'] ?? 'Failed to upload photo'));
    } catch (_) {
      if (!isClosed) emit(ProfileError('Something went wrong. Please try again.'));
    }
  }

  Future<void> deleteAccount({String? reason}) async {
    if (isClosed) return;
    emit(ProfileLoading());
    try {
      await _repository.deleteAccount(reason: reason);
      if (!isClosed) emit(ProfileUpdated());
    } on DioException catch (e) {
      if (!isClosed) emit(ProfileError(e.response?.data['message'] ?? 'Failed to delete account'));
    } catch (_) {
      if (!isClosed) emit(ProfileError('Something went wrong. Please try again.'));
    }
  }
}
