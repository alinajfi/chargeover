import 'package:chargeover/controllers/home_controller.dart';
import 'package:chargeover/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchPlaces extends GetView<HomeController> {
  const SearchPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(height: Get.height * 0.95, child: _buildBody()))),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        20.0.spaceV,
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          width: 300.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            onChanged: (value) {
              controller.getSuggestion(controller.searchPlaces.text);
            },
            controller: controller.searchPlaces,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 4.h),
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search Places',
              border: InputBorder.none,
            ),
          ),
        ),
        20.0.spaceV,
        GetBuilder<HomeController>(
            id: 'search',
            init: HomeController(),
            builder: (context) {
              return SizedBox(
                height: 580.h,
                child: controller.placesList.isEmpty
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : ListView.builder(
                        itemCount: controller.placesList.length,
                        itemBuilder: (context, index) => _listOfPlaces(index),
                      ),
              );
            }),
      ],
    );
  }

  Widget _listOfPlaces(index) {
    return ListTile(
      onTap: () async {
        var location = await locationFromAddress(
            controller.placesList[index].description!);

        var newMarker = Marker(
            infoWindow:
                InfoWindow(title: controller.placesList[index].description!),
            markerId: MarkerId(controller.placesList[index].description!),
            position:
                LatLng(location.first.latitude, location.first.longitude));

        var updatedMarkers = controller.updateMarkers(newMarker);
        controller.markers = updatedMarkers;
        controller.update(['map']);
        controller.searchPlaces.clear();
        controller.placesList.clear();

        Get.back();
      },
      title: Text(controller.placesList[index].description ?? ''),
    );
  }
}
