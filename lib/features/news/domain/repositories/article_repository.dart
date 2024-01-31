import 'package:dartz/dartz.dart';

import '../../../../core/data_state/data_state.dart';
import '../entities/article_entity.dart';

abstract class ArticleRepository{
  Future<Either<DataState, List<ArticleEntity>>> getNews();
}