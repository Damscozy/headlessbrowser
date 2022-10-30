// ignore_for_file: must_be_immutable, unnecessary_null_comparison, deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import '../controller/geo_controller.dart';

class MeruWebViewPage extends StatefulWidget {
  final TextEditingController? pickupAddress;
  final TextEditingController? deliveryAddress;
  // Rx<AutocompletePrediction?>? selectedPickUpAddress;
  // Rx<AutocompletePrediction?>? selectedDeliveryAddress;

  String? selectedPickUpAddress;
  String? selectedDeliveryAddress;

  MeruWebViewPage({
    super.key,
    this.selectedPickUpAddress,
    this.selectedDeliveryAddress,
    this.pickupAddress,
    this.deliveryAddress,
  });

  @override
  State<MeruWebViewPage> createState() => _MeruWebViewPageState();
}

class _MeruWebViewPageState extends State<MeruWebViewPage> {
  final GeoController geocontroller = Get.find();
  bool isLoading = true;

  Timer? timer;
  final _key = UniqueKey();
  WebViewController? controller;

  String baseUrl = 'https://m.uber.com/looking';
  String baseUrl2 = 'https://www.meru.in/';
  String tripUrl = '''https://m.uber.com/looking?
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
// &vehicle=2090''';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    // geocontroller.generatePickUpRequest();
    // geocontroller.generateDroppOffRequest();
    if (kDebugMode) {
      print(
        'Selected Right Abi: ${widget.selectedPickUpAddress}',
      );
    }
  }

  Future getWebsiteData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (kDebugMode) {
        print('URL RESPONSE ${response.body}');
      }
      if (response.statusCode != null) {
        dom.Document html = dom.Document.html(response.body);

        final allData = html
            .querySelectorAll('_css-hWGanL')
            .map((element) => element.innerHtml.trim())
            .toList();
        if (kDebugMode) {
          print('URL RESPONSE $allData');
        }
        return allData;
      } else {
        Get.snackbar('Error', 'Unable to load url');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> fillField() async {
    Future.delayed(const Duration(seconds: 2), () async {
      controller!.evaluateJavascript(
          "document.getElementById('pickup_outstation').value='${widget.selectedPickUpAddress}'");
      controller!.evaluateJavascript(
          "document.getElementById('drop_outstation').value='${widget.selectedDeliveryAddress}'");
      await Future.delayed(const Duration(milliseconds: 2000));
      await controller!.evaluateJavascript(
          "document.getElementsByClassName('row g-2).submit()");
      // await controller!.evaluateJavascript("document.forms[0].submit()");
    });
  }

  @override
  Widget build(BuildContext context) {
    String webUrl = baseUrl2;

    return Scaffold(
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              String? url = await controller!.currentUrl();
              if (url == baseUrl) {
                return true;
              } else {
                controller!.goBack();
                return false;
              }
            },
            child: Builder(builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: WebView(
                  key: _key,
                  // initialUrl: "https://m.uber.com/looking",
                  initialUrl: webUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                    fillField();
                  },
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  onPageStarted: (String url) {
                    fillField();
                    // if (url.contains('book.meru.in')) {
                    // timer = Timer.periodic(
                    //   const Duration(seconds: 5),
                    //   (_) => fillField(),
                    // );
                    // }
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
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(CupertinoIcons.refresh),
      //   onPressed: () async {
      //     controller!.runJavascript(
      //         "document.getElementById('pickup_outstation').value='${widget.selectedPickUpAddress!}'");
      //     controller!.runJavascript(
      //         "document.getElementById('drop_outstation').value='${widget.selectedDeliveryAddress!}'");
      //     await Future.delayed(const Duration(seconds: 1));
      //     // controller!.runJavascript(
      //     //     "document.getElementById('book_now_outstation').value='${widget.selectedDeliveryAddress!}'");
      //     // await controller!.runJavascript("document.forms[0].submit()");
      //     await controller!.runJavascript(
      //         "document.getElementById('book_now_outstation).submit()");
      //   },
      // ),
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