import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/provider/news_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var data =
        Provider.of<NewsProvider>(context, listen: false).getNewsWithFavorite();
    print(data);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context
                .go(MyAppRouteConstants.homeRouteName); // Điều hướng quay lại
          },
        ),
      ),
      body: Stack(children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(index),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Xóa yêu thích'),
                      content: const Text('Bạn có chắc chắn muốn xóa?'),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Không'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Có'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                data[index].handleRemoveIsFavorite();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/product', arguments: {
                      "id": data[index].id,
                      "categoryId": data[index].id,
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.white60,
                        trailing: const Icon(
                          Icons.swipe,
                          size: 25,
                        ),
                        subtitle: Text(
                          data[index].title,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          data[index].thumb,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Delete All'),
            ),
          ),
        ),
      ]),
    );
  }
}
