import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});

  double latitude;
  double longitude;
  String address;
}

class Place {
  Place({required this.title, required this.image, required this.location, id})
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
