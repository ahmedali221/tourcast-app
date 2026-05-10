import 'package:tourguide_app/features/marketplace/model/app_model.dart';

abstract class IMarketplaceRepository {
  Future<List<AppModel>> getApps({String? search});

  Future<AppModel> getAppDetails(int appId);
}
