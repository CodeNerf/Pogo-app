import 'package:pogo/dynamoModels/Demographics/Demographics.dart';

class UserDemographics extends Demographics {
  String registrationState;
  String pollingLocation;
  bool voterRegistrationStatus;
  bool surveyCompletion;
  int polls;
  int loginStreak;
  int loginStreakRecord;
  String lastLogin;
  bool liveInRegisteredState;
  String partyVoting;
  String firstName;
  String lastName;

  UserDemographics({
    required super.id,
    this.registrationState = "",
    this.pollingLocation = "",
    this.voterRegistrationStatus = false,
    this.surveyCompletion = false,
    this.polls = 0,
    this.loginStreak = 0,
    this.loginStreakRecord = 0,
    this.lastLogin = "",
    this.liveInRegisteredState = false,
    this.partyVoting = "",
    this.firstName = "",
    this.lastName = "",
    super.dateOfBirth = "",
    super.zipCode = "",
    super.profileImageURL = "",
    super.gender = "",
    super.racialIdentity = "",
    super.politicalAffiliation = "",
    super.addressLine1 = "",
    super.city = "",
    super.phoneNumber = "",
    super.email = "",
  });

  //factory constructor
  factory UserDemographics.fromJson(Map json) {
    return UserDemographics(
      id: json['userId'],
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
      liveInRegisteredState: json['liveInRegisteredState'],
      partyVoting: json['partyVoting'],
      city: json['city'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": id,
      "phoneNumber": phoneNumber,
      "registrationState": registrationState,
      "addressLine1": addressLine1,
      "pollingLocation": pollingLocation,
      "voterRegistrationStatus": voterRegistrationStatus,
      "firstName": firstName,
      "lastName": lastName,
      "dateOfBirth": dateOfBirth,
      "zipCode": zipCode,
      "profileImageURL": profileImageURL,
      "gender": gender,
      "racialIdentity": racialIdentity,
      "politicalAffiliation": politicalAffiliation,
      "surveyCompletion": surveyCompletion,
      "polls": polls,
      "loginStreak": loginStreak,
      "loginStreakRecord": loginStreakRecord,
      "lastLogin": lastLogin,
      "liveInRegisteredState": liveInRegisteredState,
      "partyVoting": partyVoting,
      "city": city,
      "email": email,
    };
  }
}
