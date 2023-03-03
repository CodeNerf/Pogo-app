import 'package:pogo/dynamoModels/Demographics.dart';
import 'package:pogo/dynamoModels/IssueFactorValues.dart';
import 'package:pogo/models/IssueFactorValues.dart' hide IssueFactorValues;
import 'package:pogo/Onboarding/Demographics.dart' hide Demographics;

class CandidateDemographics extends Demographics {
  final String candidateId;
  final String seatType;
  final String electionType;
  final String careerStartDate;

  CandidateDemographics(
      {required this.candidateId,
      required this.seatType,
      required this.electionType,
      required this.careerStartDate,
      required super.firstName,
      required super.lastName,
      required super.dateOfBirth,
      required super.zipCode,
      required super.profileImageURL,
      required super.gender,
      required super.racialIdentity,
      required super.politicalAffiliation});

  //factory constructor
  factory CandidateDemographics.fromJson(Map json) {
    return CandidateDemographics(
        candidateId: json['candidateId'],
        seatType: json['seatType'],
        electionType: json['electionType'],
        careerStartDate: json['careerStartDate'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        dateOfBirth: json['dateOfBirth'],
        zipCode: json['zipCode'],
        profileImageURL: json['profileImageURL'],
        gender: json['gender'],
        racialIdentity: json['racialIdentity'],
        politicalAffiliation: json['politicalAffiliation']);
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateId': candidateId,
      'seatType': seatType,
      'electionType': electionType,
      'careerStartDate': careerStartDate,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'zipCode': zipCode,
      'profileImageURL': profileImageURL,
      'gender': gender,
      'racialIdentity': racialIdentity,
      'politicalAffiliation': politicalAffiliation
    };
  }
}
