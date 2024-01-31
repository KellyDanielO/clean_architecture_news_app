import 'package:dartz/dartz.dart';

import 'package:news_app/core/data_state/data_state.dart';

import 'package:news_app/features/news/domain/entities/article_entity.dart';

import '../../../../core/helpers/functions.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/remote/remote_data_source.dart';
import '../models/article_model.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  RemoteDataSource remoteDataSource;
  ArticleRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<DataState, List<ArticleEntity>>> getNews() async {
    if (await isOnline()) {
      final response = await remoteDataSource.getNews();
      return response.fold((DataState responseState) {
        if (responseState is DataFailure) {
          return Left(responseState);
        } else {
          return Left(responseState);
        }
      }, (List<ArticleModel> articles) {
        return Right(articles.map((models) => models.toEntity()).toList());
      });
    } else {
      return Left(DataFailedOffline(500, 'offline'));
    }
  }
}
