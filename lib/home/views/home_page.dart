import 'package:attendance_app/attendance/views/add_attendance_page.dart';
import 'package:attendance_app/attendance/models/attendance_model.dart';
import 'package:attendance_app/home/widgets/account_container.dart';
import 'package:attendance_app/home/widgets/attendance_container.dart';
import 'package:attendance_app/home/widgets/master_location_container.dart';
import 'package:attendance_app/preferences.dart';
import 'package:attendance_app/style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var masterLocation;

  getMasterLocation() async {
    var masterlat = await Preferences.getDouble(Preferences.masterLat);
    var masterLong = await Preferences.getDouble(Preferences.masterLong);
    if (masterlat != null) {
      masterLocation = LatLng(masterlat, masterLong!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getMasterLocation();
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            accountContainer(),
            masterLocationContainer(context, masterLocation),
            Divider(
              color: Colors.grey.shade200,
              thickness: 4,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                "Attendance Data",
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listAttendance.length,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                itemBuilder: (context, index) {
                  final attendanceModel = listAttendance[index];
                  return attendaceContainer(attendanceModel, context);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (masterLocation == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please set master location first"),
            ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddAttendancePage(),
                ));
          }
        },
        label: Text(
          'Add attendance',
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }
}
