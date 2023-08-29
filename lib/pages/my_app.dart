import 'package:flutter/material.dart';
import 'package:newapp/provider/category_provider.dart';
import 'package:newapp/provider/news_provider.dart';
import 'package:newapp/provider/theme_provider.dart';
import 'package:newapp/router/app_route_config.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: MyAppRouter.router,
            theme: value.themeMode == ThemeModeEnum.Dark
                ? ThemeData.dark()
                : ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: value.themeMode == ThemeModeEnum.Dark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
