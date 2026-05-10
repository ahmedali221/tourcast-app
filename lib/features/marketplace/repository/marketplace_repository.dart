import 'package:dio/dio.dart';
import 'package:tourguide_app/features/marketplace/model/app_model.dart';
import 'package:tourguide_app/features/marketplace/repository/i_marketplace_repository.dart';

class MarketplaceRepository implements IMarketplaceRepository {
  final Dio _dio;

  MarketplaceRepository(this._dio);

  @override
  Future<List<AppModel>> getApps({String? search}) async {
    final response = await _dio.get('/guide/applications', queryParameters: {
      if (search != null && search.isNotEmpty) 'search': search,
    });
    final list = response.data['data'] as List;
    return list.map((e) => AppModel.fromJson(e)).toList();
  }

  @override
  Future<AppModel> getAppDetails(int appId) async {
    final response = await _dio.get('/guide/applications/$appId');
    return AppModel.fromJson(response.data['data']);
  }
}
