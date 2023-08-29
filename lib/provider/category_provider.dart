import 'package:flutter/material.dart';
import 'package:newapp/model/category_model.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/repository/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> listCategory = [];
  List<CategoryModel> listCategoryById = [];
  List<NewsModel> listNews = [];
  List<CategoryModel> get listItemdata {
    return [...listCategoryById];
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

  Future<List<NewsModel>> getNewsCate(id) async {
    listNews = await CategoryRepository().getNewsCategoryRepository(id);
    return listNews;
  }
}
