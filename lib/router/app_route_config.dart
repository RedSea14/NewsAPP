import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/pages/category_selection/category_selection_screen.dart';
import 'package:newapp/pages/error/error.dart';
import 'package:newapp/pages/home/home.dart';
import 'package:newapp/pages/category/category.dart';
import 'package:newapp/router/app_route_constants.dart';

class MyAppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstants.homeRouteName,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomeBody());
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.categoryselectRouteName,
        path: '/categoryselect',
        pageBuilder: (context, state) {
          return const MaterialPage(child: CategorySelectionScreen());
        },
      ),
      GoRoute(
        name: MyAppRouteConstants.categoryRouteName,
        path: '/category',
        pageBuilder: (context, state) {
          return MaterialPage(
              child: CategoryPage(
            categoryid: state.extra,
          ));
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );
}
