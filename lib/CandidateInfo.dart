import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';

class CandidateInfo extends StatelessWidget {
  const CandidateInfo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('CANDIDATE INFO PAGE'),
            ],
          ),
        ),
      ),
    );
  }
}
