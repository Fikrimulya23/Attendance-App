import 'dart:async';

import 'package:attendance_app/attendance/models/attendance_model.dart';
import 'package:attendance_app/attendance/widgets/master_location_container.dart';
import 'package:attendance_app/attendance/widgets/minimap_container.dart';
import 'package:attendance_app/home/views/home_page.dart';
import 'package:attendance_app/location_service.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/preferences.dart';
import 'package:attendance_app/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAttendancePage extends StatefulWidget {
  const AddAttendancePage({super.key});

  @override
  State<AddAttendancePage> createState() => _AddAttendancePageState();
}

class _AddAttendancePageState extends State<AddAttendancePage> {
  double width = 0;

  Size size = Size.zero;

  var masterLocation = LatLng(0, 0);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getMasterLocation();

    size = MediaQuery.of(context).size;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            masterLocationContainer(masterLocation),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Your Location",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            miniMapContainer(width, masterLocation, _controller),
            const Expanded(child: SizedBox()),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: whiteColor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Confirm your Attendance?",
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          border: Border.all(
                                            color: primaryColor,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        addAttendance();
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Yes, Confirm",
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                    child: Text(
                      "Confirm Attendance",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addAttendance() async {
    var myLocation = await getMyLocation();
    var latLng = LatLng(myLocation.latitude, myLocation.longitude);

    bool isApproved = isApprovedAttendance(latLng);
    var newData = AttendanceModel(
      latLng: latLng,
      dateTime: DateTime.now(),
      isApproved: isApproved,
      name: name,
    );
    listAttendance.add(newData);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false);
  }

  bool isApprovedAttendance(LatLng myLatLng) {
    var distance = Geolocator.distanceBetween(myLatLng.latitude,
        myLatLng.longitude, masterLocation.latitude, masterLocation.longitude);

    if (distance > 50) {
      return false;
    } else {
      return true;
    }
  }

  getMasterLocation() async {
    var masterlat = await Preferences.getDouble(Preferences.masterLat);
    var masterLong = await Preferences.getDouble(Preferences.masterLong);
    if (masterlat != null) {
      masterLocation = LatLng(masterlat, masterLong!);

      CameraPosition newCameraPosition = CameraPosition(
        target: masterLocation,
        zoom: 19,
      );
      final GoogleMapController controller = await _controller.future;
      await controller.moveCamera(
        CameraUpdate.newCameraPosition(newCameraPosition),
      );
    }
    setState(() {});
  }
}
