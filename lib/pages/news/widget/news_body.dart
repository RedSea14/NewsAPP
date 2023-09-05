import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/pages/news/widget/custom_tag.dart';

class NewsBody extends StatefulWidget {
  const NewsBody({
    Key? key,
    required this.news,
  }) : super(key: key);

  final NewsModel news;

  @override
  State<NewsBody> createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  @override
  Widget build(BuildContext context) {
    bool change = false;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomTag(
                backgroundColor: Colors.black,
                children: [
                  const CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(
                      ('https://vtv1.mediacdn.vn/zoom/640_400/2020/8/7/john-wick-phim-truyen-hinh-15967830203341040641259.jpg'),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.news.author,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              CustomTag(
                backgroundColor: Colors.grey.shade200,
                children: [
                  const Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    DateFormat('MMMM dd, yyyy')
                        .format(DateTime.parse(widget.news.publish_date)),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              CustomTag(
                backgroundColor: Colors.grey.shade200,
                children: const [
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              CustomTag(
                backgroundColor: Colors.grey.shade200,
                children: [
                  InkWell(
                    onTap: () {
                      widget.news.toggleIsFavorite();
                      setState(() {
                        change = !change;
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: widget.news.isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            widget.news.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            widget.news.content,
            textAlign: TextAlign.justify,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
