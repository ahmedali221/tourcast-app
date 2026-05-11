// GET /api/guide/tickets
class TicketModel {
  final int id;
  final String subject;
  final String category; // PAYMENT | TECHNICAL | GENERAL
  final String priority; // NORMAL | HIGH | URGENT
  final String status;   // open | pending | closed
  final DateTime createdAt;
  final List<TicketReplyModel> replies;

  TicketModel({
    required this.id,
    required this.subject,
    required this.category,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.replies,
  });

  TicketModel copyWith({List<TicketReplyModel>? replies}) {
    return TicketModel(
      id: id,
      subject: subject,
      category: category,
      priority: priority,
      status: status,
      createdAt: createdAt,
      replies: replies ?? this.replies,
    );
  }

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: (json['id'] as num).toInt(),
      subject: json['subject'] as String,
      category: json['category'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      replies: ((json['messages'] ?? json['replies']) as List? ?? [])
          .map((r) => TicketReplyModel.fromJson(r as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TicketReplyModel {
  final int id;
  final String message;
  final bool isFromSupport;
  final DateTime createdAt;
  final bool isFailed;

  TicketReplyModel({
    required this.id,
    required this.message,
    required this.isFromSupport,
    required this.createdAt,
    this.isFailed = false,
  });

  TicketReplyModel copyWith({bool? isFailed}) {
    return TicketReplyModel(
      id: id,
      message: message,
      isFromSupport: isFromSupport,
      createdAt: createdAt,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  factory TicketReplyModel.fromJson(Map<String, dynamic> json) {
    return TicketReplyModel(
      id: (json['id'] as num).toInt(),
      message: json['message'] as String,
      isFromSupport: (json['sender_type'] as String?)?.toUpperCase() != 'GUIDE',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
