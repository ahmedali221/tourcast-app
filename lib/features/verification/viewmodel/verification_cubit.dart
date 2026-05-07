import 'package:flutter_bloc/flutter_bloc.dart';

abstract class VerificationState {}
class VerificationInitial extends VerificationState {}
class VerificationLoading extends VerificationState {}
class VerificationLoaded extends VerificationState {}
class VerificationError extends VerificationState {
  final String message;
  VerificationError(this.message);
}

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  Future<void> loadStatus() async {}
  Future<void> submitVerification(Map<String, dynamic> data) async {}
}
