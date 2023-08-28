import 'package:flutter/material.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/provider/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  late Future listNewCategory;
  @override
  void didChangeDependencies() {
    listNewCategory =
        Provider.of<CategoryProvider>(context).getNewsCate(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: FutureBuilder(
          future: listNewCategory,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<NewsModel> data = snapshot.data as List<NewsModel>;
            return ListView.separated(
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(right: 20),
                  width: 200,
                  height: 100,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        child: Image.network(
                          data[index].thumb,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
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
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}