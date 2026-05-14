import 'package:tourguide_app/features/wallet/model/payout_model.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
import 'package:tourguide_app/features/wallet/model/wallet_model.dart';

abstract class IWalletRepository {
  Future<WalletModel> getWallet({int page = 1});
  Future<List<PayoutModel>> getPayouts({int page = 1});
  Future<void> requestPayout(double amount);
  Future<List<PayoutMethodModel>> getPayoutMethods();
  Future<PayoutProfileModel?> getPayoutProfile();
  Future<void> savePayoutProfile(int payoutMethodId, Map<String, dynamic> details);
}
