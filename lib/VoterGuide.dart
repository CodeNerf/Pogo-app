import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';

class VoterGuide extends StatelessWidget {
  const VoterGuide({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('VOTER GUIDE PAGE'),
            ],
          ),
        ),
      ),
    );
  }
}
