import 'package:tourguide_app/features/subscription/model/subscription_model.dart';

abstract class ISubscriptionRepository {
  Future<List<SubscriptionModel>> getSubscriptions();

  Future<void> subscribe(int planId, {String? promoCode});

  Future<void> cancelSubscription(int subscriptionId);
}
