import 'package:attendance_app/attendance/models/attendance_model.dart';
import 'package:attendance_app/date_format.dart';
import 'package:attendance_app/home/widgets/modal_bottom_sheet_container.dart';
import 'package:attendance_app/style.dart';
import 'package:flutter/material.dart';

attendaceContainer(AttendanceModel attendanceModel, BuildContext context) {
  Text isApprovedWidget = Text("");
  if (attendanceModel.isApproved!) {
    isApprovedWidget = const Text(
      "Approved",
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  } else {
    isApprovedWidget = const Text(
      "Rejected",
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String date = dateFormat(attendanceModel.dateTime!);
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        backgroundColor: whiteColor,
        builder: (context) => modalBottomSheetContainer(
          attendanceModel,
          date,
          isApprovedWidget,
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 0),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attendanceModel.name!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          isApprovedWidget,
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
