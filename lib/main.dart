import 'package:flutter/material.dart';
import 'kiosk/screens/kiosk_home_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FaceApp());
}

class FaceApp extends StatelessWidget {
  const FaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      home: KioskHomeScreen(),
    );
  }
}