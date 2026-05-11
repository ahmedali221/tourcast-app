import 'package:dio/dio.dart';
import 'package:tourguide_app/features/subscription/model/subscription_model.dart';
import 'package:tourguide_app/features/subscription/repository/i_subscription_repository.dart';

class SubscriptionRepository implements ISubscriptionRepository {
  final Dio _dio;

  SubscriptionRepository(this._dio);

  @override
  Future<List<SubscriptionModel>> getSubscriptions() async {
    final response = await _dio.get('/guide/subscriptions');
    final list = response.data['data'] as List;
    return list.map((e) => SubscriptionModel.fromJson(e)).toList();
  }

  @override
  Future<void> subscribe(int planId, {String? promoCode}) async {
    await _dio.post('/guide/subscriptions', data: {
      'plan_id': planId,
      'promo_code': promoCode,
    });
  }

  @override
  Future<void> cancelSubscription(int subscriptionId) async {
    await _dio.delete('/guide/subscriptions/$subscriptionId');
  }
}
