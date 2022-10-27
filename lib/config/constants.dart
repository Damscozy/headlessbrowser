// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'app_theme.dart';

const String GoogleMapAPI = 'AIzaSyBSpuWgsUzRBCDT-i0jTl0onCFCKRjbX6o';

OutlineInputBorder appInputOutlineBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: AppTheme.containerlightColor,
        width: 3.0,
      ),
    );

kErrorSnakBar(String error, {String? title}) {
  Get.snackbar(
    title ?? 'Error!',
    error,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
  );
}

kSuccessSnakBar(String msg, {String? title}) {
  Get.snackbar(
    title ?? 'Success!',
    msg,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
  );
}

LatLng getLatLngFromGeoPoint(Map<String, dynamic> doc) {
  return LatLng(
    doc['geopoint'].latitude,
    doc['geopoint'].longitude,
  );
}

String getDistance(LatLng start, LatLng end) {
  return (Geolocator.distanceBetween(
              start.latitude, start.longitude, end.latitude, end.longitude) /
          1000)
      .toStringAsFixed(1);
}

Future sendHttpNotification(
    {String? token,
    String? title,
    String? body,
    Map<String, dynamic>? data}) async {
  try {
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAu7SwJSU:APA91bHVVOEWKIG-mm06w75dSvO4hUc_I4aJ9TAGF2IXynK-_uxuNxOml_x-Za5ysyjPYpwUqcl-UGO-VDwVMsztwpjwsZRTHJxXld9JgsAwZQAfRcEZ_2oWb_i1kgUYC5h5qrpJ_Wa5',
      },
      body: jsonEncode({
        'registration_ids': [token],
        'data': data,
        'notification': {
          'title': '$title',
          'body': '$body',
          "sound": "default"
        },
      }),
    );
    Logger().i(response.body);
  } catch (e) {
    rethrow;
  }
}
