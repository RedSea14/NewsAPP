import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/provider/category_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeItems extends StatelessWidget {
  HomeItems({super.key, required this.idCategory});
  int idCategory;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            context.read<CategoryProvider>().getAllNewsInCategory(idCategory),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasError) return Container();
          List<NewsModel> data = snapshot.data as List<NewsModel>;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data[0].category['name'],
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.goNamed(MyAppRouteConstants.categoryRouteName,
                          extra: {
                            'categoryid': idCategory,
                            'tiltle': data[0].category['name'],
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
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: AspectRatio(
                        aspectRatio: 3 / 1,
                        child: InkWell(
                          onTap: () {
                            context.goNamed(MyAppRouteConstants.newsRouteName,
                                extra: {"id": data[index].id});
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(data[index].thumb),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].title,
                                      overflow: TextOverflow.ellipsis,
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
                                      overflow: TextOverflow.ellipsis,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            ],
          );
        });
  }
}
