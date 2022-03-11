import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Webview extends StatelessWidget {
  final String url;
  const Webview({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(url),
      ),
      body: WebView(
        initialUrl: url,
        zoomEnabled: true,
        allowsInlineMediaPlayback: true,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
