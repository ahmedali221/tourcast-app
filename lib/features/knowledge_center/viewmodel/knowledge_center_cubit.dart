import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguide_app/features/knowledge_center/model/article_model.dart';
import 'package:tourguide_app/features/knowledge_center/repository/i_knowledge_center_repository.dart';

// ---------- States ----------

abstract class KnowledgeCenterState {}

class KnowledgeCenterInitial extends KnowledgeCenterState {}

class KnowledgeCenterLoading extends KnowledgeCenterState {}

class KnowledgeCenterLoaded extends KnowledgeCenterState {
  final List<ArticleModel> articles;
  KnowledgeCenterLoaded(this.articles);
}

class KnowledgeCenterError extends KnowledgeCenterState {
  final String message;
  KnowledgeCenterError(this.message);
}

// ---------- Cubit (ViewModel) ----------

class KnowledgeCenterCubit extends Cubit<KnowledgeCenterState> {
  final IKnowledgeCenterRepository _repository;

  KnowledgeCenterCubit(this._repository) : super(KnowledgeCenterInitial());

  Future<void> loadArticles({String? category, int? appId}) async {
    emit(KnowledgeCenterLoading());
    try {
      final articles = await _repository.getArticles(category: category, appId: appId);
      emit(KnowledgeCenterLoaded(articles));
    } on DioException catch (e) {
      emit(KnowledgeCenterError(e.response?.data['message'] ?? 'Failed to load articles'));
    } catch (_) {
      emit(KnowledgeCenterError('Something went wrong. Please try again.'));
    }
  }
}
