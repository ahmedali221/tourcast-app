import 'package:dio/dio.dart';
import 'package:tourguide_app/features/referrals/model/referral_model.dart';
import 'package:tourguide_app/features/referrals/repository/i_referrals_repository.dart';

class ReferralsRepository implements IReferralsRepository {
  final Dio _dio;

  ReferralsRepository(this._dio);

  @override
  Future<ReferralModel> getReferrals() async {
    final response = await _dio.get('/guide/referrals');
    final list = (response.data['data'] as List? ?? [])
        .map((e) => ReferralEntryModel.fromJson(e as Map<String, dynamic>))
        .toList();
    final meta = response.data['meta'] as Map<String, dynamic>? ?? {};
    final total = (meta['total'] as num?)?.toInt() ?? list.length;
    return ReferralModel(entries: list, total: total);
  }

  @override
  Future<GeneratedReferralResult> generateReferralLink() async {
    final response = await _dio.post('/guide/referral-link');
    final data = response.data as Map<String, dynamic>? ?? {};
    final referrals = await getReferrals();
    return GeneratedReferralResult(
      referrals: referrals,
      referralLink: data['referral_link'] as String?,
      referralCode: data['referral_code'] as String?,
    );
  }

  @override
  Future<ReferralActivityModel> getReferralActivity(int referralId) async {
    final response = await _dio.get('/guide/referrals/$referralId/activity');
    return ReferralActivityModel.fromJson(
      response.data as Map<String, dynamic>? ?? {},
    );
  }
}
