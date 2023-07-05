import 'package:google_maps_flutter/google_maps_flutter.dart';

class City {
  final String name;
  final LatLng location;
  City({
    required this.name,
    required this.location,
  });
}
