import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatefulWidget {
  final String openUrl;
  const NewsDetailScreen({super.key, required this.openUrl});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  String? finalUrl;
  WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    finalUrl = widget.openUrl;
    if (widget.openUrl.contains('http://')) {
      finalUrl = widget.openUrl.replaceAll('http://', 'https://');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('News Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WebViewWidget(
                controller: webViewController
                  ..loadRequest(
                    Uri.parse(finalUrl.toString()),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
