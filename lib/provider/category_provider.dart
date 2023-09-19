import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newapp/model/category_model.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/repository/category_repository.dart';
import 'package:newapp/repository/news_repository.dart';
import 'package:newapp/utils/share.dart';

class CategoryProvider extends ChangeNotifier {
  List<int> listCategoryChoose = [];

  List<CategoryModel> listCategory = [];

  Future<List<CategoryModel>> getListCate() async {
    listCategory = await CategoryRepository().getListCategoryRepository();
    return listCategory;
  }

  void chooseCategory(int id) {
    if (listCategoryChoose.contains(id)) {
      listCategoryChoose.remove(id);
    } else {
      listCategoryChoose.add(id);
    }
    notifyListeners();
  }

  Future<List<NewsModel>> getAllNewsInCategory(int id) async {
    List<NewsModel> data =
        await NewsRepository().getNewsByCategoryRepository(id);
    return data;
  }

  void getDataFormSha() async {
    List<int> result = await SharereferenceApp.getListData('demo');
    listCategoryChoose = result;
    notifyListeners();
  }
}
