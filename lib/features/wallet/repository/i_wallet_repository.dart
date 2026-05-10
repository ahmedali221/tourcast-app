import 'package:tourguide_app/features/wallet/model/wallet_model.dart';

abstract class IWalletRepository {
  Future<WalletModel> getWallet({int page = 1});

  Future<void> requestPayout(double amount, String paymentMethod);
}
