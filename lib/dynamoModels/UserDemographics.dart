import 'package:pogo/dynamoModels/Demographics.dart';

class UserDemographics extends Demographics {
  final String userId;
  String phoneNumber;
  String registrationState;
  String addressLine1;
  String pollingLocation;
  bool voterRegistrationStatus;
  bool surveyCompletion;
  int polls;
  int loginStreak;
  int loginStreakRecord;
  String lastLogin;

  UserDemographics(
      {
        required this.userId,
        this.phoneNumber = "",
        this.registrationState = "",
        this.addressLine1 = "",
        this.pollingLocation = "",
        this.voterRegistrationStatus = false,
        this.surveyCompletion = false,
        this.polls = 0,
        this.loginStreak = 0,
        this.loginStreakRecord = 0,
        this.lastLogin = "",
        super.firstName = "",
        super.lastName = "",
        super.dateOfBirth = "",
        super.zipCode = "",
        super.profileImageURL = "",
        super.gender = "",
        super.racialIdentity = "",
        super.politicalAffiliation = "",
      });

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
        politicalAffiliation: json['politicalAffiliation'],
        surveyCompletion: json['surveyCompletion'],
        polls: json['polls'],
        loginStreak: json['loginStreak'],
        loginStreakRecord: json['loginStreakRecord'],
        lastLogin: json['lastLogin'],
    );
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
      'politicalAffiliation': politicalAffiliation,
      'surveyCompletion': surveyCompletion,
      'polls': polls,
      'loginStreak': loginStreak,
      'loginStreakRecord': loginStreakRecord,
      'lastLogin': lastLogin
    };
  }
}
