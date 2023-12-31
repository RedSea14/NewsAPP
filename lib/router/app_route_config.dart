import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/pages/auth/login_page.dart';
import 'package:newapp/pages/category_selection/category_selection_screen.dart';
import 'package:newapp/pages/error/error.dart';
import 'package:newapp/pages/favorite/favorite.dart';
import 'package:newapp/pages/home/home.dart';
import 'package:newapp/pages/category/category.dart';
import 'package:newapp/pages/news/news.dart';
import 'package:newapp/pages/search/search.dart';
import 'package:newapp/router/app_route_constants.dart';

class MyAppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstants.homeRouteName,
        path: MyAppRouteConstants.homeRouteName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomeBody());
        },
        routes: [
          GoRoute(
            name: MyAppRouteConstants.categoryselectRouteName,
            path: MyAppRouteConstants.categoryselectRouteName,
            pageBuilder: (context, state) {
              return const MaterialPage(child: CategorySelectionScreen());
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.categoryRouteName,
            path: MyAppRouteConstants.categoryRouteName,
            pageBuilder: (context, state) {
              return MaterialPage(
                child: CategoryPage(
                  data: state.extra,
                ),
              );
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.newsRouteName,
            path: MyAppRouteConstants.newsRouteName,
            pageBuilder: (context, state) {
              return MaterialPage(
                child: NewsPage(
                  id: state.extra,
                ),
              );
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.favoriteRouteName,
            path: MyAppRouteConstants.favoriteRouteName,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: FavoritePage(),
              );
            },
          ),
          GoRoute(
            name: MyAppRouteConstants.searchRouteName,
            path: MyAppRouteConstants.searchRouteName,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: SearchPage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: MyAppRouteConstants.authRouteName,
        name: MyAppRouteConstants.authRouteName,
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginPage());
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );
}
