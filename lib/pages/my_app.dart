import 'package:flutter/material.dart';
import 'package:newapp/model/category_model.dart';
import 'package:newapp/provider/category_provider.dart';
import 'package:newapp/provider/news_provider.dart';
import 'package:newapp/provider/theme_provider.dart';
import 'package:newapp/router/app_route_config.dart';
import 'package:newapp/utils/share.dart';
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
          create: (context) => CategoryProvider()..getDataFormSha(),
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
          return App(
            value: value,
          );
        },
      ),
    );
  }
}

class App extends StatefulWidget {
  ThemeProvider value;
  App({
    super.key,
    required this.value,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      List<int> data = context.read<CategoryProvider>().listCategoryChoose;
      print(data);
      await SharereferenceApp.saveListData('demo', data);
    }
    if (state == AppLifecycleState.resumed) {
      var result = await SharereferenceApp.getListData('demo');
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: MyAppRouter.router,
      theme: widget.value.themeMode == ThemeModeEnum.Dark
          ? ThemeData.dark()
          : ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: widget.value.themeMode == ThemeModeEnum.Dark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
