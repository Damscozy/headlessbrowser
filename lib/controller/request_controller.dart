import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

class RequestController extends GetxController {
  // Rx<AutocompletePrediction?> pickLocation = Rx(null);
  // Rx<AutocompletePrediction?> dropOffLocation = Rx(null);
  RxInt bottomSheetIndex = 0.obs;
  RxString selectedLoadType = 'Agro'.obs;
  RxString selectedContainerType = 'Bulk'.obs;
  RxString selectedWeightType = 'Kilogram'.obs;
  RxString countryCode = '+234'.obs;
  Rx<DateTime> pickupTime = DateTime.now().obs;
  RxBool acceptPayment = false.obs;

  RxList<String> loadTypes = RxList<String>([]);
  RxList<String> containerTypes = RxList<String>([]);
  // static final AuthController _authController = Get.find();
  TextEditingController reciverNameController = TextEditingController();
  TextEditingController reciverContactController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  void onReady() {
    loadTypes(_loadTypes);
    containerTypes(_containerTypes);
    super.onReady();
  }

  final List<String> _loadTypes = [
    'Agro',
    'Fertilizer',
    'FMCG',
    'Foods',
    'Grocery',
    'Oil and Gas',
    'Household and Office',
    'Building Materials',
    'Electricals',
    'Equiptments',
    'Fragile',
    'Chemicals',
    'Pharmaceuticals',
    'Sacks',
  ];

  final List<String> _containerTypes = [
    'Bulk',
    'Glass Bottle',
    'Plastic Bag',
    'Plastic Bottle',
    'Carton - Small X cm (h) X cm (w)',
    'Carton - Medium X cm (h) X cm (w)',
    'Carton -Large X cm (h) X cm (w)',
    'Envelope',
    'Food - Takeout box',
    'Platform - Box Pallet',
    'Platform - Post Pallet',
    'Platform - Flat Pallet',
    'Platform - Skid',
    'Sheets - Flat',
    'Sheets - Molded',
    'Liquid Bulk',
    'Container',
    'Rack',
    'Tray',
    'Small Sack',
    'Big Sack',
  ];

  final List<String> weightTypes = [
    'Kilogram',
    'Tons',
    'cbm',
    'Liters',
  ];

  // Future setPickupLocation() async {
  //   Position position = GeoController.to.currentPosition;
  //   Get.to(() => PlacePicker(
  //         apiKey: GoogleMapAPI,
  //         onPlacePicked: (result) {
  //           pickLocation(result);
  //           Get.back();
  //         },
  //         initialPosition: LatLng(position.latitude, position.longitude),
  //         useCurrentLocation: true,
  //       ));
  // }

  // Future setDropOffLocation() async {
  //   Position position = GeoController.to.currentPosition;
  //   Get.to(() => PlacePicker(
  //         apiKey: GoogleMapAPI,
  //         onPlacePicked: (result) {
  //           dropOffLocation(result);
  //           Get.back();
  //         },
  //         initialPosition: LatLng(position.latitude, position.longitude),
  //         useCurrentLocation: true,
  //       ));
  // }

  Future searchLoadType(String s) async {
    if (s.isEmpty) {
      loadTypes(_loadTypes);
    } else {
      loadTypes(_loadTypes
          .where((element) => element.toLowerCase().contains(s.toLowerCase()))
          .toList());
    }
  }

  Future searchContainerTypes(String s) async {
    if (s.isEmpty) {
      containerTypes(_containerTypes);
    } else {
      containerTypes(_containerTypes
          .where((element) => element.toLowerCase().contains(s.toLowerCase()))
          .toList());
    }
  }
}
