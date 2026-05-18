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

  @override
  Future<PromoCodeModel> generatePromoCode({
    required int appId,
    required String discountType,
    required num discountValue,
  }) async {
    final response = await _dio.post('/affiliate/promo-codes', data: {
      'app_id': appId,
      'discount_type': discountType,
      'discount_value': discountValue,
    });
    return PromoCodeModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<PromoCodeModel>> getPromoCodes({required int appId}) async {
    final response = await _dio.get('/affiliate/promo-codes', queryParameters: {'app_id': appId});
    return (response.data['data'] as List? ?? [])
        .map((e) => PromoCodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<RedemptionModel>> getRedemptions({required int codeId}) async {
    final response = await _dio.get('/affiliate/redemptions', queryParameters: {'promo_code_id': codeId});
    return (response.data['data'] as List? ?? [])
        .map((e) => RedemptionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
