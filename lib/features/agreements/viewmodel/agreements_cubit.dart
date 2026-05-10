import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/agreements/model/agreement_model.dart';
import 'package:tourguide_app/features/agreements/repository/i_agreements_repository.dart';

// ---------- States ----------

abstract class AgreementsState {}

class AgreementsInitial extends AgreementsState {}

class AgreementsLoading extends AgreementsState {}

class AgreementsLoaded extends AgreementsState {
  final List<AgreementModel> agreements;
  AgreementsLoaded(this.agreements);
}

class AgreementAccepted extends AgreementsState {}

class AgreementsError extends AgreementsState {
  final String message;
  AgreementsError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class AgreementsCubit extends Cubit<AgreementsState> {
  final IAgreementsRepository _repository;

  AgreementsCubit(this._repository) : super(AgreementsInitial());

  Future<void> loadPendingAgreements() async {
    emit(AgreementsLoading());
    try {
      final agreements = await _repository.getPendingAgreements();
      emit(AgreementsLoaded(agreements));
    } on DioException catch (e) {
      emit(AgreementsError(e.response?.data['message'] ?? 'Failed to load agreements'));
    } catch (_) {
      emit(AgreementsError('Something went wrong. Please try again.'));
    }
  }

  Future<void> acceptAgreement(int agreementId) async {
    emit(AgreementsLoading());
    try {
      await _repository.acceptAgreement(agreementId);
      emit(AgreementAccepted());
      await loadPendingAgreements();
    } on DioException catch (e) {
      emit(AgreementsError(e.response?.data['message'] ?? 'Failed to accept agreement'));
    } catch (_) {
      emit(AgreementsError('Something went wrong. Please try again.'));
    }
  }
}
