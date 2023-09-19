import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/pages/home/widget/home_category_items.dart';
import 'package:newapp/pages/home/widget/nav_bar.dart';
import 'package:newapp/provider/category_provider.dart';
import 'package:newapp/provider/theme_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<ThemeProvider>().keyDrawer,
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'NEWS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.goNamed(MyAppRouteConstants.searchRouteName);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: const NavBar(),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Consumer<CategoryProvider>(
            builder: (context, value, child) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.listCategoryChoose.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return HomeItems(
                    idCategory: value.listCategoryChoose[index],
                  );
                },
              );
            },
          )),
    );
  }
}
