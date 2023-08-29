import 'package:flutter/foundation.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/repository/news_repository.dart';

class NewsProvider extends ChangeNotifier {
  final List<NewsModel> _listNews = [];
  get listNews => _listNews;
  Future<NewsModel> getNewsById(id) async {
    NewsModel data = await NewsRepository().getNewsByIdRepository(id);
    return data;
  }

  List<NewsModel> getNewsWithFavorite() {
    return _listNews.where((element) => element.isFavorite == true).toList();
  }
}
