import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/marketplace/model/app_model.dart';
import 'package:tourguide_app/features/marketplace/repository/i_marketplace_repository.dart';

// ---------- States ----------

abstract class HomePromoCodesState {}

class HomePromoCodesInitial extends HomePromoCodesState {}

class HomePromoCodesLoading extends HomePromoCodesState {}

class HomePromoCodesLoaded extends HomePromoCodesState {
  final List<PromoCodeModel> codes;
  final List<RedemptionModel> redemptions;
  HomePromoCodesLoaded(this.codes, this.redemptions);
}

class HomePromoCodesError extends HomePromoCodesState {}

// ---------- Cubit ----------

class HomePromoCodesCubit extends Cubit<HomePromoCodesState> {
  final IMarketplaceRepository _repository;

  HomePromoCodesCubit(this._repository) : super(HomePromoCodesInitial());

  Future<void> load() async {
    emit(HomePromoCodesLoading());
    try {
      final codesFuture = _repository.getAllPromoCodes();
      final redemptionsFuture = _repository.getRedemptions();
      final codes = await codesFuture;
      final redemptions = await redemptionsFuture;
      emit(HomePromoCodesLoaded(codes, redemptions));
    } on DioException catch (_) {
      emit(HomePromoCodesError());
    } catch (_) {
      emit(HomePromoCodesError());
    }
  }
}
