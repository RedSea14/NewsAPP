import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/pages/news/widget/custom_tag.dart';
import 'package:newapp/pages/news/widget/new_headline.dart';
import 'package:newapp/pages/news/widget/news_body.dart';
import 'package:newapp/provider/news_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewsPage extends StatefulWidget {
  NewsPage({super.key, required this.id});
  var id;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<NewsProvider>().getNewsById(widget.id['id']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        NewsModel data = snapshot.data as NewsModel;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go(
                    MyAppRouteConstants.homeRouteName); // Điều hướng quay lại
              },
            ),
          ),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.thumb),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                NewsHeadline(news: data),
                NewsBody(news: data),
              ],
            ),
          ),
        );
      },
    );
  }
}
