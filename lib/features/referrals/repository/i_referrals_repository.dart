import 'package:tourguide_app/features/referrals/model/referral_model.dart';

abstract class IReferralsRepository {
  Future<ReferralModel> getReferrals();
}
