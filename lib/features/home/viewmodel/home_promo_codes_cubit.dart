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
      final results = await Future.wait([
        _repository.getAllPromoCodes(),
        _repository.getApps(),
      ]);

      final allCodes = results[0] as List<PromoCodeModel>;
      final allApps = results[1] as List<AppModel>;

      if (allCodes.isEmpty) {
        emit(HomePromoCodesLoaded([]));
        return;
      }

      final appsById = {for (final a in allApps) a.id: a};

      // Group codes by appId, falling back to havePromoCode apps when appId is null.
      final Map<int, List<PromoCodeModel>> codesByApp = {};
      for (final code in allCodes) {
        final appId = code.appId;
        if (appId == null) continue;
        codesByApp.putIfAbsent(appId, () => []).add(code);
      }

      final entries = <({AppModel app, List<PromoCodeModel> codes})>[];
      for (final entry in codesByApp.entries) {
        final app = appsById[entry.key];
        if (app != null) {
          entries.add((app: app, codes: entry.value));
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
