import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/support/model/ticket_model.dart';
import 'package:tourguide_app/features/support/repository/i_support_repository.dart';

// ---------- States ----------

abstract class SupportState {}

class SupportInitial extends SupportState {}

class SupportLoading extends SupportState {}

class TicketsLoaded extends SupportState {
  final List<TicketModel> tickets;
  TicketsLoaded(this.tickets);
}

class TicketDetailLoaded extends SupportState {
  final TicketModel ticket;
  TicketDetailLoaded(this.ticket);
}

class TicketCreated extends SupportState {}

class ReplySent extends SupportState {}

class TicketRefreshing extends SupportState {
  final TicketModel ticket;
  TicketRefreshing(this.ticket);
}

class SupportError extends SupportState {
  final String message;
  SupportError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class SupportCubit extends Cubit<SupportState> {
  final ISupportRepository _repository;

  SupportCubit(this._repository) : super(SupportInitial());

  bool _refreshing = false;

  Future<void> loadTickets() async {
    if (isClosed) return;
    emit(SupportLoading());
    try {
      final tickets = await _repository.getTickets();
      if (!isClosed) emit(TicketsLoaded(tickets));
    } on DioException catch (e) {
      if (!isClosed) emit(SupportError(e.response?.data['message'] ?? 'Failed to load tickets'));
    } catch (_) {
      if (!isClosed) emit(SupportError('Something went wrong. Please try again.'));
    }
  }

  Future<void> loadTicket(int ticketId) async {
    if (isClosed) return;
    emit(SupportLoading());
    try {
      final ticket = await _repository.getTicket(ticketId);
      if (!isClosed) emit(TicketDetailLoaded(ticket));
    } on DioException catch (e) {
      if (!isClosed) emit(SupportError(e.response?.data['message'] ?? 'Failed to load ticket'));
    } catch (_) {
      if (!isClosed) emit(SupportError('Something went wrong. Please try again.'));
    }
  }

  // Refresh without full loading screen — drops concurrent calls until done
  Future<void> refreshTicket(int ticketId) async {
    if (isClosed || _refreshing) return;
    final current = state;
    if (current is! TicketDetailLoaded) return;
    _refreshing = true;
    emit(TicketRefreshing(current.ticket));
    try {
      final ticket = await _repository.getTicket(ticketId);
      if (!isClosed) emit(TicketDetailLoaded(ticket));
    } on DioException catch (e) {
      if (!isClosed) {
        emit(TicketDetailLoaded(current.ticket));
        await Future.microtask(
          () => emit(SupportError(e.response?.data['message'] ?? 'Failed to refresh')),
        );
      }
    } catch (_) {
      if (!isClosed) {
        emit(TicketDetailLoaded(current.ticket));
        await Future.microtask(
          () => emit(SupportError('Something went wrong. Please try again.')),
        );
      }
    } finally {
      _refreshing = false;
    }
  }

  Future<void> createTicket({
    required String category,
    required String priority,
    required String subject,
    required String message,
  }) async {
    if (isClosed) return;
    emit(SupportLoading());
    try {
      await _repository.createTicket(
        category: category,
        priority: priority,
        subject: subject,
        message: message,
      );
      if (!isClosed) emit(TicketCreated());
    } on DioException catch (e) {
      if (!isClosed) emit(SupportError(e.response?.data['message'] ?? 'Failed to create ticket'));
    } catch (_) {
      if (!isClosed) emit(SupportError('Something went wrong. Please try again.'));
    }
  }

  Future<void> replyToTicket(int ticketId, String message) async {
    if (isClosed) return;
    final current = state;
    if (current is! TicketDetailLoaded) return;

    final tempId = -DateTime.now().millisecondsSinceEpoch;
    final optimistic = TicketReplyModel(
      id: tempId,
      message: message,
      isFromSupport: false,
      createdAt: DateTime.now(),
    );

    emit(TicketDetailLoaded(current.ticket.copyWith(
      replies: [...current.ticket.replies, optimistic],
    )));

    try {
      await _repository.replyToTicket(ticketId, message);
    } on DioException catch (_) {
      _markFailed(tempId);
    } catch (_) {
      _markFailed(tempId);
    }
  }

  void _markFailed(int tempId) {
    if (isClosed) return;
    final current = state;
    if (current is! TicketDetailLoaded) return;
    emit(TicketDetailLoaded(current.ticket.copyWith(
      replies: current.ticket.replies
          .map((r) => r.id == tempId ? r.copyWith(isFailed: true) : r)
          .toList(),
    )));
  }
}
