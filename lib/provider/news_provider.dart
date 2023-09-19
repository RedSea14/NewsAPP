import 'package:flutter/foundation.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/repository/news_repository.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> listNews = [];
  String searchText = '';
  Future<NewsModel> getNewsById(id) async {
    NewsModel data = await NewsRepository().getNewsByIdRepository(id);
    return data;
  }

  Future<List<NewsModel>> getNewsCate(id) async {
    listNews = await NewsRepository().getNewsByCategoryRepository(id);
    return listNews;
  }

  getArticleByName(value) async {
    listNews = await NewsRepository().getArticleByNameRepository(value);
    notifyListeners();
    return listNews;
  }

  getDataArticle() async {
    listNews = await NewsRepository().getDataArticleRepository();
    notifyListeners();
    return listNews;
  }
}
