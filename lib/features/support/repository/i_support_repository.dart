import 'package:tourguide_app/features/support/model/ticket_model.dart';

abstract class ISupportRepository {
  Future<List<TicketModel>> getTickets();

  Future<TicketModel> getTicket(int ticketId);

  Future<void> createTicket({
    required String category,
    required String priority,
    required String subject,
    required String message,
  });

  Future<void> replyToTicket(int ticketId, String message);
}
