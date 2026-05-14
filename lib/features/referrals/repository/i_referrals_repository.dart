import 'package:tourguide_app/features/referrals/model/referral_model.dart';

abstract class IReferralsRepository {
  Future<ReferralModel> getReferrals();
  Future<GeneratedReferralResult> generateReferralLink();
  Future<ReferralActivityModel> getReferralActivity(int referralId);
}

class GeneratedReferralResult {
  final ReferralModel referrals;
  final String? referralLink;
  final String? referralCode;

  GeneratedReferralResult({
    required this.referrals,
    this.referralLink,
    this.referralCode,
  });
}
