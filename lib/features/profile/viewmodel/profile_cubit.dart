import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {}
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile() async {
    // TODO: implement load profile
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    // TODO: implement update profile
  }

  Future<void> uploadPhoto() async {
    // TODO: implement photo upload
  }
}
