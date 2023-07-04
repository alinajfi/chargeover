import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/place_predictions.dart';

class HomeController extends GetxController {
  var googleMapApiKey = 'AIzaSyAfhjXCDFwGGfY4ucoEnjJ3iJ3PJWcbzDs';
  var baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String? sessionToken;
  List<PlacesPrediction> placesList = [];

  Position? currnetPostion;
  final Set<Polyline> polylines = {};
  LatLng? startCoordinate;
  LatLng? endCoordinate;
  late TextEditingController sourceController;
  late TextEditingController destinationController;
  late TextEditingController searchPlaces;
  late GoogleMapController mapController;
  late Stream<Position> livePostion;
  late StreamSubscription<Position> livePostionSubscirtion;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> route = {};
  Set<Marker> markers = {};
  Position? trackerPostion;
  late Marker liveMarker;

  @override
  void onInit() {
    super.onInit();
    sourceController = TextEditingController();
    destinationController = TextEditingController();
    searchPlaces = TextEditingController();
    _determinePosition();

    sourceController = TextEditingController();
    destinationController = TextEditingController();
  }

  void trackLocation() async {
    livePostion = Geolocator.getPositionStream();

    livePostionSubscirtion = livePostion.listen((event) {
      trackerPostion = event;
      liveMarker = Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          infoWindow: const InfoWindow(title: 'Live'),
          markerId: const MarkerId('Live'),
          position:
              LatLng(trackerPostion!.latitude, trackerPostion!.longitude));
      markers = updateMarkers(liveMarker);

      update(['map']);
    });
  }

  Set<Marker> updateMarkers(Marker marker) {
    markers = constMarkers;
    markers.add(marker);
    var newList = markers.map(
      (e) {
        return e.mapsId.toString();
      },
    ).toList();
    log(newList.toString());
    update(['map']);
    return markers;
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('Location permissions are permanently denied, we cannot request permissions.');
    }
    currnetPostion = await Geolocator.getCurrentPosition();
    markers = updateMarkers(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: 'current Locatioon'),
        markerId: const MarkerId('current location'),
        position: LatLng(currnetPostion!.latitude, currnetPostion!.longitude)));
    update();
    update(['map']);
  }

  LatLng? start;
  LatLng? end;
  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApiKey,
      PointLatLng(start?.latitude ?? currnetPostion!.latitude,
          start?.longitude ?? currnetPostion!.longitude),
      PointLatLng(end!.latitude, end!.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      log(result.errorMessage.toString());
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    route[id] = polyline;
    update(['map']);
  }

  void getSuggestion(String input) async {
    String request =
        '$baseUrl?input=$input&key=$googleMapApiKey&sessiontoken=$sessionToken';

    final response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['predictions'] as List;
      placesList = list.map((e) => PlacesPrediction.fromJson(e)).toList();
      update(['search']);
    }
  }

  var constMarkers = {
    const Marker(
        infoWindow: InfoWindow(title: 'Ev Station Bwp Cant'),
        markerId: MarkerId('Bwp Cant'),
        position: LatLng(29.385439, 71.690589)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation model town'),
        markerId: MarkerId('model town'),
        position: LatLng(29.394782, 71.657202)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev station hamza town'),
        markerId: MarkerId('hamza town'),
        position: LatLng(29.383528, 71.712766)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation raman'),
        markerId: MarkerId('raman'),
        position: LatLng(29.353795, 71.599200)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation nawab colony'),
        markerId: MarkerId('nawab colony'),
        position: LatLng(29.381192, 71.655008)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation Vihari Chowk'),
        markerId: MarkerId('Vihari Chowk'),
        position: LatLng(30.173039, 71.508783)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation Gulzaib colony'),
        markerId: MarkerId('Gulzaib colony'),
        position: LatLng(30.170659, 71.491438)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation Mumtazabad'),
        markerId: MarkerId('Mumtazabad'),
        position: LatLng(30.172547, 71.477153)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation Multan Cant'),
        markerId: MarkerId('Multan Cant'),
        position: LatLng(30.179521, 71.448743)),
    const Marker(
        infoWindow: InfoWindow(title: 'Ev sation Railway colony'),
        markerId: MarkerId('Railwy colony'),
        position: LatLng(30.182534, 71.442759)),
  };
}
