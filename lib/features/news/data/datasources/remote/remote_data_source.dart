import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/constants/constants.dart';
import '../../../../../core/data_state/data_state.dart';
import '../../models/article_model.dart';

class RemoteDataSource {
  Future<Either<DataState, List<ArticleModel>>> getNews() async {
    try {
      Random random = Random();

      int randomSourceInt = random.nextInt(sources.length);
      String randomSource = sources[randomSourceInt];
      var url = Uri.parse(
          "${baseUrl}everything?q=$randomSource&sortBy=popularity&apiKey=$apiKey");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        final List<ArticleModel> reponseData =
            (jsonResponse['articles'] as List<dynamic>)
                .map((data) => ArticleModel.fromJson(data))
                .toList();
        return Right(reponseData);
      } else {
        return Left(DataFailure(response.statusCode, response.body.toString()));
      }
    } catch (e) {
      return Left(DataFailure(500, e.toString()));
    }
  }
}
