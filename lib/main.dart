import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'dashboard_user.dart';
import 'geo_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Headless Browser',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialBinding: BindingsBuilder(() {
        Get.put(GeoController());
      }),
      // home: const HomePage(),
      // home: const WebViewPage(),
      home: DashBoardUser(),
      // home: const GoogleMapPage(),
    );
  }
}
