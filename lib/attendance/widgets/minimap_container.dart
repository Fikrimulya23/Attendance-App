import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

miniMapContainer(double width, LatLng masterLocation, _controller) {
  return SizedBox(
    width: width,
    height: width,
    child: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: masterLocation,
        zoom: 14.4746,
      ),
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      zoomGesturesEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: <Marker>{
        Marker(
          onTap: () {
            print('Tapped');
          },
          markerId: MarkerId('Marker'),
          position: masterLocation,
        ),
      },
    ),
  );
}
