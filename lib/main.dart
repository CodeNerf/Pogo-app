import 'package:flutter/material.dart';
import 'package:pogo/LandingPage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';
import 'LandingPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

