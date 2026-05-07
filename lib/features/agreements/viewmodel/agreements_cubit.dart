import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AgreementsState {}
class AgreementsInitial extends AgreementsState {}
class AgreementsLoading extends AgreementsState {}
class AgreementsLoaded extends AgreementsState {}
class AgreementsError extends AgreementsState {
  final String message;
  AgreementsError(this.message);
}

class AgreementsCubit extends Cubit<AgreementsState> {
  AgreementsCubit() : super(AgreementsInitial());

  Future<void> loadPendingAgreements() async {}
  Future<void> acceptAgreement(int id) async {}
}
