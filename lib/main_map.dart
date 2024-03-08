import 'dart:async';

import 'package:attendance_app/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => MainMapState();
}

class MainMapState extends State<MainMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  /* static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-6.2779792, 106.8029257),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414); */

  Color mainColor = Color(0XFF59D5E0);
  Color whiteColor = Color(0XFFF6F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Container(
        // color: Colors.amber.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                      )
                    ]),
                child: Icon(Icons.add),
              ),
            ),
            IconButton(
              onPressed: _goToMyLocation,
              icon: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(0, 0),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.my_location_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToMyLocation,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ), */
    );
  }

  Future<void> _goToMyLocation() async {
    Position myLocation = await getMyLocation();
    CameraPosition newCameraPosition = CameraPosition(
      target: LatLng(myLocation.latitude, myLocation.longitude),
      zoom: 19,
    );
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }
}
