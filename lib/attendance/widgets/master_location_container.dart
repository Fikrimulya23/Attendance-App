import 'package:attendance_app/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

masterLocationContainer(LatLng masterLocation) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
            width: 1,
            color: Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Master Location",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              masterLocation.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}
