import 'package:attendance_app/home/views/home_page.dart';
import 'package:attendance_app/style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    _pushPage();
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 128, bottom: 64),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.face_retouching_natural,
                size: 64,
                color: whiteColor,
              ),
              CircularProgressIndicator(
                color: whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pushPage() {
    Future.delayed(
      Duration(milliseconds: 1200),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false);
      },
    );
  }
}
