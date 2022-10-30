import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ekcab/config/app_theme.dart';
import 'package:ekcab/controller/geo_controller.dart';
import 'package:ekcab/controller/request_controller.dart';
import 'package:ekcab/customWidget/cab_textfield.dart';
import 'package:ekcab/screens/result.dart';

class DashboardUserBottom extends StatefulWidget {
  const DashboardUserBottom({super.key});

  @override
  State<DashboardUserBottom> createState() => _DashboardUserBottomState();
}

class _DashboardUserBottomState extends State<DashboardUserBottom> {
  final RequestController controller = Get.find();
  final GeoController geocontroller = Get.find();

  final TextEditingController _pickupAddress = TextEditingController();
  final TextEditingController _deliveryAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    geocontroller.getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Hello there!",
              //   style: Theme.of(context).textTheme.caption!.copyWith(
              //         fontWeight: FontWeight.bold,
              //       ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              Text(
                "Create a Trip",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                          initialValue: "Where from?",
                          selectedPrediction: geocontroller.pickLocation,
                          label: 'Select Pick-Up Location',
                          fillColor: const Color(0xffEAE8F1),
                          controller: _pickupAddress,
                          enableColor: AppTheme.btnColor,
                          onChanged: (v) {
                            // .text=v;
                            //   controller.searchAddress(v);
                            if (kDebugMode) {
                              print('PickUp Field $v');
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        DropOffField(
                          description: 'Destination',
                          initialValue: "Where to?",
                          selectedDropPrediction: geocontroller.dropOffLocation,
                          label: 'Select Destination Address',
                          fillColor: const Color(0xffEAE8F1),
                          controller: _deliveryAddress,
                          enableColor: AppTheme.btnColor,
                          onChanged: (v) {
                            // _defaultPickControlller.text=v;
                            //   controller.searchAddress(v);
                            if (kDebugMode) {
                              print('Destination Field $v');
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                        () => ResultScreen(
                          pickupAddress: _pickupAddress,
                          deliveryAddress: _deliveryAddress,
                          selectedPickUpAddress: geocontroller.pickLocation,
                          selectedDeliveryAddress:
                              geocontroller.dropOffLocation,
                        ),
                        transition: Transition.size,
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}


//https://m.uber.com/looking?drop%5B0%5D=%7B%22latitude%22%3A6.5919949%2C%22longitude%22%3A3.3946511%2C%22addressLine1%22%3A%2211%20Oriola%20St%22%2C%22addressLine2%22%3A%22Ketu%20105102%2C%20Lagos%22%2C%22id%22%3A%22ChIJH3mBi-uSOxARvwghxyn3OpI%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&pickup=%7B%22latitude%22%3A6.601838%2C%22longitude%22%3A3.3514863%2C%22addressLine1%22%3A%22Ikeja%22%2C%22addressLine2%22%3A%22Nigeria%22%2C%22id%22%3A%22ChIJmTkq-iiSOxAR8KG73UsyqNc%22%2C%22provider%22%3A%22google_places%22%2C%22index%22%3A0%7D&vehicle=2090