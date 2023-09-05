import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/model/category_model.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/pages/home/widget/nav_bar.dart';
import 'package:newapp/provider/category_provider.dart';
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
  Widget build(BuildContext context) {
    print('dsadsa');
    return Scaffold(
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
      ),
      drawer: const NavBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          children: [
            StreamBuilder(
              stream: Provider.of<CategoryProvider>(context).categoryStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                List<CategoryModel> dataCategory =
                    snapshot.data as List<CategoryModel>;
                return Column(
                  children: List.generate(
                    dataCategory.length,
                    (index) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dataCategory[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.goNamed(
                                    MyAppRouteConstants.categoryRouteName,
                                    extra: {
                                      'categoryid': dataCategory[index].id,
                                      'tiltle': dataCategory[index].name,
                                    });
                              },
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.amber,
                                ),
                              ),
                            )
                          ],
                        ),
                        FutureBuilder(
                          future: Provider.of<CategoryProvider>(context)
                              .getNewsCate(dataCategory[index].id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<NewsModel> data =
                                snapshot.data as List<NewsModel>;
                            return SizedBox(
                              height: 4 * (120 + 10),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      context.goNamed(
                                          MyAppRouteConstants.newsRouteName,
                                          extra: {"id": data[index].id});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 20),
                                      width: double.infinity,
                                      height: 120,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                            child: Image.network(
                                              data[index].thumb,
                                              width: 150,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index].title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  data[index].description,
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  data[index].publish_date,
                                                  style: const TextStyle(
                                                    color: Colors.indigo,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        data[index]
                                                            .toggleIsFavorite();
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: data[index]
                                                                .isFavorite
                                                            ? Colors.red
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
