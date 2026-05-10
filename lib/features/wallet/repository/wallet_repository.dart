import 'package:dio/dio.dart';
import 'package:tourguide_app/features/wallet/model/wallet_model.dart';
import 'package:tourguide_app/features/wallet/repository/i_wallet_repository.dart';

class WalletRepository implements IWalletRepository {
  final Dio _dio;

  WalletRepository(this._dio);

  @override
  Future<WalletModel> getWallet({int page = 1}) async {
    final response = await _dio.get('/guide/wallet', queryParameters: {'page': page});
    return WalletModel.fromJson(response.data['data']);
  }

  @override
  Future<void> requestPayout(double amount, String paymentMethod) async {
    await _dio.post('/guide/payouts', data: {
      'amount': amount,
      'payment_method': paymentMethod,
    });
  }
}
