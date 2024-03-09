import 'package:attendance_app/main.dart';
import 'package:attendance_app/style.dart';
import 'package:flutter/material.dart';

accountContainer() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 16),
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
          child: Center(
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "User account",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
