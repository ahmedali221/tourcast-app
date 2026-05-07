import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ReferralsState {}
class ReferralsInitial extends ReferralsState {}
class ReferralsLoading extends ReferralsState {}
class ReferralsLoaded extends ReferralsState {}
class ReferralsError extends ReferralsState {
  final String message;
  ReferralsError(this.message);
}

class ReferralsCubit extends Cubit<ReferralsState> {
  ReferralsCubit() : super(ReferralsInitial());

  Future<void> loadReferrals() async {}
  Future<void> shareReferralLink() async {}
}
