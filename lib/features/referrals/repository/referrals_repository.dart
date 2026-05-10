import 'package:dio/dio.dart';
import 'package:tourguide_app/features/referrals/model/referral_model.dart';
import 'package:tourguide_app/features/referrals/repository/i_referrals_repository.dart';

class ReferralsRepository implements IReferralsRepository {
  final Dio _dio;

  ReferralsRepository(this._dio);

  @override
  Future<ReferralModel> getReferrals() async {
    final response = await _dio.get('/guide/referrals');
    final data = response.data['data'];

    // API returns a paginated list of referred users (not a summary object).
    if (data is List) {
      final meta = response.data['meta'] as Map<String, dynamic>? ?? {};
      return ReferralModel(
        referralCode: '',
        referralLink: '',
        totalReferred: (meta['total'] as num?)?.toInt() ?? data.length,
        totalEarned: 0,
        referredUsers: data
            .map((u) => ReferredUserModel.fromJson(u as Map<String, dynamic>))
            .toList(),
      );
    }

    return ReferralModel.fromJson(data as Map<String, dynamic>);
  }
}
