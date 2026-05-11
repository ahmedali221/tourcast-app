import 'package:dio/dio.dart';
import 'package:tourguide_app/features/support/model/ticket_model.dart';
import 'package:tourguide_app/features/support/repository/i_support_repository.dart';

class SupportRepository implements ISupportRepository {
  final Dio _dio;

  SupportRepository(this._dio);

  @override
  Future<List<TicketModel>> getTickets() async {
    final response = await _dio.get('/guide/support/tickets');
    final list = response.data['data'] as List;
    return list.map((e) => TicketModel.fromJson(e)).toList();
  }

  @override
  Future<TicketModel> getTicket(int ticketId) async {
    final response = await _dio.get('/guide/support/tickets/$ticketId');
    return TicketModel.fromJson(response.data['data']);
  }

  @override
  Future<void> createTicket({
    required String category,
    required String priority,
    required String subject,
    required String message,
  }) async {
    await _dio.post('/guide/support/tickets', data: {
      'category': category,
      'priority': priority,
      'subject': subject,
      'message': message,
    });
  }

  @override
  Future<void> replyToTicket(int ticketId, String message) async {
    await _dio.post('/guide/support/tickets/$ticketId/messages', data: {'message': message});
  }
}
