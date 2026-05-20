import 'package:tourguide_app/features/marketplace/model/app_model.dart';

abstract class IMarketplaceRepository {
  Future<List<AppModel>?> getCachedApps();

  Future<List<AppModel>> getApps({String? search});

  Future<AppModel> getAppDetails(int appId);

  Future<PromoCodeModel> generatePromoCode({
    required int appId,
    String? code,
  });

  Future<List<PromoCodeModel>> getPromoCodes({required int appId});

  Future<List<PromoCodeModel>> getAllPromoCodes();

  Future<List<RedemptionModel>> getRedemptions({required int codeId});
}
