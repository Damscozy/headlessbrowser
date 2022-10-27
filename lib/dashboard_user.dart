import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:headlessbrowser/bottom_components/dashboard_user_bottom.dart';

import 'controller/home_controller.dart';
import 'controller/request_controller.dart';
import 'geo_controller.dart';

class DashBoardUser extends StatelessWidget {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final controller = Get.put(RequestController());
  final homeController = Get.put(HomeController());

  DashBoardUser({super.key});
  @override
  Widget build(BuildContext context) {
    return homeController.obx(
      (state) => Scaffold(
        key: _scaffoldkey,
        // drawer: HomeDrawer(),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  GeoController.to.currentPosition!.latitude,
                  GeoController.to.currentPosition!.longitude,
                ),
                zoom: 17,
              ),
              myLocationEnabled: true,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 50,
            //     width: 50,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Colors.white,
            //     ),
            //     child: IconButton(
            //       icon: const Icon(Icons.menu),
            //       onPressed: () {
            //         _scaffoldkey.currentState!.openDrawer();
            //       },
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() => IndexedStack(
                    index: controller.bottomSheetIndex.value,
                    alignment: Alignment.bottomCenter,
                    children: const [
                      DashboardUserBottom(),
                      // ResultScreen(),
                      // DeliveryDetails(),
                      // LoadDetails(),
                      // PaymentOption(),
                      // PickupTime()
                    ],
                  )),
            ),
          ],
        ),
      ),
      onError: (error) => Material(
        child: Center(
          child: Text(error!),
        ),
      ),
    );
  }
}
