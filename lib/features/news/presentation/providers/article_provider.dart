import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data_state/data_state.dart';
import '../../data/datasources/remote/remote_data_source.dart';
import '../../data/repositories/article_repository_impl.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/article_repository.dart';
import '../../domain/usecases/get_article_usecase.dart';

final articleRemoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSource();
});

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  final remoteDataSource = ref.read(articleRemoteDataSourceProvider);
  return ArticleRepositoryImpl(remoteDataSource);
});

final getArticlesProvider = Provider<GetArticles>((ref) {
  final repository = ref.read(articleRepositoryProvider);
  return GetArticles(repository);
});

final articleListenerProvider = StateNotifierProvider<ArticleStateNotifier, List<ArticleEntity>>((ref) {
  final getArticles = ref.read(getArticlesProvider);
  return ArticleStateNotifier(getArticles);
});

class ArticleStateNotifier extends StateNotifier<List<ArticleEntity>> {
  final GetArticles _getArticles;
  ArticleStateNotifier(this._getArticles) : super([]);

  Future<void> getArticles() async {
    final articlesOrError = await _getArticles();
    articlesOrError.fold((DataState dataState) => state = [],
        (List<ArticleEntity> data) => state = data);
  }
}
