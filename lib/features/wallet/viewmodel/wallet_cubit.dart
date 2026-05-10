import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/wallet/model/wallet_model.dart';
import 'package:tourguide_app/features/wallet/repository/i_wallet_repository.dart';

// ---------- States ----------

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletModel wallet;
  WalletLoaded(this.wallet);
}

class PayoutSuccess extends WalletState {}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class WalletCubit extends Cubit<WalletState> {
  final IWalletRepository _repository;

  WalletCubit(this._repository) : super(WalletInitial());

  Future<void> loadWallet({int page = 1}) async {
    emit(WalletLoading());
    try {
      final wallet = await _repository.getWallet(page: page);
      emit(WalletLoaded(wallet));
    } on DioException catch (e) {
      emit(WalletError(e.response?.data['message'] ?? 'Failed to load wallet'));
    } catch (_) {
      emit(WalletError('Something went wrong. Please try again.'));
    }
  }

  Future<void> requestPayout(double amount, String paymentMethod) async {
    emit(WalletLoading());
    try {
      await _repository.requestPayout(amount, paymentMethod);
      emit(PayoutSuccess());
      await loadWallet();
    } on DioException catch (e) {
      emit(WalletError(e.response?.data['message'] ?? 'Payout request failed'));
    } catch (_) {
      emit(WalletError('Something went wrong. Please try again.'));
    }
  }
}
