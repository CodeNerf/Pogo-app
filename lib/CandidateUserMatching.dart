import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';

class CandidateUserMatching extends StatelessWidget {
  const CandidateUserMatching({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('USER-CANDIDATE MATCHING PAGE'),
            ],
          ),
        ),
      ),
    );
  }
}
