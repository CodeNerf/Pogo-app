import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';
import 'package:http/http.dart' as http;
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/dynamoModels/Demographics/CandidateDemographics.dart';
import 'package:pogo/dynamoModels/MatchingStatistics.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import 'package:pogo/dynamoModels/userBallots.dart';
import 'dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import 'package:pogo/dynamoModels/IssueFactorValues/CandidateIssueFactorValues.dart';

Future<void> putUserIssueFactorValues(
    UserIssueFactorValues userIssueFactorValues) async {
  var client = http.Client();
  try {
    var response = await client.put(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/userissuefactorvalues'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(userIssueFactorValues.toJson()));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    print(decodedResponse);
  } catch (e) {
    safePrint('An error occurred in putUserIssueFactorValues() $e');
  } finally {
    client.close();
  }
}

Future<UserIssueFactorValues> getUserIssueFactorValues(String userId) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/userissuefactorvalues/$userId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return UserIssueFactorValues.fromJson(decodedResponse);
  } catch (e) {
    safePrint('An error occurred in getUserIssueFactorValues() $e');
    return UserIssueFactorValues(userId: userId);
  } finally {
    client.close();
  }
}

Future<void> putCandidateIssueFactorValues(
    CandidateIssueFactorValues candidateIssueFactorValues) async {
  var client = http.Client();
  try {
    var response = await client.put(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/candidateissuefactorvalues'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(candidateIssueFactorValues.toJson()));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
  } catch (e) {
    safePrint('An error occurred in putCandidateIssueFactorValues() $e');
  } finally {
    client.close();
  }
}

Future<CandidateIssueFactorValues> getCandidateIssueFactorValues(
    String candidateId) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/candidateissuefactorvalues/$candidateId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return CandidateIssueFactorValues.fromJson(decodedResponse);
  } catch (e) {
    safePrint('An error occurred in CandidateIssueFactorValues() $e');
    return CandidateIssueFactorValues(candidateId: candidateId);
  } finally {
    client.close();
  }
}

Future<void> putUserDemographics(UserDemographics userDemographics) async {
  var client = http.Client();
  try {
    var response = await client.put(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/userDemographics'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(userDemographics.toJson()));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
  } catch (e) {
    safePrint('An error occurred in putUserDemographics() $e');
  } finally {
    client.close();
  }
}

Future<UserDemographics> getUserDemographics(String userId) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/userDemographics/$userId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return UserDemographics.fromJson(decodedResponse);
  } catch (e) {
    safePrint('An error occurred in getUserDemographics() $e');
    return UserDemographics(id: userId);
  } finally {
    client.close();
  }
}

Future<void> putCandidateDemographics(
    CandidateDemographics candidateDemographics) async {
  var client = http.Client();
  try {
    var response = await client.put(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/candidateDemographics'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(candidateDemographics.toJson()));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
  } catch (e) {
    safePrint('An error occurred in putCandidateDemographics() $e');
  } finally {
    client.close();
  }
}

Future<CandidateDemographics> getCandidateDemographics(
    String candidateId) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/candidateDemographics/test/$candidateId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return CandidateDemographics.fromJson(decodedResponse);
  } catch (e) {
    safePrint('An error occurred in getCandidateDemographics() $e');
    return CandidateDemographics(id: candidateId);
  } finally {
    client.close();
  }
}

Future<List<CandidateDemographics>> getAllCandidateDemographics() async {
  var client = http.Client();
  var candidateDemographicsList = <CandidateDemographics>[];
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/candidateDemographics'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    for (var candidateDemographics in decodedResponse) {
      candidateDemographicsList
          .add(CandidateDemographics.fromJson(candidateDemographics));
    }
    return candidateDemographicsList;
  } catch (e) {
    safePrint('An error occurred in getAllCandidateDemographics() $e');
    return <CandidateDemographics>[];
  } finally {
    client.close();
  }
}

Future<void> putUserNationalBallot(UserNationalBallot userBallot) async {
  final client = http.Client();
  try {
    final response = await client.put(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/UserNationalBallots'),
        headers: {"content-type": "application/json"},
        body: jsonEncode(userBallot.toJson()));

    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    safePrint(
        "aws response: $decodedResponse ${response.statusCode} ${response.reasonPhrase}");
  } finally {
    client.close();
  }
}

Future<UserNationalBallot> getUserNationalBallot(String userId) async {
  final client = http.Client();
  try {
    final response = await client.get(
      Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
          '/UserNationalBallots/$userId'),
      headers: {"content-type": "application/json"},
    );
    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    safePrint(decodedResponse);
    return UserNationalBallot.fromJson(decodedResponse);
  } finally {
    client.close();
  }
}

Future<void> putUserStateBallot(UserStateBallot userBallot) async {
  final client = http.Client();
  try {
    final response = await client.put(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/UserStateBallots'),
        headers: {"content-type": "application/json"},
        body: jsonEncode(userBallot.toJson()));

    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    safePrint(decodedResponse);
  } finally {
    client.close();
  }
}

