import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/CandidateDemographics.dart';
//TODO: pull extra candidate information (stuff not included in CandidateDemographics) from somewhere
class CandidateProfile extends StatefulWidget {
  final CandidateDemographics candidate;
  const CandidateProfile({Key? key, required this.candidate}) : super(key: key);

  @override
  State<CandidateProfile> createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
