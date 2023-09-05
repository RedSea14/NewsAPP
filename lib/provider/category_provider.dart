import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newapp/model/category_model.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/repository/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final StreamController<List<CategoryModel>> _controller =
      StreamController<List<CategoryModel>>.broadcast();
  Stream<List<CategoryModel>> get categoryStream => _controller.stream;
  List<CategoryModel> listCategory = [];
  List<CategoryModel> listCategoryById = [];
  List<NewsModel> listNews = [];
  List<CategoryModel> get listItemdata {
    return [...listCategoryById];
  }

  List<CategoryModel> get listCategorys {
    return [...listCategory];
  }

  Future<List<CategoryModel>> getListCate() async {
    listCategory = await CategoryRepository().getListCategoryRepository();
    return listCategory;
  }

  Future<List<CategoryModel>> getListCateById(id) async {
    CategoryModel cate =
        await CategoryRepository().getCategoryByIdRepository(id);
    listCategoryById.add(cate);
    return listCategoryById;
  }

  void getListCateByIdStream(id) async {
    CategoryModel cate =
        await CategoryRepository().getCategoryByIdRepository(id);
    listCategoryById.add(cate);
    _controller.sink.add(listCategoryById);
  }

  void deleteCateById(id) {
    listCategoryById.removeWhere((element) => element.id == id);
    _controller.sink.add(listCategoryById);
  }

  bool checkIndex(CategoryModel model) {
    return listItemdata.any((element) => element.id == model.id);
  }

  Future<List<NewsModel>> getNewsCate(id) async {
    listNews = await CategoryRepository().getNewsByCategoryRepository(id);
    return listNews;
  }
}
