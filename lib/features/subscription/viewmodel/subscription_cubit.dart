import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SubscriptionState {}
class SubscriptionInitial extends SubscriptionState {}
class SubscriptionLoading extends SubscriptionState {}
class SubscriptionLoaded extends SubscriptionState {}
class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError(this.message);
}

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());

  Future<void> loadSubscriptions() async {}
  Future<void> subscribe(int planId, {String? promoCode}) async {}
}
