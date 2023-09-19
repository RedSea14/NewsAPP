import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/provider/news_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    Provider.of<NewsProvider>(context, listen: false).getDataArticle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleOnChange(value) {
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer(const Duration(seconds: 1), () {
      Provider.of<NewsProvider>(context, listen: false).getArticleByName(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm Kiếm'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                focusedBorder: inputborder(),
                enabledBorder: inputborder(),
                disabledBorder: inputborder(),
                hintText: 'Tìm kiếm',
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: handleOnChange,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(child: Consumer<NewsProvider>(
                builder: (context, data, child) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.listNews.length,
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
                                    context.goNamed(
                                        MyAppRouteConstants.newsRouteName,
                                        extra: {"id": data.listNews[index].id});
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  data.listNews[index].thumb),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.listNews[index].title,
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
                                              data.listNews[index].description,
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
                                              data.listNews[index].publish_date,
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
                },
              )),
            )
          ],
        ),
      ),
    );
  }

  OutlineInputBorder inputborder() => const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
      );
}
