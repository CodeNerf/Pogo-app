import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'package:pogo/LandingPage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}


