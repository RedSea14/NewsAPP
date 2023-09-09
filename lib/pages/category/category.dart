import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/pages/category/widget/category_body.dart';
import 'package:newapp/provider/category_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryPage extends StatelessWidget {
  CategoryPage({super.key, required this.data});
  // ignore: prefer_typing_uninitialized_variables
  var data;

  @override
  Widget build(BuildContext context) {
    // print(data['categoryid']);
    // print(data['tiltle']);
    // var news =
    //     Provider.of<CategoryProvider>(context).getNewsCate(data['categoryid']);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          data['tiltle'].toString(),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed(
                MyAppRouteConstants.homeRouteName); // Điều hướng quay lại
          },
        ),
      ),
      body: CategoryBody(id: data['categoryid']),
    );
  }
}
