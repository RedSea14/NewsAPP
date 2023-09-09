import 'package:flutter/material.dart';
import 'package:newapp/model/news_model.dart';
import 'package:newapp/provider/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        NewsModel data = snapshot.data as NewsModel;
        final controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000));
        if (data.link.contains('#')) {
          // Load a custom HTML error page for 404 errors.
          controller.loadRequest(Uri.parse('http://example.com/error.html'));
        } else {
          controller.setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {
                if (error.errorCode == 404) {
                  // Load your custom error page when a 404 error occurs
                }
              },
            ),
          );

          controller.loadRequest(Uri.parse(data.link));
        }
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context); // Điều hướng quay lại
                },
              ),
            ),
            body: WebViewWidget(controller: controller));
      },
    );
  }
}
