import 'package:amplify_flutter/amplify_flutter.dart';
import 'models/ModelProvider.dart';
import 'amplifyFunctions.dart';
import 'UserIssuesFactors.dart';

Future<void> initialUserIssueFactorValues(String e) async {
  final newUserIssueFactorValues = UserIssueFactorValues(
    userId: e,
    climateScore: 0,
    climateWeight: 0,
    drugPolicyScore: 0,
    drugPolicyWeight: 0,
    economyScore: 0,
    economyWeight: 0,
    educationScore: 0,
    educationWeight: 0,
    gunPolicyScore: 0,
    gunPolicyWeight: 0,
    healthcareScore: 0,
    healthcareWeight: 0,
    housingScore: 0,
    housingWeight: 0,
    immigrationScore: 0,
    immigrationWeight: 0,
    policingScore: 0,
    policingWeight: 0,
    reproductiveScore: 0,
    reproductiveWeight: 0,
  );
  safePrint("SAVING INITIAL FACTOR VALUES");
  await Amplify.DataStore.save(newUserIssueFactorValues);
}

Future<void> updateUserIssueFactorValues(UserIssuesFactors issues, String e) async {
  final currentUserIssueFactorValues = await Amplify.DataStore.query(
    UserIssueFactorValues.classType,
    where: UserIssueFactorValues.USERID.eq(e),
  );
  final old = currentUserIssueFactorValues.first;
  final updatedUserIssueFactorValues = old.copyWith(
      climateScore: issues.climateAlign,
      climateWeight: issues.climateCare,
      drugPolicyScore: issues.drugPolicyAlign,
      drugPolicyWeight: issues.drugPolicyCare,
      economyScore: issues.economyAlign,
      economyWeight: issues.economyCare,
      educationScore: issues.educationAlign,
      educationWeight: issues.educationCare,
      gunPolicyScore: issues.gunPolicyAlign,
      gunPolicyWeight: issues.gunPolicyCare,
      healthcareScore: issues.healthcareAlign,
      healthcareWeight: issues.healthcareCare,
      housingScore: issues.housingAlign,
      housingWeight: issues.housingCare,
      immigrationScore: issues.immigrationAlign,
      immigrationWeight: issues.immigrationCare,
      policingScore: issues.policingAlign,
      policingWeight: issues.policingCare,
      reproductiveScore: issues.reproductiveRightsAlign,
      reproductiveWeight: issues.reproductiveRightsCare
  );
  await Amplify.DataStore.save(updatedUserIssueFactorValues);
}

Future<UserIssuesFactors> fetchCurrentUserFactors(String e) async {
  final getUserFactors = await Amplify.DataStore.query(
      UserIssueFactorValues.classType,
      where: UserIssueFactorValues.USERID.eq(e)
  );
  final currentUserFactors = getUserFactors.first;
  UserIssuesFactors current = UserIssuesFactors(
      currentUserFactors.climateScore!,
      currentUserFactors.climateWeight!,
      currentUserFactors.drugPolicyScore!,
      currentUserFactors.drugPolicyWeight!,
      currentUserFactors.economyScore!,
      currentUserFactors.economyWeight!,
      currentUserFactors.educationScore!,
      currentUserFactors.educationWeight!,
      currentUserFactors.gunPolicyScore!,
      currentUserFactors.gunPolicyWeight!,
      currentUserFactors.healthcareScore!,
      currentUserFactors.healthcareWeight!,
      currentUserFactors.housingScore!,
      currentUserFactors.housingWeight!,
      currentUserFactors.immigrationScore!,
      currentUserFactors.immigrationWeight!,
      currentUserFactors.policingScore!,
      currentUserFactors.policingWeight!,
      currentUserFactors.reproductiveScore!,
      currentUserFactors.reproductiveWeight!
  );
  return current;
}