import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({
    super.key,
  });

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  bool isLoading = true;
  final _key = UniqueKey();
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://www.google.com/maps/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final amount = html
        .querySelectorAll(
            '#wrapper > div._css-dqxzrQ > div > div._css-kfqtxL > div._css-bOmAYR > div > span > div > div._css-hWGanL > div > div._css-fUcHoI > div._css-jceiuG > h6:nth-child(2)')
        .map((element) => element.innerHtml.trim())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              String? url = await controller!.currentUrl();
              if (url == "https://www.google.com/maps/") {
                return true;
              } else {
                controller!.goBack();
                return false;
              }
            },
            child: Builder(builder: (context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 40,
                  bottom: 20,
                ),
                child: WebView(
                  key: _key,
                  initialUrl: "https://www.google.com/maps/",
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onWebViewCreated: (WebViewController wc) {
                    controller = wc;
                  },
                  onPageStarted: (String url) {
                    if (kDebugMode) {
                      print('Page started loading: $url');
                    }
                  },
                ),
              );
            }),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : Container(),
          Positioned(
            top: 30,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
