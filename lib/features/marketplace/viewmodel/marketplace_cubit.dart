import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/marketplace/model/app_model.dart';
import 'package:tourguide_app/features/marketplace/repository/i_marketplace_repository.dart';

// ---------- States ----------

abstract class MarketplaceState {}

class MarketplaceInitial extends MarketplaceState {}

class MarketplaceLoading extends MarketplaceState {}

class MarketplaceLoaded extends MarketplaceState {
  final List<AppModel> apps;
  MarketplaceLoaded(this.apps);
}

class MarketplaceDetailLoaded extends MarketplaceState {
  final AppModel app;
  MarketplaceDetailLoaded(this.app);
}

class MarketplaceError extends MarketplaceState {
  final String message;
  MarketplaceError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class MarketplaceCubit extends Cubit<MarketplaceState> {
  final IMarketplaceRepository _repository;

  MarketplaceCubit(this._repository) : super(MarketplaceInitial());

  Future<void> loadApps({String? search}) async {
    emit(MarketplaceLoading());
    try {
      final apps = await _repository.getApps(search: search);
      emit(MarketplaceLoaded(apps));
    } on DioException catch (e) {
      emit(MarketplaceError(e.response?.data['message'] ?? 'Failed to load apps'));
    } catch (_) {
      emit(MarketplaceError('Something went wrong. Please try again.'));
    }
  }

  Future<void> loadAppDetails(int appId) async {
    emit(MarketplaceLoading());
    try {
      final app = await _repository.getAppDetails(appId);
      emit(MarketplaceDetailLoaded(app));
    } on DioException catch (e) {
      emit(MarketplaceError(e.response?.data['message'] ?? 'Failed to load app details'));
    } catch (_) {
      emit(MarketplaceError('Something went wrong. Please try again.'));
    }
  }
}
