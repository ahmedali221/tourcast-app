import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WalletState {}
class WalletInitial extends WalletState {}
class WalletLoading extends WalletState {}
class WalletLoaded extends WalletState {}
class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  Future<void> loadWallet() async {}
  Future<void> requestPayout(double amount, String paymentMethod) async {}
}
