// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;

import 'config/constants.dart';

class GeoController extends GetxController {
  static GeoController get to => Get.find();
  RxBool serviceEnabled = false.obs;
  Rx<AutocompletePrediction?> pickLocation = Rx(null);
  Rx<AutocompletePrediction?> dropOffLocation = Rx(null);
  Rx<String?> currentAddress = Rx(null);

  final Rx<Position?> _currentPosition = Rx(null);
  Position? get currentPosition => _currentPosition.value;

  final Rx<String?> _pickUpAddress = Rx(null);
  String? get pickUpAddress => _pickUpAddress.value;

  LatLng? _pickupPosition;
  LatLng? _destinationPosition;

  LatLng? get pickUpPosition => _pickupPosition;
  LatLng? get destinationPosition => _destinationPosition;

  @override
  void onReady() {
    super.onReady();
  }

Future generateRequest()async{
final pickupLatlng=await getLatLngFromAddress(pickLocation.value!.description!);
final dropoffLatlng=await getLatLngFromAddress(dropOffLocation.value!.description!);





}

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    serviceEnabled.value = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled.value) {
      await Geolocator.openLocationSettings();
      // throw ('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        kErrorSnakBar('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      kErrorSnakBar(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _currentPosition(await Geolocator.getCurrentPosition());
    return _currentPosition.value;
  }

  Future<String?> setPickUpAdrress() async {
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
      _pickupPosition!.latitude,
      _pickupPosition!.longitude,
    );
    geo.Placemark placemark = placemarks[0];
    if (kDebugMode) {
      print("Pick up address is ${placemarks.toString()}");
    }
    String pickUpAddress =
        "${placemark.name}, ${placemark.administrativeArea} ${placemark.locality}";

    _pickUpAddress(pickUpAddress);
    return pickUpAddress;
  }

  void getCurrentAddress() {
    Geolocator.requestPermission().then((value) {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((value) async {
          _currentPosition(value);
          _pickupPosition = LatLng(value.latitude, value.longitude);
          final re = await setPickUpAdrress();
          currentAddress(re);
          if (kDebugMode) {
            print(
                "current location is ${value.latitude} and longitude is ${value.longitude} ");
          }
        });
      }
    });
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$GoogleMapAPI";
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final value = json['results'][0];
        final latlng = LatLng(value['geometry']['location']['lat'],
            value['geometry']['location']['lng']);

        if (kDebugMode) {
          print("location route result ${response.body}");
        }
        return latlng;
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    }

    return null;
  }
}
