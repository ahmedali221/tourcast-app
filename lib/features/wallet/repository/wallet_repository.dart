import 'package:dio/dio.dart';
import 'package:tourguide_app/features/wallet/model/payout_model.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
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
  Future<List<PayoutModel>> getPayouts({int page = 1}) async {
    final response = await _dio.get('/guide/payouts', queryParameters: {'page': page});
    return (response.data['data'] as List? ?? [])
        .map((e) => PayoutModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> requestPayout(double amount) async {
    await _dio.post('/guide/payouts', data: {'amount': amount});
  }

  @override
  Future<List<PayoutMethodModel>> getPayoutMethods() async {
    final response = await _dio.get('/guide/payout-methods');
    return (response.data['data'] as List? ?? [])
        .map((e) => PayoutMethodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PayoutProfileModel?> getPayoutProfile() async {
    final response = await _dio.get('/guide/payout-profile');
    final data = response.data['data'];
    if (data == null) return null;
    return PayoutProfileModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<void> savePayoutProfile(int payoutMethodId, Map<String, dynamic> details) async {
    await _dio.put('/guide/payout-profile', data: {
      'payout_method_id': payoutMethodId,
      'details': details,
    });
  }
}
