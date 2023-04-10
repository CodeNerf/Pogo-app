import 'package:pogo/dynamoModels/IssueFactorValues/IssueFactorValues.dart';

class UserIssueFactorValues extends IssueFactorValues {
  final String userId;

  UserIssueFactorValues(
      {required this.userId,
      super.climateScore = 0,
      super.climateWeight = 0,
      super.drugPolicyScore = 0,
      super.drugPolicyWeight = 0,
      super.economyScore = 0,
      super.economyWeight = 0,
      super.educationScore = 0,
      super.educationWeight = 0,
      super.gunPolicyScore = 0,
      super.gunPolicyWeight = 0,
      super.healthcareScore = 0,
      super.healthcareWeight = 0,
      super.housingScore = 0,
      super.housingWeight = 0,
      super.immigrationScore = 0,
      super.immigrationWeight = 0,
      super.policingScore = 0,
      super.policingWeight = 0,
      super.reproductiveScore = 0,
      super.reproductiveWeight = 0});

  factory UserIssueFactorValues.fromJson(Map json) {
    return UserIssueFactorValues(
        userId: json['userId'],
        climateScore: json['climateScore'],
        climateWeight: json['climateWeight'],
        drugPolicyScore: json['drugPolicyScore'],
        drugPolicyWeight: json['drugPolicyWeight'],
        economyScore: json['economyScore'],
        economyWeight: json['economyWeight'],
        educationScore: json['educationScore'],
        educationWeight: json['educationWeight'],
        gunPolicyScore: json['gunPolicyScore'],
        gunPolicyWeight: json['gunPolicyWeight'],
        healthcareScore: json['healthcareScore'],
        healthcareWeight: json['healthcareWeight'],
        housingScore: json['housingScore'],
        housingWeight: json['housingWeight'],
        immigrationScore: json["immigrationScore"],
        immigrationWeight: json["immigrationWeight"],
        policingScore: json["policingScore"],
        policingWeight: json["policingWeight"],
        reproductiveScore: json["reproductiveScore"],
        reproductiveWeight: json["reproductiveWeight"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'climateScore': climateScore,
      'climateWeight': climateWeight,
      'drugPolicyScore': drugPolicyScore,
      'drugPolicyWeight': drugPolicyWeight,
      'economyScore': economyScore,
      'economyWeight': economyWeight,
      'educationScore': educationScore,
      'educationWeight': educationWeight,
      'gunPolicyScore': gunPolicyScore,
      'gunPolicyWeight': gunPolicyWeight,
      'healthcareScore': healthcareScore,
      'healthcareWeight': healthcareWeight,
      'housingScore': housingScore,
      'housingWeight': housingWeight,
      'immigrationScore': immigrationScore,
      'immigrationWeight': immigrationWeight,
      'policingScore': policingScore,
      'policingWeight': policingWeight,
      'reproductiveScore': reproductiveScore,
      'reproductiveWeight': reproductiveWeight
    };
  }
}
