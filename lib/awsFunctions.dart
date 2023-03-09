import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';
import 'package:http/http.dart' as http;
import 'package:pogo/dynamoModels/CandidateDemographics.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'package:pogo/googleFunctions/CivicModels.dart';
import 'package:pogo/models/userBallots.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';

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
    print(decodedResponse);
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
    print(decodedResponse);
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
    print(decodedResponse);
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
            '/candidateDemographics/$candidateId'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    safePrint(decodedResponse);
    return CandidateDemographics.fromJson(decodedResponse);
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
        candidate.candidateId ==
        candidateId); //Find the candidate object belonging to the candidate the user wants to add
    safePrint("candidateObject: $candidateObject");
    final candidateSeat =
        candidateObject.seatType; //seat of candidate user wants to add
    safePrint("candidate seat: $candidateSeat");
    var candidateToReplace;
    userBallot.forEach((candidateId) {
      final candidateObject = allCandidates
          .firstWhere((candidate) => candidate.candidateId == candidateId);
      safePrint("found candidate: $candidateObject");
      //find current candidate object by comparing each candidate's seat type with the one the user wants to update
      if (candidateObject.seatType == candidateSeat) {
        candidateToReplace = candidateObject.candidateId;
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
    safePrint("candidates pulled");
    return candidateFactorsList;
  } finally {
    client.close();
  }
}
