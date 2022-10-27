// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'geo_controller.dart';

class WebViewPage extends StatefulWidget {
  final TextEditingController? pickupAddress;
  final TextEditingController? deliveryAddress;
  Rx<AutocompletePrediction?> selectedPickUpAddress;
  Rx<AutocompletePrediction?> selectedDeliveryAddress;

  WebViewPage({
    super.key,
    required this.selectedPickUpAddress,
    required this.selectedDeliveryAddress,
    this.pickupAddress,
    this.deliveryAddress,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final GeoController geocontroller = Get.find();
  bool isLoading = true;
  final _key = UniqueKey();
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    getAddress();
  }

  Future getAddress() async {
    final pickupLatlng = await geocontroller
        .getLatLngFromAddress(widget.selectedPickUpAddress.value!.description!);
    final dropupLatlng = await geocontroller.getLatLngFromAddress(
      widget.selectedDeliveryAddress.value!.description!,
    );
  }

  Future getWebsiteData() async {
    final scrapingUrl = Uri.parse('https://m.uber.com/looking');
    final response = await http.get(scrapingUrl);
    dom.Document html = dom.Document.html(response.body);

    final amount = html
        .querySelectorAll(
            '#wrapper > div._css-dqxzrQ > div > div._css-kfqtxL > div._css-bOmAYR > div > span > div > div._css-hWGanL > div > div._css-fUcHoI > div._css-jceiuG > h6:nth-child(2)')
        .map((element) => element.innerHtml.trim())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    String url =
        'https://m.uber.com/looking?drop=${widget.selectedDeliveryAddress.value!.description!}&pickup=${widget.selectedPickUpAddress.value!.description!}';

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              String? url = await controller!.currentUrl();
              if (url ==
                  'https://m.uber.com/looking?drop=${widget.selectedDeliveryAddress.value!.description!}&pickup=${widget.selectedPickUpAddress.value!.description!}') {
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
                  // initialUrl: "https://m.uber.com/looking",
                  initialUrl: url,
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
                      print(
                          'Locations are DropOff: ${widget.selectedDeliveryAddress.value!.description!} Pickup: ${widget.selectedPickUpAddress.value!.description!}');
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

// https://m.uber.com/looking?
// drop%5B0%5D=%7B%22latitude%22%3A6.587957599999999%2C%22
// ongitude%22%3A3.3793792%2C%22
// addressLine1%22%3A%22Ojota%20Bus%20Stop%22%2C%22
// addressLine2%22%3A%22Ikorodu-Ososun%20Road%2C%20Lagos%2C%20Nigeria%22%2C%22
// id%22%3A%22ChIJRat_4H-TOxARSDIv-dBCyn4%22%2C%22provider%22%3A%22
// google_places%22%2C%22index%22%3A0%7D
// &pickup=%7B%22latitude%22%3A6.6143564%2C%22
// longitude%22%3A3.3581327%2C%22addressLine1%22%3A%22Ikeja%20City%20Mall%22%2C%22
// addressLine2%22%3A%22Obafemi%20Awolowo%20Way%2C%20Ojodu%2C%20Nigeria%22%2C%22
// id%22%3A%22ChIJFW6oW7aTOxARrcM2NPtg4Do%22%2C%22provider%22%3A%22
// google_places%22%2C%22index%22%3A0%7D
// &vehicle=2090