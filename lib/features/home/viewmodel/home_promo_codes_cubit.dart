import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/marketplace/model/app_model.dart';
import 'package:tourguide_app/features/marketplace/repository/i_marketplace_repository.dart';

// ---------- States ----------

abstract class HomePromoCodesState {}

class HomePromoCodesInitial extends HomePromoCodesState {}

class HomePromoCodesLoading extends HomePromoCodesState {}

class HomePromoCodesLoaded extends HomePromoCodesState {
  final List<({AppModel app, List<PromoCodeModel> codes})> entries;
  HomePromoCodesLoaded(this.entries);
}

class HomePromoCodesError extends HomePromoCodesState {}

// ---------- Cubit ----------

class HomePromoCodesCubit extends Cubit<HomePromoCodesState> {
  final IMarketplaceRepository _repository;

  HomePromoCodesCubit(this._repository) : super(HomePromoCodesInitial());

  Future<void> load() async {
    emit(HomePromoCodesLoading());
    try {
      final apps = await _repository.getApps();
      final appsWithCodes = apps.where((a) => a.havePromoCode).toList();

      final entries = <({AppModel app, List<PromoCodeModel> codes})>[];
      for (final app in appsWithCodes) {
        final codes = await _repository.getPromoCodes(appId: app.id);
        if (codes.isNotEmpty) {
          entries.add((app: app, codes: codes));
        }
      }

      emit(HomePromoCodesLoaded(entries));
    } on DioException catch (_) {
      emit(HomePromoCodesError());
    } catch (_) {
      emit(HomePromoCodesError());
    }
  }
}
