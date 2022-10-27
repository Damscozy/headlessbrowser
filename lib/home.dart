// ignore_for_file: prefer_const_constructors, constant_identifier_names, non_constant_identifier_names, prefer_collection_literals, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng SOURCE_LOCATION = LatLng(6.49407, 3.89467);
const LatLng DEST_LOCATION = LatLng(6.45407, 3.39467);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 10;
const double PIN_INVISIBLE_POSITION = -260;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  GoogleMapController? mapController;
  double pinPillPosition = PIN_VISIBLE_POSITION;

  LatLng? currentLocation;
  LatLng? destinationLocation;

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  void initState() {
    super.initState();

    // set up initial locations

    //set up the marker
    setSourceAndDestinationMarkerIcon();
    // SOURCE_LOCATION = currentLocation!;
    setInitiallocation();
  }

  void setSourceAndDestinationMarkerIcon() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 20),
      "assets/svgs/source.svg",
    );

    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 20),
      "assets/svgs/destination.svg",
    );
  }

  void setInitiallocation() {
    currentLocation = LatLng(
      SOURCE_LOCATION.latitude,
      SOURCE_LOCATION.longitude,
    );

    destinationLocation = LatLng(
      DEST_LOCATION.latitude,
      DEST_LOCATION.longitude,
    );
    _markers.add(
      Marker(
        markerId: MarkerId("current position"),
        position: currentLocation!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   systemOverlayStyle: SystemUiOverlayStyle.light,
      // ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            zoom: CAMERA_ZOOM,
            tilt: CAMERA_TILT,
            bearing: CAMERA_BEARING,
            target: currentLocation!,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void showPinOnMap() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId("source"),
          position: currentLocation!,
          icon: sourceIcon!,
        ),
      );

      _markers.add(
        Marker(
            markerId: const MarkerId("destination"),
            position: destinationLocation!,
            icon: destinationIcon!,
            onTap: () {
              setState(() {
                pinPillPosition = PIN_VISIBLE_POSITION;
              });
            }),
      );
    });
  }
}

// BitmapDescriptor? sourceIcon;
//   BitmapDescriptor? destinationIcon;
//   Set<Marker> _markers = Set<Marker>();
//   GoogleMapController? mapController;
//   double pinPillPosition = PIN_VISIBLE_POSITION;

//   LatLng? currentLocation;
//   LatLng? destinationLocation;

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   void initState() {
//     super.initState();
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
//     }
//     //set up initial locations

//     //set up the marker
//     setSourceAndDestinationMarkerIcon();
//     // SOURCE_LOCATION = currentLocation!;
//     setInitiallocation();
//   }

//   void setSourceAndDestinationMarkerIcon() async {
//     sourceIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 20),
//       "assets/svgs/source.svg",
//     );

//     destinationIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 20),
//       "assets/svgs/destination.svg",
//     );
//   }

//   void setInitiallocation() {
//     currentLocation = LatLng(
//       SOURCE_LOCATION.latitude,
//       SOURCE_LOCATION.longitude,
//     );

//     destinationLocation = LatLng(
//       DEST_LOCATION.latitude,
//       DEST_LOCATION.longitude,
//     );
//     _markers.add(
//       Marker(
//         markerId: MarkerId("current position"),
//         position: currentLocation!,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         // initialCameraPosition: CameraPosition(
//         //   zoom: CAMERA_ZOOM,
//         //   tilt: CAMERA_TILT,
//         //   bearing: CAMERA_BEARING,
//         //   target: currentLocation!,
//         // ),
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }

//   void showPinOnMap() {
//     setState(() {
//       _markers.add(
//         Marker(
//           markerId: const MarkerId("source"),
//           position: currentLocation!,
//           icon: sourceIcon!,
//         ),
//       );

//       _markers.add(
//         Marker(
//             markerId: const MarkerId("destination"),
//             position: destinationLocation!,
//             icon: destinationIcon!,
//             onTap: () {
//               setState(() {
//                 pinPillPosition = PIN_VISIBLE_POSITION;
//               });
//             }),
//       );
//     });
//   }
// }