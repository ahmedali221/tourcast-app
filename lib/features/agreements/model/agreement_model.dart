// GET /api/guide/agreements/pending
class AgreementModel {
  final int id;
  final String title;
  final String content;
  final bool isAccepted;

  AgreementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isAccepted,
  });

  factory AgreementModel.fromJson(Map<String, dynamic> json) {
    return AgreementModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      isAccepted: json['is_accepted'] as bool? ?? false,
    );
  }
}
