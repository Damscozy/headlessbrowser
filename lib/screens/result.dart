// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                          selectedPrediction: controller.pickLocation,
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
                          selectedDropPrediction: controller.dropOffLocation,
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
              const SizedBox(height: 10),
              Text(widget.selectedPickUpAddress.value!.description!),
              Text(geocontroller.currentPosition!.latitude.toString()),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.pickLocation.value == null) {
                        Get.snackbar('Error', 'Please select pickuplocation');
                        return;
                      } else if (controller.dropOffLocation.value == null) {
                        Get.snackbar(
                            'Error', 'Please select drop off location');
                        return;
                      }
                      // controller.bottomSheetIndex++;
                      Get.to(
                        () => WebViewPage(
                          pickupAddress: widget.pickupAddress,
                          deliveryAddress: widget.deliveryAddress,
                          selectedPickUpAddress: controller.pickLocation,
                          selectedDeliveryAddress: controller.dropOffLocation,
                        ),
                      );
                    },
                    child: Text(
                      "Search",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: AppTheme.btnColor,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  vehicle('BIKE', '\$10'),
                  vehicle('AUTO', '\$24'),
                  vehicle('CAR', '\$15'),
                  vehicle('SUV', '\$18'),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/uber.png',
                      ),
                      title: const Text('UberX'),
                      subtitle: const Text('Affordable rides, all to yourself'),
                      trailing: const Text('9 mins'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Column vehicle(String title, String amount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Text(title),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(amount),
      ],
    );
  }
}


//https://m.uber.com/looking?drop%5B0%5D=%7B%22latitude%22%3A6.5919949%2C%22longitude%22%3A3.3946511%2C%22addressLine1%22%3A%2211%20Oriola%20St%22%2C%22addressLine2%22%3A%22Ketu%20105102%2C%20Lagos%22%2C%22id%22%3A%22ChIJH3mBi-uSOxARvwghxyn3OpI%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&pickup=%7B%22latitude%22%3A6.601838%2C%22longitude%22%3A3.3514863%2C%22addressLine1%22%3A%22Ikeja%22%2C%22addressLine2%22%3A%22Nigeria%22%2C%22id%22%3A%22ChIJmTkq-iiSOxAR8KG73UsyqNc%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&vehicle=2090