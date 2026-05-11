import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/subscription/model/subscription_model.dart';
import 'package:tourguide_app/features/subscription/repository/i_subscription_repository.dart';

// ---------- States ----------

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final List<SubscriptionModel> subscriptions;
  SubscriptionLoaded(this.subscriptions);
}

class SubscriptionSuccess extends SubscriptionState {} // after subscribe

class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final ISubscriptionRepository _repository;

  SubscriptionCubit(this._repository) : super(SubscriptionInitial());

  Future<void> loadSubscriptions() async {
    emit(SubscriptionLoading());
    try {
      final subs = await _repository.getSubscriptions();
      emit(SubscriptionLoaded(subs));
    } on DioException catch (e) {
      emit(SubscriptionError(e.response?.data['message'] ?? 'Failed to load subscriptions'));
    } catch (_) {
      emit(SubscriptionError('Something went wrong. Please try again.'));
    }
  }

  Future<void> subscribe(int planId, {String? promoCode}) async {
    emit(SubscriptionLoading());
    try {
      await _repository.subscribe(planId, promoCode: promoCode);
      emit(SubscriptionSuccess());
      await loadSubscriptions();
    } on DioException catch (e) {
      emit(SubscriptionError(e.response?.data['message'] ?? 'Subscription failed'));
    } catch (_) {
      emit(SubscriptionError('Something went wrong. Please try again.'));
    }
  }
}
