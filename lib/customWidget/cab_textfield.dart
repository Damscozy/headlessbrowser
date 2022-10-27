// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:headlessbrowser/config/constants.dart';
import 'package:headlessbrowser/geo_controller.dart';
import 'package:lottie/lottie.dart';

class PickUpField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? enableColor;
  final String? initialValue;
  final String? description;
  final void Function(String)? onChanged;

  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  Rx<AutocompletePrediction?>? selectedPrediction;
  PickUpField({
    Key? key,
    this.controller,
    this.label,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.fillColor,
    this.enableColor,
    this.selectedPrediction,
    this.initialValue,
    this.description,
  }) : super(key: key);

  @override
  State<PickUpField> createState() => _PickUpFieldState();
}

class _PickUpFieldState extends State<PickUpField> {
  final CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  final GeoController geocontroller = Get.find();

  @override
  void initState() {
    super.initState();
    geocontroller.getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    if ((Platform.isIOS)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.description ?? 'Search your favourite city!'),
          const SizedBox(
            height: 10,
          ),
          CupertinoTypeAheadFormField(
            getImmediateSuggestions: true,
            suggestionsBoxController: _suggestionsBoxController,
            suggestionsBoxVerticalOffset: 10.0,
            loadingBuilder: (context) => SizedBox(
              height: 100,
              child: Center(
                child: Lottie.asset(
                  'assets/lotties/loading.json',
                  height: 250,
                ),
              ),
            ),
            textFieldConfiguration: CupertinoTextFieldConfiguration(
                controller: widget.controller,
                placeholder: widget.initialValue),
            suggestionsCallback: (pattern) async {
              // return [];
              var googlePlace = GooglePlace(GoogleMapAPI);
              var result = await googlePlace.autocomplete.get(pattern);
              return result!.predictions!;
            },
            itemBuilder: (context, AutocompletePrediction suggestion) {
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(suggestion.description!),
              );
            },
            onSuggestionSelected: (AutocompletePrediction suggestion) {
              widget.controller!.text = suggestion.description!;
              if (widget.selectedPrediction != null) {
                widget.selectedPrediction!(suggestion);
              }

              if (kDebugMode) {
                print(
                    'Selected PickUp Location ${suggestion.description} and Address: ${geocontroller.currentAddress.value}');
                print(
                    'Selected PickUp LatLng ${geocontroller.currentPosition!.latitude} Long${geocontroller.currentPosition!.longitude}');
              }
            },
            validator: (value) =>
                value!.isEmpty ? 'Please select a city' : null,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              controller: widget.controller,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you looking for?'),
            ),
            suggestionsCallback: (pattern) async {
              if (pattern.isNotEmpty) {
                var googlePlace = GooglePlace(GoogleMapAPI);
                var result = await googlePlace.autocomplete.get(pattern);
                return result!.predictions!;
              } else {
                List<AutocompletePrediction> list = [];
                return list;
              }
            },
            itemBuilder: (context, AutocompletePrediction suggestion) {
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(suggestion.description!),
              );
            },
            onSuggestionSelected: (AutocompletePrediction suggestion) {
              widget.controller!.text = suggestion.description!;
              if (widget.selectedPrediction != null) {
                widget.selectedPrediction!(suggestion);
              }
              // Navigator.of(context).push<void>(MaterialPageRoute(
              //     builder: (context) => ProductPage(product: suggestion)));
            },
          ),
        ],
      );
    }
  }
}

class DropOffField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? enableColor;
  final String? initialValue;
  final String? description;
  final void Function(String)? onChanged;

  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  Rx<AutocompletePrediction?>? selectedDropPrediction;
  DropOffField({
    Key? key,
    this.controller,
    this.label,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.fillColor,
    this.enableColor,
    this.selectedDropPrediction,
    this.initialValue,
    this.description,
  }) : super(key: key);

  @override
  State<DropOffField> createState() => _DropOffFieldState();
}

class _DropOffFieldState extends State<DropOffField> {
  final CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();

  final GeoController geocontroller = Get.find();

  @override
  void initState() {
    super.initState();
    geocontroller.getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    if ((Platform.isIOS)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.description ?? 'Search your favourite city!'),
          const SizedBox(
            height: 10,
          ),
          CupertinoTypeAheadFormField(
            getImmediateSuggestions: true,
            suggestionsBoxController: _suggestionsBoxController,
            suggestionsBoxVerticalOffset: 10.0,
            loadingBuilder: (context) => SizedBox(
              height: 100,
              child: Center(
                child: Lottie.asset(
                  'assets/lotties/loading.json',
                  height: 250,
                ),
              ),
            ),
            textFieldConfiguration: CupertinoTextFieldConfiguration(
                controller: widget.controller,
                placeholder: widget.initialValue),
            suggestionsCallback: (pattern) async {
              // return [];
              var googlePlace = GooglePlace(GoogleMapAPI);
              var result = await googlePlace.autocomplete.get(pattern);
              return result!.predictions!;
            },
            itemBuilder: (context, AutocompletePrediction suggestion) {
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(suggestion.description!),
              );
            },
            onSuggestionSelected: (AutocompletePrediction suggestion) {
              widget.controller!.text = suggestion.description!;
              if (widget.selectedDropPrediction != null) {
                widget.selectedDropPrediction!(suggestion);
              }
              if (kDebugMode) {
                print('Selected DropOff Location ${suggestion.description}');
              }
            },
            validator: (value) =>
                value!.isEmpty ? 'Please select a city' : null,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              controller: widget.controller,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you looking for?'),
            ),
            suggestionsCallback: (pattern) async {
              if (pattern.isNotEmpty) {
                var googlePlace = GooglePlace(GoogleMapAPI);
                var result = await googlePlace.autocomplete.get(pattern);
                return result!.predictions!;
              } else {
                List<AutocompletePrediction> list = [];
                return list;
              }
            },
            itemBuilder: (context, AutocompletePrediction suggestion) {
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(suggestion.description!),
              );
            },
            onSuggestionSelected: (AutocompletePrediction suggestion) {
              widget.controller!.text = suggestion.description!;
              if (widget.selectedDropPrediction != null) {
                widget.selectedDropPrediction!(suggestion);
              }
              // Navigator.of(context).push<void>(MaterialPageRoute(
              //     builder: (context) => ProductPage(product: suggestion)));
            },
          ),
        ],
      );
    }
  }
}
