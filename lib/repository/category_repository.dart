import 'dart:convert';

import 'package:newapp/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:newapp/model/news_model.dart';

class CategoryRepository {
  var params = {
    "offset": '0',
    "limit": '14',
    "sort_by": "id",
    "sort_dir": "asc"
  };
  var getListCategoryUrl =
      'http://apiforlearning.zendvn.com/api/categories_news';
  var getTotalCategoryUrl =
      'http://apiforlearning.zendvn.com/api/categories_news/total';
  Future<int> getTotalCategoryCountRepository() async {
    try {
      final response = await http.get(Uri.parse(getTotalCategoryUrl));
      final jsondata = jsonDecode(response.body);
      return jsondata as int;
    } catch (e) {
      return 0;
    }
  }

  Future<List<CategoryModel>> getListCategoryRepository() async {
    try {
      final totalCategories = await getTotalCategoryCountRepository();
      final response = await http.get(Uri.parse(getListCategoryUrl).replace(
        queryParameters: {
          "offset": '0',
          "limit": totalCategories.toString(),
          "sort_by": "id",
          "sort_dir": "asc"
        },
      ));
      final jsondata = jsonDecode(response.body);
      List<CategoryModel> listData = List<CategoryModel>.from(
          jsondata.map((data) => CategoryModel.fromJson(jsonEncode(data))));
      return listData;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }

  Future<CategoryModel> getCategoryByIdRepository(id) async {
    try {
      final url = 'http://apiforlearning.zendvn.com/api/categories_news/$id';

      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final jsondata = jsonDecode(response.body);
      // print(jsondata)
      CategoryModel category = CategoryModel.fromJson(jsonEncode(jsondata));
      return category;
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
