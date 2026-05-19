// GET /api/guide/announcements
class AnnouncementModel {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final String priority;
  final DateTime startDate;
  final DateTime endDate;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    required this.priority,
    required this.startDate,
    required this.endDate,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? 'Untitled',
      content: json['content'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      priority: json['priority'] as String? ?? 'NORMAL',
      startDate: DateTime.tryParse(json['start_date'] as String? ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['end_date'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
