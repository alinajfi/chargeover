import 'package:chargeover/controllers/home_controller.dart';
import 'package:chargeover/screens/add_marker_screen.dart';
import 'package:chargeover/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabs(context),
      body: GetBuilder(
        init: HomeController(),
        builder: (cont) {
          return cont.currnetPostion == null
              ? const Center(
                  child: Text('Loading'),
                )
              : _homeScreenBody(context);
        },
      ),
    );
  }

  Widget _homeScreenBody(BuildContext context) {
    return SingleChildScrollView(
      physics: MediaQuery.of(context).viewInsets.bottom > 0
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: GetBuilder<HomeController>(
                    id: 'map',
                    builder: (cont) {
                      return cont.initialCameraPosition == null
                          ? Center(
                              child: Text('Loading'),
                            )
                          : GoogleMap(
                              onMapCreated: (controller) {
                                cont.mapController = controller;
                              },
                              markers: cont.markers,
                              zoomControlsEnabled: false,
                              polylines:
                                  Set<Polyline>.of(controller.route.values),
                              initialCameraPosition:
                                  controller.initialCameraPosition!,
                            );
                    }),
              ),
            ],
          )),
    );
  }

  Widget _fabs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'tracking fab',
          onPressed: () {
            _showBottomSheet(context);
          },
          child: const Icon(Icons.drive_eta_outlined),
        ),
        10.w.spaceH,
        FloatingActionButton(
          heroTag: 'add fab',
          onPressed: () {
            Get.to(const SearchPlaces());
          },
          child: const Icon(Icons.add),
        ),
        10.w.spaceH,
        FloatingActionButton(
          heroTag: 'search city fab',
          onPressed: () {
            showModalBottomSheet(
              constraints: BoxConstraints(
                minHeight: ScreenUtil().screenHeight / 2,
                minWidth: ScreenUtil().screenWidth,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TypeAheadFormField(
                        onSuggestionSelected: (suggestion) {
                          controller.mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  zoom: 16,
                                  target: LatLng(suggestion.location.latitude,
                                      suggestion.location.longitude))));
                          Get.back();
                        },
                        itemBuilder: (context, itemData) {
                          return ListTile(
                            title: Text(itemData.name),
                          );
                        },
                        suggestionsCallback: (pattern) {
                          return controller.cities.where((element) => element
                              .name
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.location_city),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
          minHeight: ScreenUtil().screenHeight,
          minWidth: ScreenUtil().screenWidth),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r))),
          height: ScreenUtil().screenHeight,
          width: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.h.spaceV,
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      alignment: Alignment.center,
                      height: 52.h,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black26),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: TypeAheadField(
                        textFieldConfiguration: const TextFieldConfiguration(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: InputBorder.none,
                                hintText: 'Sourece Location')),
                        suggestionsCallback: (pattern) {
                          var markers = controller.markers;
                          return markers
                              .where((element) => element.markerId
                                  .toString()
                                  .toLowerCase()
                                  .contains(pattern))
                              .toList();
                        },
                        itemBuilder: (context, itemData) {
                          return ListTile(
                            title: Text(itemData.markerId.value),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          controller.start = LatLng(
                              suggestion.position.latitude,
                              suggestion.position.longitude);

                          controller.sourceController.text =
                              suggestion.markerId.value;
                          controller.sourceFocus.nextFocus();
                        },
                      ),
                    ),
                  )),
              10.h.spaceV,
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      alignment: Alignment.center,
                      height: 52.h,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black26),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: TypeAheadField(
                        textFieldConfiguration: const TextFieldConfiguration(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: InputBorder.none,
                                hintText: 'destiantion Location')),
                        suggestionsCallback: (pattern) {
                          var markers = controller.markers;
                          return markers
                              .where((element) => element.markerId
                                  .toString()
                                  .toLowerCase()
                                  .contains(pattern))
                              .toList();
                        },
                        itemBuilder: (context, itemData) {
                          return ListTile(
                            title: Text(itemData.markerId.value),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          controller.end = LatLng(suggestion.position.latitude,
                              suggestion.position.longitude);
                          controller.destinationController.text =
                              suggestion.markerId.value;
                          controller.destiantionFocus.unfocus();
                        },
                      ),
                    ),
                  )),
              Flexible(
                  child: ElevatedButton(
                onPressed: () {
                  controller.getDirections();
                  controller.trackLocation();
                  Get.back();
                },
                child: const Text('Start Tracking'),
              )),
              Flexible(
                  child: ElevatedButton(
                onPressed: () {
                  controller.livePostionSubscirtion.cancel();
                  controller.route = {};
                  controller.update(['map']);
                  Get.back();
                },
                child: const Text('Stop Tracking'),
              )),
            ],
          ),
        );
      },
    );
  }
}