Future<UserStateBallot> getUserStateBallot(String userId) async {
  final client = http.Client();
  try {
    final response = await client.get(
      Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
          '/UserStateBallots/$userId'),
      headers: {"content-type": "application/json"},
    );
    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    safePrint(decodedResponse);
    return UserStateBallot.fromJson(decodedResponse);
  } finally {
    client.close();
  }
}

Future<void> putUserLocalBallot(UserLocalBallot userBallot) async {
  final client = http.Client();
  try {
    final response = await client.put(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/UserLocalBallots'),
        headers: {"content-type": "application/json"},
        body: jsonEncode(userBallot.toJson()));

    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    safePrint(decodedResponse);
  } finally {
    client.close();
  }
}

Future<UserLocalBallot> getUserLocalBallot(String userId) async {
  final client = http.Client();
  try {
    final response = await client.get(
      Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
          '/UserLocalBallots/$userId'),
      headers: {"content-type": "application/json"},
    );
    final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    safePrint(decodedResponse);
    return UserLocalBallot.fromJson(decodedResponse);
  } finally {
    client.close();
  }
}

Future<void> putUserBallot(String userId, List<String> localBallot,
    List<String> stateBallot, List<String> nationalBallot) async {
  final client = http.Client();
  try {
    final response = await client.put(
        Uri.https(
            'i4tti59faj.execute-api.us-east-1.amazonaws.com', '/userBallot'),
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          'userId': userId,
          'localBallot': localBallot,
          'stateBallot': stateBallot,
          'nationalBallot': nationalBallot,
        }));
    safePrint("AWS response: ${jsonDecode(utf8.decode(response.bodyBytes))}");
  } catch (e) {
    safePrint("An error occurred in putUserBallot() $e");
  } finally {
    client.close();
  }
}

Future<List<String>> getUserBallot(String userId) async {
  final client = http.Client();
  try {
    final response = await client.get(
      Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
          '/userBallot/$userId'),
      headers: {"content-type": "application/json"},
    );
    if (response.body.isNotEmpty) {
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      safePrint("decoded ballot: ${decodedResponse['localBallot']}");
      return decodedResponse['localBallot'].cast<String>();
    }
    return [];
  } catch (e) {
    safePrint("An error occurred in getUserBallot() $e");
    return [];
  } finally {
    client.close();
  }
}

Future<void> updateUserBallot(String userId, String candidateId) async {
  final allCandidates =
      await getAllCandidateDemographics(); //get a list of all available candidate (current one is mutated throughout executuion)
  List<String> userBallot =
      await getUserBallot(userId); //get the current user ballot
  //check if list is empty or does not exist
  if (userBallot.isEmpty) {
    putUserBallot(userId, [candidateId], [''], ['']);
    safePrint("first addition");
  } else {
    safePrint("initial ballot $userBallot");
    safePrint("all candidates: $allCandidates");
    final candidateObject = allCandidates.firstWhere((candidate) =>
        candidate.id ==
        candidateId); //Find the candidate object belonging to the candidate the user wants to add
    safePrint("candidateObject: $candidateObject");
    final candidateSeat =
        candidateObject.runningPosition; //seat of candidate user wants to add
    safePrint("candidate seat: $candidateSeat");
    var candidateToReplace;
    userBallot.forEach((candidateId) {
      final candidateObject =
          allCandidates.firstWhere((candidate) => candidate.id == candidateId);
      safePrint("found candidate: $candidateObject");
      //find current candidate object by comparing each candidate's seat type with the one the user wants to update
      if (candidateObject.runningPosition == candidateSeat) {
        candidateToReplace = candidateObject.id;
        safePrint("candidate found $candidateToReplace");
      }
    });
    if (candidateToReplace != null) {
      userBallot.removeWhere((candidateId) =>
          candidateId == candidateToReplace); //remove the candidate
    }
    userBallot.add(candidateId);
    safePrint("final ballot $userBallot");
    putUserBallot(userId, userBallot, [''], ['']);
  }
}

Future<List<CandidateIssueFactorValues>>
    getAllCandidateIssueFactorValues() async {
  var client = http.Client();
  var candidateFactorsList = <CandidateIssueFactorValues>[];
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/candidateissuefactorvalues'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    for (var candidateissuefactorvalues in decodedResponse) {
      candidateFactorsList
          .add(CandidateIssueFactorValues.fromJson(candidateissuefactorvalues));
    }
    return candidateFactorsList;
  } catch (e) {
    safePrint("An error occurred in getAllCandidateIssueFactorValues: $e");
    return <CandidateIssueFactorValues>[];
  } finally {
    client.close();
  }
}

Future<List<CandidateIssueFactorValues>> getUserCandidateStackIssueFactorValues(
    String userId) async {
  var client = http.Client();
  var candidateFactorsList = <CandidateIssueFactorValues>[];
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/userCandidateStack/test/issues/$userId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    for (var candidateissuefactorvalues in decodedResponse) {
      candidateFactorsList
          .add(CandidateIssueFactorValues.fromJson(candidateissuefactorvalues));
    }
    safePrint("candidate issues stack pulled");
    return candidateFactorsList;
  } catch (e) {
    safePrint(
        "An error occurred in getUserCandidateStackIssueFactorValues: $e");
    return <CandidateIssueFactorValues>[];
  } finally {
    client.close();
  }
}

