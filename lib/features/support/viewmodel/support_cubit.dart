import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SupportState {}
class SupportInitial extends SupportState {}
class SupportLoading extends SupportState {}
class SupportLoaded extends SupportState {}
class SupportError extends SupportState {
  final String message;
  SupportError(this.message);
}

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());

  Future<void> loadTickets() async {}
  Future<void> createTicket(Map<String, dynamic> data) async {}
  Future<void> replyToTicket(int ticketId, String message) async {}
}
