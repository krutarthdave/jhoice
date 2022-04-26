import 'dart:math';

import "package:google_maps_flutter/google_maps_flutter.dart";

import 'parents/model.dart';

class Address extends Model {
  String id;
  String description;
  String address;
  double latitude;
  double longitude;
  bool isDefault;
  String userId;

  Address({this.id, this.description, this.address, this.latitude, this.longitude, this.isDefault, this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    description = stringFromJson(json, 'description');
    address = stringFromJson(json, 'address');
    latitude = doubleFromJson(json, 'latitude', defaultValue: null);
    longitude = doubleFromJson(json, 'longitude', defaultValue: null);
    isDefault = boolFromJson(json, 'default');
    userId = stringFromJson(json, 'user_id');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['default'] = this.isDefault;
    if (this.userId != null) {
      data['user_id'] = this.userId;
    }
    return data;
  }

  bool isUnknown() {
    return latitude == null || longitude == null;
  }

  String get getDescription {
    if (hasDescription()) return description;
    return address.substring(0, min(address.length, 10));
  }

  bool hasDescription() {
    if (description != null && description.isNotEmpty) return true;
    return false;
  }

  LatLng getLatLng() {
    if (this.isUnknown()) {
      return LatLng(38.806103, 52.4964453);
    } else {
      return LatLng(this.latitude, this.longitude);
    }
  }
}
