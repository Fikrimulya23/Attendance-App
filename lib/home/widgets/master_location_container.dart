import 'package:attendance_app/master_location/views/master_map_page.dart';
import 'package:attendance_app/style.dart';
import 'package:flutter/material.dart';

masterLocationContainer(BuildContext context, var masterLocation) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MasterMapPage(),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                color: (masterLocation == null)
                    ? Colors.grey.shade500
                    : Colors.red,
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
                  (masterLocation == null)
                      ? Text(
                          "please click me to set master location",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      : Text(
                          masterLocation.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
