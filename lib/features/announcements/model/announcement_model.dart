// GET /api/guide/announcements
class AnnouncementModel {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final String priority;
  final DateTime startDate;
  final DateTime endDate;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.priority,
    required this.startDate,
    required this.endDate,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String?,
      priority: json['priority'] as String? ?? 'NORMAL',
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );
  }
}
