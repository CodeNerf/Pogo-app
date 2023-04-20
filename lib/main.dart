import 'package:flutter/material.dart';
import 'package:pogo/firstLoadingPage.dart';

void main() {
  runApp(const MyApp());
  FlutterError.onError = (FlutterErrorDetails details) {
    print('flutter error hidden from console');
    // FlutterError.dumpErrorToConsole(details, forceReport: false);
  };
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstLoadingPage(),
    );
  }
}
