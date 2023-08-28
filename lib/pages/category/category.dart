import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/pages/category/widget/category_body.dart';

// ignore: must_be_immutable
class CategoryPage extends StatelessWidget {
  CategoryPage({super.key, required this.categoryid});
  // ignore: prefer_typing_uninitialized_variables
  var categoryid;

  @override
  Widget build(BuildContext context) {
    // print(categoryid['categoryid']);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Thể thao',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/'); // Điều hướng quay lại
          },
        ),
      ),
      body: CategoryBody(id: categoryid['categoryid']),
    );
  }
}
