import 'package:tourguide_app/features/knowledge_center/model/article_model.dart';

abstract class IKnowledgeCenterRepository {
  Future<List<ArticleModel>> getArticles({String? category, int? appId});

  Future<ArticleModel> getArticle(int articleId);
}
