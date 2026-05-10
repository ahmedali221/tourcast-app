import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/referrals/model/referral_model.dart';
import 'package:tourguide_app/features/referrals/repository/i_referrals_repository.dart';

// ---------- States ----------

abstract class ReferralsState {}

class ReferralsInitial extends ReferralsState {}

class ReferralsLoading extends ReferralsState {}

class ReferralsLoaded extends ReferralsState {
  final ReferralModel referrals;
  ReferralsLoaded(this.referrals);
}

class ReferralsError extends ReferralsState {
  final String message;
  ReferralsError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class ReferralsCubit extends Cubit<ReferralsState> {
  final IReferralsRepository _repository;

  ReferralsCubit(this._repository) : super(ReferralsInitial());

  Future<void> loadReferrals() async {
    emit(ReferralsLoading());
    try {
      final referrals = await _repository.getReferrals();
      emit(ReferralsLoaded(referrals));
    } on DioException catch (e) {
      emit(ReferralsError(e.response?.data['message'] ?? 'Failed to load referrals'));
    } catch (_) {
      emit(ReferralsError('Something went wrong. Please try again.'));
    }
  }
}
