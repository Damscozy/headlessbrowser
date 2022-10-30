// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    this.latitude,
    this.longitude,
    this.addressLine1,
    this.addressLine2,
    this.id,
    this.provider,
    this.index,
  });

  final double? latitude;
  final double? longitude;
  final String? addressLine1;
  final String? addressLine2;
  final String? id;
  final String? provider;
  final int? index;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude:
            json["latitude"] == null ? null : json["latitude"]!.toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"]!.toDouble(),
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        id: json["id"],
        provider: json["provider"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "id": id,
        "provider": provider,
        "index": index,
      };
}
