import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/article_entity.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  String author;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;

  @HiveField(3)
  String url;

  @HiveField(4)
  String urlToImage;

  @HiveField(5)
  DateTime publishedAt;

  @HiveField(6)
  String content;

  ArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt'] ?? ''),
      content: json['content'] ?? '',
    );
  }

  ArticleEntity toEntity() => ArticleEntity(
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );
}
