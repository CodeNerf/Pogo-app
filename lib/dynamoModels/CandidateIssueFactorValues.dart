import 'package:pogo/dynamoModels/IssueFactorValues.dart';

class CandidateIssueFactorValues extends IssueFactorValues {
  final String candidateId;

  CandidateIssueFactorValues(
      {required this.candidateId,
      required super.climateScore,
      required super.climateWeight,
      required super.drugPolicyScore,
      required super.drugPolicyWeight,
      required super.economyScore,
      required super.economyWeight,
      required super.educationScore,
      required super.educationWeight,
      required super.gunPolicyScore,
      required super.gunPolicyWeight,
      required super.healthcareScore,
      required super.healthcareWeight,
      required super.housingScore,
      required super.housingWeight,
      required super.immigrationScore,
      required super.immigrationWeight,
      required super.policingScore,
      required super.policingWeight,
      required super.reproductiveScore,
      required super.reproductiveWeight});

  factory CandidateIssueFactorValues.fromJson(Map json) {
    return CandidateIssueFactorValues(
        candidateId: json['candidateId'],
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
      'candidateId': candidateId,
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
