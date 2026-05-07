// GET /api/guide/articles
class ArticleModel {
  final int id;
  final String title;
  final String content;
  final String? category;
  final int? appId;
  final DateTime publishedAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    this.category,
    this.appId,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String?,
      appId: json['app_id'] as int?,
      publishedAt: DateTime.parse(json['published_at'] as String),
    );
  }
}
