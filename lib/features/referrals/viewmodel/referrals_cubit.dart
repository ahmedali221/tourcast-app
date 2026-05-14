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

class ReferralsGenerating extends ReferralsState {
  final ReferralModel referrals;
  ReferralsGenerating(this.referrals);
}

class ReferralLinkGenerated extends ReferralsState {
  final ReferralModel referrals;
  final String referralLink;
  final String referralCode;
  ReferralLinkGenerated({
    required this.referrals,
    required this.referralLink,
    required this.referralCode,
  });
}

class ReferralActivityLoading extends ReferralsState {
  final ReferralModel referrals;
  ReferralActivityLoading(this.referrals);
}

class ReferralActivityLoaded extends ReferralsState {
  final ReferralModel referrals;
  final ReferralActivityModel activity;
  final int referralId;
  ReferralActivityLoaded({
    required this.referrals,
    required this.activity,
    required this.referralId,
  });
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

  Future<void> generateReferralLink() async {
    final current = _currentReferrals;
    if (current != null) emit(ReferralsGenerating(current));
    try {
      final result = await _repository.generateReferralLink();
      if (result.referralLink != null && result.referralCode != null) {
        emit(ReferralLinkGenerated(
          referrals: result.referrals,
          referralLink: result.referralLink!,
          referralCode: result.referralCode!,
        ));
      } else {
        emit(ReferralsLoaded(result.referrals));
      }
    } on DioException catch (e) {
      if (current != null) emit(ReferralsLoaded(current));
      await Future.microtask(
        () => emit(ReferralsError(e.response?.data['message'] ?? 'Failed to generate referral link')),
      );
    } catch (_) {
      if (current != null) emit(ReferralsLoaded(current));
      await Future.microtask(
        () => emit(ReferralsError('Something went wrong. Please try again.')),
      );
    }
  }

  Future<void> loadReferralActivity(int referralId) async {
    final current = _currentReferrals;
    if (current != null) emit(ReferralActivityLoading(current));
    try {
      final activity = await _repository.getReferralActivity(referralId);
      final referrals = current ?? await _repository.getReferrals();
      emit(ReferralActivityLoaded(referrals: referrals, activity: activity, referralId: referralId));
    } on DioException catch (e) {
      if (current != null) emit(ReferralsLoaded(current));
      await Future.microtask(
        () => emit(ReferralsError(e.response?.data['message'] ?? 'Failed to load activity')),
      );
    } catch (_) {
      if (current != null) emit(ReferralsLoaded(current));
      await Future.microtask(
        () => emit(ReferralsError('Something went wrong. Please try again.')),
      );
    }
  }

  ReferralModel? get _currentReferrals => switch (state) {
        ReferralsLoaded s => s.referrals,
        ReferralsGenerating s => s.referrals,
        ReferralActivityLoading s => s.referrals,
        ReferralActivityLoaded s => s.referrals,
        ReferralLinkGenerated s => s.referrals,
        _ => null,
      };
}
