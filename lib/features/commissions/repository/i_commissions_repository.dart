import 'package:tourguide_app/features/commissions/model/commission_model.dart';

abstract class ICommissionsRepository {
  Future<List<CommissionModel>> getCommissions({int page = 1});
}
