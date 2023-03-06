import 'dart:ffi';

import 'package:pogo/dynamoModels/Demographics.dart';
import 'package:pogo/models/IssueFactorValues.dart' hide IssueFactorValues;
import 'package:pogo/Onboarding/Demographics.dart' hide Demographics;

class UserDemographics extends Demographics {
  final String userId;
  final String phoneNumber;
  final String registrationState;
  final String addressLine1;
  final String pollingLocation;
  late final bool voterRegistrationStatus;

  UserDemographics(
      {required this.userId,
      required this.phoneNumber,
      required this.registrationState,
      required this.addressLine1,
      required this.pollingLocation,
      required this.voterRegistrationStatus,
      required super.firstName,
      required super.lastName,
      required super.dateOfBirth,
      required super.zipCode,
      required super.profileImageURL,
      required super.gender,
      required super.racialIdentity,
      required super.politicalAffiliation});

  //factory constructor
  factory UserDemographics.fromJson(Map json) {
    return UserDemographics(
        userId: json['userId'],
        phoneNumber: json['phoneNumber'],
        registrationState: json['registrationState'],
        addressLine1: json['addressLine1'],
        pollingLocation: json['pollingLocation'],
        voterRegistrationStatus: json['voterRegistrationStatus'],
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
      'userId': userId,
      'phoneNumber': phoneNumber,
      'registrationState': registrationState,
      'addressLine1': addressLine1,
      'pollingLocation': pollingLocation,
      'voterRegistrationStatus': voterRegistrationStatus,
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
