import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/functions.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  @override
  void initState() {
    ref.read(articleListenerProvider.notifier).getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final articles = ref.watch(articleListenerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Random Update',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: articles.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.read(articleListenerProvider.notifier).getArticles();
                },
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ArticleCard(
                      author: article.author,
                      title: article.title,
                      description: article.description,
                      urlToImage: article.urlToImage,
                      publishedAt: article.publishedAt,
                      onTap: () {
                        launchUrlNow(article.url);
                      },
                    );
                  },
                ),
              ),
            )
          : const Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }
}
