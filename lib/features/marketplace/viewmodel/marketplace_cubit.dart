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
    if (isClosed) return;

    // Cache only applies to full catalog (not search results).
    final bool useCache = search == null || search.isEmpty;
    List<AppModel>? cached;

    if (useCache) {
      cached = await _repository.getCachedApps();
    }

    if (!isClosed) {
      if (cached != null) {
        emit(MarketplaceLoaded(cached));
      } else {
        emit(MarketplaceLoading());
      }
    }

    // Always refresh from network in the background.
    try {
      final apps = await _repository.getApps(search: search);
      if (!isClosed) emit(MarketplaceLoaded(apps));
    } on DioException catch (e) {
      if (cached == null && !isClosed) {
        emit(MarketplaceError(e.response?.data['message'] ?? 'Failed to load apps'));
      }
    } catch (_) {
      if (cached == null && !isClosed) {
        emit(MarketplaceError('Something went wrong. Please try again.'));
      }
    }
  }

  Future<void> loadAppDetails(int appId) async {
    if (isClosed) return;
    emit(MarketplaceLoading());
    try {
      final app = await _repository.getAppDetails(appId);
      if (!isClosed) emit(MarketplaceDetailLoaded(app));
    } on DioException catch (e) {
      if (!isClosed) emit(MarketplaceError(e.response?.data['message'] ?? 'Failed to load app details'));
    } catch (_) {
      if (!isClosed) emit(MarketplaceError('Something went wrong. Please try again.'));
    }
  }
}
