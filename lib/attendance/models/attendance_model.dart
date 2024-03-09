import 'package:attendance_app/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AttendanceModel {
  final int? id;
  final String? name;
  final LatLng? latLng;
  final DateTime? dateTime;
  final bool? isApproved;

  AttendanceModel({
    this.id,
    this.name,
    this.latLng,
    this.dateTime,
    this.isApproved,
  });
}

List<AttendanceModel> listAttendance = [
  /* AttendanceModel(
    id: 1,
    name: name,
    dateTime: DateTime(2024, 02, 08, 9, 25),
    isApproved: false,
    latLng: LatLng(-6.277224, 106.802201),
  ),
  AttendanceModel(
    id: 2,
    name: name,
    dateTime: DateTime(2024, 03, 08, 9, 30),
    isApproved: true,
    latLng: LatLng(-6.2779281, 106.8021154),
  ), */
];
