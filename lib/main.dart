import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'features/news/data/models/article_model.dart';
import 'features/news/presentation/pages/news.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initial Hive and open box
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(ArticleModelAdapter());
  await Hive.openBox<ArticleModel>('articles');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: child,
      ),
      child: const NewsScreen(),
    );
  }
}
