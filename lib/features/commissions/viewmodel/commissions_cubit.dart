import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CommissionsState {}
class CommissionsInitial extends CommissionsState {}
class CommissionsLoading extends CommissionsState {}
class CommissionsLoaded extends CommissionsState {}
class CommissionsError extends CommissionsState {
  final String message;
  CommissionsError(this.message);
}

class CommissionsCubit extends Cubit<CommissionsState> {
  CommissionsCubit() : super(CommissionsInitial());

  Future<void> loadCommissions() async {}
}
