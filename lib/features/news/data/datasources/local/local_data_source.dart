import 'package:hive_flutter/hive_flutter.dart';

import '../../models/article_model.dart';

class LocalDataSource {
  final Box<ArticleModel> tripBox;

  LocalDataSource(this.tripBox);

  List<ArticleModel> getArticles() {
    return tripBox.values.toList();
  }

  void addArticles(List<ArticleModel> articles) {
    tripBox.addAll(articles);
  }
}
