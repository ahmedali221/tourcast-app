import 'package:dio/dio.dart';
import 'package:tourguide_app/features/agreements/model/agreement_model.dart';
import 'package:tourguide_app/features/agreements/repository/i_agreements_repository.dart';

class AgreementsRepository implements IAgreementsRepository {
  final Dio _dio;

  AgreementsRepository(this._dio);

  @override
  Future<List<AgreementModel>> getPendingAgreements() async {
    final response = await _dio.get('/guide/agreements/pending');
    final list = response.data['data'] as List;
    return list.map((e) => AgreementModel.fromJson(e)).toList();
  }

  @override
  Future<void> acceptAgreement(int agreementId) async {
    await _dio.post('/guide/agreements/$agreementId/accept');
  }
}
