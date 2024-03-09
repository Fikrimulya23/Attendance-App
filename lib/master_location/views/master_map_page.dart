import 'dart:async';

import 'package:attendance_app/home/views/home_page.dart';
import 'package:attendance_app/location_service.dart';
import 'package:attendance_app/preferences.dart';
import 'package:attendance_app/style.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MasterMapPage extends StatefulWidget {
  const MasterMapPage({super.key});

  @override
  State<MasterMapPage> createState() => MasterMapPageState();
}

class MasterMapPageState extends State<MasterMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  List<Marker> markers = [
    Marker(
      onTap: () {
        print('Tapped');
      },
      markerId: MarkerId('Marker'),
      position: LatLng(0, 0),
    ),
  ];

  LatLng _center = LatLng(0, 0);

  @override
  void initState() {
    getMasterLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        compassEnabled: false,
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        mapToolbarEnabled: false,
        onCameraMove: ((position) => _updatePosition(position)),
        markers: Set<Marker>.of(markers),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 12),
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
              ],
            ),
            child: Material(
              color: transparent,
              child: InkWell(
                  onTap: _goToMyLocation,
                  borderRadius: BorderRadius.circular(12),
                  child: const Icon(Icons.my_location_rounded)),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              if (markers.isNotEmpty) {
                var markerLocation = markers[0].position;

                Preferences.setDouble(
                    Preferences.masterLat, markerLocation.latitude);
                Preferences.setDouble(
                    Preferences.masterLong, markerLocation.longitude);
              }

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false);
            },
            label: Text(
              'Set Master Location',
              style: TextStyle(color: whiteColor),
            ),
            backgroundColor: primaryColor,
          ),
        ],
      ),
    );
  }

  getMasterLocation() async {
    var masterlat = await Preferences.getDouble(Preferences.masterLat);
    var masterLong = await Preferences.getDouble(Preferences.masterLong);

    if (masterlat != null) {
      _center = LatLng(masterlat, masterLong!);

      CameraPosition newCameraPosition = CameraPosition(
        target: _center,
        zoom: 19,
      );
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(newCameraPosition),
      );
    } else {
      _goToMyLocation();
    }
  }

  Future<void> _goToMyLocation() async {
    Position position = await getMyLocation();

    _center = LatLng(position.latitude, position.longitude);

    CameraPosition newCameraPosition = CameraPosition(
      target: _center,
      zoom: 19,
    );
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
    _updatePosition(newCameraPosition);
  }

  void _updatePosition(CameraPosition _position) {
    LatLng newMarkerPosition =
        LatLng(_position.target.latitude, _position.target.longitude);
    Marker marker = markers[0];

    setState(() {
      markers[0] = marker.copyWith(
          positionParam:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    });
  }
}
