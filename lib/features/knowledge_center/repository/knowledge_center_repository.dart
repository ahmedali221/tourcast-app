import 'package:dio/dio.dart';
import 'package:tourguide_app/features/knowledge_center/model/article_model.dart';
import 'package:tourguide_app/features/knowledge_center/repository/i_knowledge_center_repository.dart';

class KnowledgeCenterRepository implements IKnowledgeCenterRepository {
  final Dio _dio;

  KnowledgeCenterRepository(this._dio);

  @override
  Future<List<ArticleModel>> getArticles({String? category, int? appId}) async {
    final response = await _dio.get('/guide/articles', queryParameters: {
      'category': category,
      'app_id': appId,
    });
    final list = response.data['data'] as List;
    return list.map((e) => ArticleModel.fromJson(e)).toList();
  }

  @override
  Future<ArticleModel> getArticle(int articleId) async {
    final response = await _dio.get('/guide/articles/$articleId');
    return ArticleModel.fromJson(response.data['data']);
  }
}
