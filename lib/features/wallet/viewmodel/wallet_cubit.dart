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
    if (isClosed) return;
    emit(WalletLoading());
    try {
      final wallet = await _repository.getWallet(page: page);
      if (!isClosed) emit(WalletLoaded(wallet));
    } on DioException catch (e) {
      if (!isClosed) emit(WalletError(e.response?.data['message'] ?? 'Failed to load wallet'));
    } catch (_) {
      if (!isClosed) emit(WalletError('Something went wrong. Please try again.'));
    }
  }

  Future<void> requestPayout(double amount, String paymentMethod) async {
    if (isClosed) return;
    emit(WalletLoading());
    try {
      await _repository.requestPayout(amount, paymentMethod);
      if (!isClosed) emit(PayoutSuccess());
      await loadWallet();
    } on DioException catch (e) {
      if (!isClosed) emit(WalletError(e.response?.data['message'] ?? 'Payout request failed'));
    } catch (_) {
      if (!isClosed) emit(WalletError('Something went wrong. Please try again.'));
    }
  }
}
