import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/commissions/model/commission_model.dart';
import 'package:tourguide_app/features/commissions/repository/i_commissions_repository.dart';

// ---------- States ----------

abstract class CommissionsState {}

class CommissionsInitial extends CommissionsState {}

class CommissionsLoading extends CommissionsState {}

class CommissionsLoaded extends CommissionsState {
  final List<CommissionModel> commissions;
  CommissionsLoaded(this.commissions);
}

class CommissionsError extends CommissionsState {
  final String message;
  CommissionsError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class CommissionsCubit extends Cubit<CommissionsState> {
  final ICommissionsRepository _repository;

  CommissionsCubit(this._repository) : super(CommissionsInitial());

  Future<void> loadCommissions({int page = 1}) async {
    emit(CommissionsLoading());
    try {
      final commissions = await _repository.getCommissions(page: page);
      emit(CommissionsLoaded(commissions));
    } on DioException catch (e) {
      emit(CommissionsError(e.response?.data['message'] ?? 'Failed to load commissions'));
    } catch (_) {
      emit(CommissionsError('Something went wrong. Please try again.'));
    }
  }
}
