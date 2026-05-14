import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/wallet/model/payout_model.dart';
import 'package:tourguide_app/features/wallet/model/payout_profile_model.dart';
import 'package:tourguide_app/features/wallet/model/wallet_model.dart';
import 'package:tourguide_app/features/wallet/repository/i_wallet_repository.dart';

// ---------- States ----------

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletModel wallet;
  final List<PayoutModel> payouts;
  WalletLoaded(this.wallet, {this.payouts = const []});
}

class PayoutSuccess extends WalletState {}

// Emitted when the sheet needs to open — carries everything the sheet needs
class PayoutSheetReady extends WalletState {
  final WalletModel wallet;
  final List<PayoutModel> payouts;
  final List<PayoutMethodModel> methods;
  final PayoutProfileModel? savedProfile;
  PayoutSheetReady({
    required this.wallet,
    required this.payouts,
    required this.methods,
    this.savedProfile,
  });
}

class PayoutProfileSaved extends WalletState {
  final WalletModel wallet;
  final List<PayoutModel> payouts;
  final List<PayoutMethodModel> methods;
  PayoutProfileSaved({
    required this.wallet,
    required this.payouts,
    required this.methods,
  });
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class WalletCubit extends Cubit<WalletState> {
  final IWalletRepository _repository;

  WalletCubit(this._repository) : super(WalletInitial());

  WalletModel? _wallet;
  List<PayoutModel> _payouts = [];

  Future<void> loadWallet({int page = 1}) async {
    if (isClosed) return;
    emit(WalletLoading());
    try {
      final results = await Future.wait([
        _repository.getWallet(page: page),
        _repository.getPayouts(page: page),
      ]);
      _wallet = results[0] as WalletModel;
      _payouts = results[1] as List<PayoutModel>;
      if (!isClosed) emit(WalletLoaded(_wallet!, payouts: _payouts));
    } on DioException catch (e) {
      if (!isClosed) emit(WalletError(e.response?.data['message'] ?? 'Failed to load wallet'));
    } catch (_) {
      if (!isClosed) emit(WalletError('Something went wrong. Please try again.'));
    }
  }

  // Called when user taps "Request Payout" — loads methods + profile in parallel
  Future<void> openPayoutSheet() async {
    if (isClosed || _wallet == null) return;
    emit(WalletLoading());
    try {
      final results = await Future.wait([
        _repository.getPayoutMethods(),
        _repository.getPayoutProfile(),
      ]);
      if (!isClosed) {
        emit(PayoutSheetReady(
          wallet: _wallet!,
          payouts: _payouts,
          methods: results[0] as List<PayoutMethodModel>,
          savedProfile: results[1] as PayoutProfileModel?,
        ));
      }
    } on DioException catch (e) {
      if (!isClosed) emit(WalletError(e.response?.data['message'] ?? 'Failed to load payout methods'));
    } catch (_) {
      if (!isClosed) emit(WalletError('Something went wrong. Please try again.'));
    }
  }

  Future<void> savePayoutProfile(int methodId, Map<String, dynamic> details) async {
    if (isClosed) return;
    emit(WalletLoading());
    try {
      await _repository.savePayoutProfile(methodId, details);
      final methods = await _repository.getPayoutMethods();
      if (!isClosed) {
        emit(PayoutProfileSaved(wallet: _wallet!, payouts: _payouts, methods: methods));
      }
    } on DioException catch (e) {
      if (!isClosed) emit(WalletError(e.response?.data['message'] ?? 'Failed to save payout profile'));
    } catch (_) {
      if (!isClosed) emit(WalletError('Something went wrong. Please try again.'));
    }
  }

  Future<void> requestPayout(double amount) async {
    if (isClosed) return;
    emit(WalletLoading());
    try {
      await _repository.requestPayout(amount);
      if (!isClosed) emit(PayoutSuccess());
      await loadWallet();
    } on DioException catch (e) {
      if (!isClosed) emit(WalletError(e.response?.data['message'] ?? 'Payout request failed'));
    } catch (_) {
      if (!isClosed) emit(WalletError('Something went wrong. Please try again.'));
    }
  }
}
