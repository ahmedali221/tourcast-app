import 'package:flutter_bloc/flutter_bloc.dart';

abstract class KnowledgeCenterState {}
class KnowledgeCenterInitial extends KnowledgeCenterState {}
class KnowledgeCenterLoading extends KnowledgeCenterState {}
class KnowledgeCenterLoaded extends KnowledgeCenterState {}
class KnowledgeCenterError extends KnowledgeCenterState {
  final String message;
  KnowledgeCenterError(this.message);
}

class KnowledgeCenterCubit extends Cubit<KnowledgeCenterState> {
  KnowledgeCenterCubit() : super(KnowledgeCenterInitial());

  Future<void> loadArticles({String? category, int? appId}) async {}
}
