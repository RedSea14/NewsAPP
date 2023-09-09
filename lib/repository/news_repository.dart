import 'dart:convert';

import 'package:newapp/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsModel> getNewsByIdRepository(id) async {
    try {
      final url = 'http://apiforlearning.zendvn.com/api/articles/$id';

      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final jsondata = jsonDecode(response.body);
      // print(jsondata)
      NewsModel news = NewsModel.fromJson(jsonEncode(jsondata));
      return news;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }

  Future<List<NewsModel>> getNewsByCategoryRepository(id) async {
    try {
      final url =
          'http://apiforlearning.zendvn.com/api/categories_news/$id/articles';

      Uri uri = Uri.parse(url);
      final finalUri = uri.replace(queryParameters: {});

      final response = await http.get(finalUri);
      final jsondata = jsonDecode(response.body);
      // print(jsondata)
      List<NewsModel> listData = List<NewsModel>.from(
          jsondata.map((data) => NewsModel.fromJson(jsonEncode(data))));
      return listData;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }
}
