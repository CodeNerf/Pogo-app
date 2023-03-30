import 'package:pogo/dynamoModels/Demographics.dart';

class CandidateDemographics extends Demographics {
  final String candidateId;
  final String seatType;
  final String electionType;
  final String careerStartDate;

  CandidateDemographics(
      {required this.candidateId,
      this.seatType = '',
      this.electionType = '',
      this.careerStartDate = '',
      super.firstName = '',
      super.lastName = '',
      super.dateOfBirth = '',
      super.zipCode = '',
      super.profileImageURL = '',
      super.gender = '',
      super.racialIdentity = '',
      super.politicalAffiliation = ''});

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
