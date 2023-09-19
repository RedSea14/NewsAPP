import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/pages/category/widget/category_body.dart';
import 'package:newapp/router/app_route_constants.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  CategoryPage({super.key, required this.data});
  // ignore: prefer_typing_uninitialized_variables
  var data;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.data['tiltle'].toString(),
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
      body: CategoryBody(id: widget.data['categoryid']),
    );
  }
}
