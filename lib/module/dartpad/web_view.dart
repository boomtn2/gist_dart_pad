import 'dart:async';
import 'package:dartpad_code_mobile/share/color.dart';
import 'package:dartpad_code_mobile/share/model/gist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DartPadWebView extends StatefulWidget {
  const DartPadWebView({super.key, required this.gist});
  final Gist? gist;
  @override
  State<DartPadWebView> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<DartPadWebView> {
  StreamController<int> _process = StreamController<int>();
  final controller = WebViewController();
  void configWebView(WebViewController controller) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            _process.sink.add(progress);
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('WebView is onPageStarted (progress : $url%)');
          },
          onPageFinished: (String url) {
            debugPrint('WebView is onPageFinished (progress : $url%)');
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configWebView(controller);
    if (widget.gist == null) {
      controller.loadRequest(
          Uri.parse('https://dartpad.dev/embed-flutter_showcase.html'));
    } else {
      controller.loadRequest(Uri.parse(
          'https://dartpad.dev/embed-flutter_showcase.html?id=${widget.gist?.id}'));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.clearCache();
    controller.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          title: Text("DEV TOOL"),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.getData('text/plain').then((value) {
                  print(value?.text);
                });
              },
              child: Card(
                color: Colors.red,
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Center(
                    child: Text("Gist"),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Stack(children: [
          WebViewWidget(controller: controller),
          StreamBuilder(
            stream: _process.stream,
            builder: (context, snapshot) => Visibility(
              visible: snapshot.data == 100 ? false : true,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Center(
                  child: CircularPercentIndicator(
                    animation: true,
                    radius: 60.0,
                    lineWidth: 10.0,
                    percent: snapshot.data != null ? snapshot.data! / 100 : 0,
                    center: Text(
                      "${snapshot.data}%",
                      style: TextStyle(color: Colors.white),
                    ),
                    progressColor: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
