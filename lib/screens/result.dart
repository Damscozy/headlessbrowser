// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:headlessbrowser/config/app_theme.dart';
import 'package:headlessbrowser/controller/request_controller.dart';
import 'package:headlessbrowser/customWidget/cab_textfield.dart';
import 'package:headlessbrowser/geo_controller.dart';
import 'package:headlessbrowser/uberwebview.dart';

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

  int selectedIndex = -1;
  bool isSelected = false;

  List<String> tripType = [
    'BIKE',
    'AUTO',
    'CAR',
    'SUV',
  ];

  List<String> amountList = [
    '₹10',
    '₹24',
    '₹15',
    '₹18',
  ];

  List<String> rideAmount = [
    '₹30',
    '₹58',
    '₹45',
    '₹72',
  ];

  List<String> rideTitle = [
    'UberX',
    'Uber Go',
    'Uber Go Sedan',
    'Uber Express',
  ];

  List<String> rideDesc = [
    'Affordable rides, all to yourself',
    'Affordable compact rides',
    'Affordable Sedan rides',
  ];

  @override
  void initState() {
    super.initState();
    geocontroller.getCurrentAddress();
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
              // const SizedBox(height: 10),
              // Text(widget.selectedPickUpAddress.value!.description!),
              // Text(geocontroller.currentPosition!.latitude.toString()),

              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // final random = Random();
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: InkWell(
                        onTap: () {
                          setState(() {});
                          setState(() {
                            selectedIndex = index;
                          });
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: Vehicle(
                          title: tripType[index],
                          amount: amountList[index],
                          color: selectedIndex == index
                              ? Colors.deepPurple
                              : Colors.white,
                          index: index,
                          selectedIndex: selectedIndex,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     vehicle('BIKE', '₹10'),
              //     vehicle('AUTO', '₹24'),
              //     vehicle('CAR', '₹15'),
              //     vehicle('SUV', '₹18'),
              //   ],
              // ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final random = Random();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RideWidget(
                        assetImage: 'assets/images/uber.png',
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
                    onTap: () {
                      if (geocontroller.pickLocation.value == null) {
                        Get.snackbar('Error', 'Please select pickuplocation');
                        return;
                      } else if (geocontroller.dropOffLocation.value == null) {
                        Get.snackbar(
                            'Error', 'Please select drop off location');
                        return;
                      }
                      // controller.bottomSheetIndex++;
                      Get.to(
                        () => WebViewPage(
                          pickupAddress: widget.pickupAddress,
                          deliveryAddress: widget.deliveryAddress,
                          selectedPickUpAddress: geocontroller.pickLocation,
                          selectedDeliveryAddress: geocontroller.dropOffLocation,
                        ),
                      );
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