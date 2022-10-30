// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:math';

import 'package:ekcab/config/app_theme.dart';
import 'package:ekcab/controller/geo_controller.dart';
import 'package:ekcab/controller/request_controller.dart';
import 'package:ekcab/customWidget/cab_textfield.dart';
import 'package:ekcab/model/ridemodel.dart';
import 'package:ekcab/screens/scrapping.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';

import 'meruwebview.dart';

// The Taj Mahal Palace, Mumbai, Apollo Bandar, Colaba, Mumbai, Maharashtra, India
class ResultScreen extends StatefulWidget {
  final TextEditingController? pickupAddress;
  final TextEditingController? deliveryAddress;
  Rx<AutocompletePrediction?> selectedPickUpAddress;
  Rx<AutocompletePrediction?> selectedDeliveryAddress;

  ResultScreen({
    super.key,
    required this.selectedPickUpAddress,
    required this.selectedDeliveryAddress,
    this.pickupAddress,
    this.deliveryAddress,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final RequestController controller = Get.find();
  final GeoController geocontroller = Get.find();

  bool isLoading = false;
  int selectedIndex = -1;
  bool isSelected = false;

  String baseUrl = 'https://m.uber.com/looking';
  String baseUrl2 = 'https://book.meru.in/airport';

  List<RideModel> rides = [];
  List<String> allData = [];

  List<String> tripType = [
    'BIKE',
    'AUTO',
    'CAR',
    'SUV',
  ];

  List<String> rideAmount = [
    '₹312.12',
    '₹306.30',
    '₹381.90',
    '₹392.32',
  ];

  List<String> rideTitle = [
    'UberX',
    'Uber Go Premier',
    'Uber Go Sedan',
    'Uber Express',
  ];

  List<String> rideDesc = [
    'Affordable rides, all to yourself',
    'Affordable compact rides',
    'Affordable car rides',
    'Affordable Sedan rides',
  ];

  final webScraper = WebScraper('https://book.meru.in');
  List<Map<String, dynamic>>? productNames;
  late List<Map<String, dynamic>> productDescriptions;

  Future<void> getData() async {
    rides.clear();
    isLoading = true;
    setState(() {});
    final html = await getWebsiteData();
    if (html != null) rides = ScraperService.run(html);
    isLoading = false;
    setState(() {});
  }

  Future getWebsiteData() async {
    try {
      // final response = await http.get(Uri.parse(baseUrl));
      // if (kDebugMode) {
      //   print('BODY RESPONSE ${response.body}');
      // }
      var url = Uri.parse('https://book.meru.inf');
      var response = await http.get(url);
      // BeautifulSoup bs = BeautifulSoup(response.body);
      // final allHeaderName =
      //     bs.findAll('div', attrs: {'class': 'cabs_brand_list'});
      // // bs.findAll('div', attrs: {'class': 'show_cab_list_current'});
      // // if (kDebugMode) {
      // //   // print('the header url: $url');
      // //   print('the bs header: $bs');
      // //   print('the header res2: ${response.body}');
      // //   print('the header: ${bs.text}');
      // // }
      // for (var element in allHeaderName) {
      //   if (kDebugMode) {
      //     print('the header element: ${element.text}');
      //   }
      // }
      if (response.statusCode != null) {
        dom.Document html = dom.Document.html(response.body);

        final content = html.getElementsByClassName('show_cab_list_current');
        allData = content
            .map((e) => e.getElementsByTagName('span')[0].innerHtml.trim())
            .toList();

        // final allData = html
        //     .querySelectorAll('brand_names')
        //     .map((element) => element.innerHtml.trim())
        //     .toList();
        if (kDebugMode) {
          print('URL RESPONSE $allData');
        }
        return allData;
      } else {
        Get.snackbar('Error', 'Unable to load url');
      }
    } catch (e) {
//
    }
    return null;
  }

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/airport')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        productNames =
            webScraper.getElement('div.show_cab_list_current', ['img']);
        productDescriptions = webScraper.getElement(
            'div.thumbnail > div.caption > p.description', ['class']);
        if (kDebugMode) {
          print('Product Name $productNames');
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWebsiteData();
    // fetchProducts();
    // getData();
    // geocontroller.getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.radio_button_checked_sharp,
                          color: AppTheme.primaryColr,
                        ),
                        Container(
                          width: 3,
                          height: Get.height / 15,
                          color: AppTheme.containerlightColor,
                        ),
                        const Icon(
                          Icons.pin_drop,
                          color: AppTheme.primaryColr,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        PickUpField(
                          description: 'Select Pick-Up Location',
                          initialValue: "Current Location",
                          selectedPrediction: geocontroller.pickLocation,
                          label: 'Select Pick-Up Location',
                          fillColor: const Color(0xffEAE8F1),
                          controller: widget.pickupAddress,
                          enableColor: AppTheme.btnColor,
                          onChanged: (v) {
                            // .text=v;
                            //   controller.searchAddress(v);
                          },
                        ),
                        const SizedBox(height: 10),
                        DropOffField(
                          description: 'Destination',
                          initialValue: "Destination ",
                          selectedDropPrediction: geocontroller.dropOffLocation,
                          label: 'Select Destination Address',
                          fillColor: const Color(0xffEAE8F1),
                          controller: widget.deliveryAddress,
                          enableColor: AppTheme.btnColor,
                          onChanged: (v) {
                            // _defaultPickControlller.text=v;
                            //   controller.searchAddress(v);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  // itemCount: rides.length < 3 ? rides.length : 1,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final random = Random();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RideWidget(
                        assetImage: 'assets/images/uber.png',
                        // rideTitle: rides[index].rideTitle,
                        // amount: rides[index].rideAmount,
                        rideTitle: rideTitle[random.nextInt(rideTitle.length)],
                        description: rideDesc[random.nextInt(rideDesc.length)],
                        amount: rideAmount[random.nextInt(rideAmount.length)],
                        rideTime: '9 mins',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (geocontroller.pickLocation.value == null) {
                        Get.snackbar('Error', 'Please select pickuplocation');
                        return;
                      } else if (geocontroller.dropOffLocation.value == null) {
                        Get.snackbar(
                            'Error', 'Please select drop off location');
                        return;
                      }
                      // await getWebsiteData();
                      // fetchProducts();
                      // controller.bottomSheetIndex++;

                      Get.to(
                        () => MeruWebViewPage(
                          pickupAddress: widget.pickupAddress,
                          deliveryAddress: widget.deliveryAddress,
                          selectedPickUpAddress: geocontroller
                              .pickLocation.value!.description!
                              .toString(),
                          selectedDeliveryAddress: geocontroller
                              .dropOffLocation.value!.description!
                              .toString(),
                        ),
                      );
                      // Get.to(
                      //   () => UberWebViewPage(
                      //     pickupAddress: widget.pickupAddress,
                      //     deliveryAddress: widget.deliveryAddress,
                      //     selectedPickUpAddress: geocontroller
                      //         .pickLocation.value!.description!
                      //         .toString(),
                      //     selectedDeliveryAddress: geocontroller
                      //         .dropOffLocation.value!.description!
                      //         .toString(),
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Use Uber",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: AppTheme.bgColor,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class Vehicle extends StatelessWidget {
  String? title;
  String? amount;
  Color? color;
  int index;
  int selectedIndex;
  Vehicle({
    Key? key,
    required this.title,
    required this.amount,
    required this.color,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Text(
            title!,
            style: GoogleFonts.inter(
              color: selectedIndex == index ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(amount!),
      ],
    );
  }
}

class RideWidget extends StatelessWidget {
  String? assetImage;
  String? rideTitle;
  String? description;
  String? rideTime;
  String? amount;
  RideWidget({
    Key? key,
    this.assetImage,
    this.rideTitle,
    this.description,
    this.rideTime,
    this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        assetImage!,
      ),
      title: Text(rideTitle!),
      subtitle: Text(description!),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount!,
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            rideTime!,
          ),
        ],
      ),
    );
  }
}


//https://m.uber.com/looking?drop%5B0%5D=%7B%22latitude%22%3A6.5919949%2C%22longitude%22%3A3.3946511%2C%22addressLine1%22%3A%2211%20Oriola%20St%22%2C%22addressLine2%22%3A%22Ketu%20105102%2C%20Lagos%22%2C%22id%22%3A%22ChIJH3mBi-uSOxARvwghxyn3OpI%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&pickup=%7B%22latitude%22%3A6.601838%2C%22longitude%22%3A3.3514863%2C%22addressLine1%22%3A%22Ikeja%22%2C%22addressLine2%22%3A%22Nigeria%22%2C%22id%22%3A%22ChIJmTkq-iiSOxAR8KG73UsyqNc%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&vehicle=2090