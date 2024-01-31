import 'package:dartz/dartz.dart';

import '../../../../core/data_state/data_state.dart';
import '../entities/article_entity.dart';
import '../repositories/article_repository.dart';

class GetArticles{
  ArticleRepository repository;

  GetArticles(this.repository);

  Future<Either<DataState, List<ArticleEntity>>> call(){
    return repository.getNews();
  }
}