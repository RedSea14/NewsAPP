import 'package:flutter/foundation.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/repository/news_repository.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> listNews = [];

  Future<NewsModel> getNewsById(id) async {
    NewsModel data = await NewsRepository().getNewsByIdRepository(id);
    return data;
  }

  List<NewsModel> getNewsWithFavorite() {
    return listNews.where((element) => element.isFavorite == true).toList();
  }

  Future<List<NewsModel>> getNewsCate(id) async {
    listNews = await NewsRepository().getNewsByCategoryRepository(id);
    return listNews;
  }
}
