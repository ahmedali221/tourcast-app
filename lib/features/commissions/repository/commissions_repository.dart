import 'package:dio/dio.dart';
import 'package:tourguide_app/features/commissions/model/commission_model.dart';
import 'package:tourguide_app/features/commissions/repository/i_commissions_repository.dart';

class CommissionsRepository implements ICommissionsRepository {
  final Dio _dio;

  CommissionsRepository(this._dio);

  @override
  Future<List<CommissionModel>> getCommissions({int page = 1}) async {
    final response = await _dio.get('/guide/commissions', queryParameters: {'page': page});
    final list = response.data['data'] as List;
    return list.map((e) => CommissionModel.fromJson(e)).toList();
  }
}