Future<List<CandidateDemographics>> getUserCandidateStackDemographics(
    String userId) async {
  var client = http.Client();
  var candidateDemographicsList = <CandidateDemographics>[];
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/userCandidateStack/test/demographics/$userId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    for (var candidateDemographics in decodedResponse) {
      candidateDemographicsList
          .add(CandidateDemographics.fromJson(candidateDemographics));
    }
    safePrint("candidates demographics stack pulled");
    return candidateDemographicsList;
  } catch (e) {
    safePrint("An error occurred in getUserCandidateStackDemographics: $e");
    return <CandidateDemographics>[];
  } finally {
    client.close();
  }
}

Future<List<CandidateDemographics>> getUserCandidatesWithDeferred(
    String userId) async {
  final deferredIDs = await getDeferred(userId);
  var startingStack = await getUserCandidateStackDemographics(userId);
  //making serperate array to append at the end to prevent infinite loop
  var deferredList = <CandidateDemographics>[];
  for (var candidate in startingStack) {
    if (deferredIDs.contains(candidate.id)) {
      deferredList.add(candidate);
    }
  }
  //remove the deferred candidates
  startingStack.removeWhere((candidate) => deferredList.contains(candidate));
  //putting the deferred candidate in the back, change this to prevent candidates from showing up twice
  startingStack.addAll(deferredList);
  return startingStack;
}

Future<List<MatchingStatistics>> getUserCandidateStackStatistics(
    String userId) async {
  var client = http.Client();
  var matchStats = <MatchingStatistics>[];
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/userCandidateStack/$userId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    for (var stats in decodedResponse) {
      matchStats.add(MatchingStatistics.fromJson(stats));
    }
    safePrint("candidates demographics stack pulled");
    return matchStats;
  } catch (e) {
    safePrint("An error occurred in getUserCandidateStackStatistics: $e");
    return <MatchingStatistics>[];
  } finally {
    client.close();
  }
}

Future<void> matchCandidatesToUser(String userId) async {
  var client = http.Client();
  try {
    var response = await client.post(
        Uri.https(
            'i4tti59faj.execute-api.us-east-1.amazonaws.com', '/matching'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode({"userId": userId}));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    print(decodedResponse);
  } catch (e) {
    safePrint("An error occurred in matchCandidatesToUser: $e");
  } finally {
    client.close();
  }
}

Future<List<String>> getDeferred(String userId) async {
  final client = http.Client();
  try {
    final response = await client.get(
      Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
          '/userBallot/$userId'),
      headers: {"content-type": "application/json"},
    );
    if (response.body.isNotEmpty) {
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      safePrint("decoded deferred: ${decodedResponse['deferred']}");
      return decodedResponse['deferred'].cast<String>();
    }
    return [];
  } catch (e) {
    safePrint("An error occurred in getDeferred() $e");
    return [];
  } finally {
    client.close();
  }
}

Future<void> putDeferred(String deferred) async {
  final user = await getCurrentUser();
  final client = http.Client();
  try {
    var currentList = await getDeferred(user.username);
    currentList.add(deferred);
    final response = await client.put(
        Uri.https(
            'i4tti59faj.execute-api.us-east-1.amazonaws.com', '/userBallot'),
        headers: {"content-type": "application/json"},
        body: jsonEncode({
          'userId': user.username,
          'deferred': currentList,
        }));
    safePrint("AWS response: ${jsonDecode(utf8.decode(response.bodyBytes))}");
  } catch (e) {
    safePrint("An error occurred in putDeferred() $e");
  } finally {
    client.close();
  }
}

Future<Map<String, dynamic>> matchCandidatesToUserTest(
    UserIssueFactorValues userIssueFactorValues) async {
  var client = http.Client();
  try {
    var response = await client.post(
        Uri.https(
            'i4tti59faj.execute-api.us-east-1.amazonaws.com', '/matching/test'),
        headers: {
          "content-type": "application/json",
        },
        body: jsonEncode(userIssueFactorValues.toJson()));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    List<CandidateDemographics> demographicsList = [];
    List<CandidateIssueFactorValues> issueList = [];
    List<MatchingStatistics> statisticsList = [];
    for (var candidate in decodedResponse["body"]) {
      demographicsList
          .add(CandidateDemographics.fromJson(candidate["Demographics"]));
      issueList.add(CandidateIssueFactorValues.fromJson(
          candidate["Issue Factor Values"]));
      statisticsList.add(MatchingStatistics.fromJson(candidate["Statistics"]));
    }
    return {
      "Demographics": demographicsList,
      "Issues": issueList,
      "Statistics": statisticsList
    };
  } catch (e) {
    safePrint("An error occurred in matchCandidatesToUserTest: $e");
    return {};
  } finally {
    client.close();
  }
}
