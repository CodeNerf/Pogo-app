import 'package:pogo/dynamoModels/Demographics/Demographics.dart';
import 'Education.dart';
import 'Position.dart';

class CandidateDemographics extends Demographics {
  final String candidateName;
  final String runningPosition;
  final String currentPosition;
  final String homePhoneNumber;
  final String officialWebsiteURL;
  final String linkedInURL;
  final String twitterURL;
  final String facebookURL;
  final String instagramURL;
  final String tiktokURL;
  final String careerStartYear;
  final String headline;
  List<String> bodyBulletPoints;
  final String bodySummary;
  final List<Education> education;
  final List<Position> prevPositions;
  final List<Position> otherExperience;
  final String campaignBudget;
  final String countOfDonors;
  final String countOfStaff;
  final List<String> additionalDonations;

  CandidateDemographics(
      {required super.id,
      this.candidateName = '',
      this.runningPosition = '',
      this.currentPosition = '',
      this.homePhoneNumber = '',
      this.officialWebsiteURL = '',
      this.linkedInURL = '',
      this.twitterURL = '',
      this.facebookURL = '',
      this.instagramURL = '',
      this.tiktokURL = '',
      this.careerStartYear = '',
      this.headline = '',
      this.bodyBulletPoints = const [],
      this.bodySummary = '',
      this.education = const [],
      this.prevPositions = const [],
      this.otherExperience = const [],
      this.campaignBudget = '',
      this.countOfDonors = '',
      this.countOfStaff = '',
      this.additionalDonations = const [],
      super.dateOfBirth = '',
      super.profileImageURL = '',
      super.gender = '',
      super.racialIdentity = '',
      super.politicalAffiliation = '',
      super.addressLine1 = '',
      super.city = '',
      super.zipCode = '',
      super.phoneNumber = '',
      super.email = ''});

  //factory constructor
  factory CandidateDemographics.fromJson(Map json) {
    return CandidateDemographics(
        id: json['candidateId'],
        candidateName: json['Candidate Name'],
        runningPosition: json['Position Running'],
        currentPosition: json['Current Position'],
        homePhoneNumber: json['Home Phone'],
        officialWebsiteURL: json['Official Website'],
        linkedInURL: json['LinkedIn'],
        twitterURL: json['Twitter'],
        facebookURL: json['Facebook'],
        instagramURL: json['Instagram'],
        tiktokURL: json['TikTok'],
        careerStartYear: json['Career Start Year'],
        headline: json['Headline'],
        bodyBulletPoints:
            (json["Body Bullet Points Array"] as List).cast<String>(),
        bodySummary: json['Body Summary'],
        education: (json["Education Array"] as List).cast<Education>(),
        prevPositions:
            (json["Previous Positions Array"] as List).cast<Position>(),
        otherExperience:
            (json["Other Experience Array"] as List).cast<Position>(),
        campaignBudget: json['Campaign Budget'],
        countOfDonors: json['Number of Contributors'],
        countOfStaff: json['Number of Staff Members'],
        additionalDonations:
            (json["Additional Donations"] as List).cast<String>(),
        dateOfBirth: json['Date of Birth'],
        profileImageURL: json['Profile Image URL'],
        gender: json['Gender'],
        racialIdentity: json['Racial Identity'],
        politicalAffiliation: json['Political Party'],
        addressLine1: json['Address'],
        city: json['City'],
        zipCode: json['Zipcode'],
        phoneNumber: json['Phone Number'],
        email: json['Email']);
  }

  // Function converts the object to a map

  Map<String, dynamic> toJson() {
    return {
      'candidateId': id,
      'Candidate Name': candidateName,
      'Position Running': runningPosition,
      'Current Position': currentPosition,
      'Home Phone': homePhoneNumber,
      'Official Website': officialWebsiteURL,
      'LinkedIn': linkedInURL,
      'Twitter': twitterURL,
      'Facebook': facebookURL,
      'Instagram': instagramURL,
      'TikTok': tiktokURL,
      'Career Start Year': careerStartYear,
      'Headline': headline,
      "Body Bullet Points Array": bodyBulletPoints,
      'Body Summary': bodySummary,
      "Education Array": education,
      "Previous Positions Array": prevPositions,
      "Other Experience Array": otherExperience,
      'Campaign Budget': campaignBudget,
      'Number of Contributors': countOfDonors,
      'Number of Staff Members': countOfStaff,
      "Additional Donations": additionalDonations,
      'Date of Birth': dateOfBirth,
      'Profile Image URL': profileImageURL,
      'Gender': gender,
      'Racial Identity': racialIdentity,
      'Political Party': politicalAffiliation,
      'Address': addressLine1,
      'City': city,
      'Zipcode': zipCode,
      'Phone Number': phoneNumber,
      'Email': email
    };
  }
}
