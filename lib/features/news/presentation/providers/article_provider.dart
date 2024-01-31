import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/data_state/data_state.dart';
import '../../data/datasources/local/local_data_source.dart';
import '../../data/datasources/remote/remote_data_source.dart';
import '../../data/models/article_model.dart';
import '../../data/repositories/article_repository_impl.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/article_repository.dart';
import '../../domain/usecases/get_article_usecase.dart';

final articleRemoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSource();
});

final articleLocalDataSourceProvider = Provider<LocalDataSource>((ref) {
  final Box<ArticleModel> articleBox = Hive.box('articles');
  return LocalDataSource(articleBox);
});

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  final remoteDataSource = ref.read(articleRemoteDataSourceProvider);
  final articleLocalDataSource = ref.read(articleLocalDataSourceProvider);
  return ArticleRepositoryImpl(remoteDataSource, articleLocalDataSource);
});

final getArticlesProvider = Provider<GetArticles>((ref) {
  final repository = ref.read(articleRepositoryProvider);
  return GetArticles(repository);
});

final articleListenerProvider =
    StateNotifierProvider<ArticleStateNotifier, List<ArticleEntity>>((ref) {
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
