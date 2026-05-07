import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MarketplaceState {}
class MarketplaceInitial extends MarketplaceState {}
class MarketplaceLoading extends MarketplaceState {}
class MarketplaceLoaded extends MarketplaceState {}
class MarketplaceError extends MarketplaceState {
  final String message;
  MarketplaceError(this.message);
}

class MarketplaceCubit extends Cubit<MarketplaceState> {
  MarketplaceCubit() : super(MarketplaceInitial());

  Future<void> loadApps() async {}
  Future<void> searchApps(String query) async {}
}
