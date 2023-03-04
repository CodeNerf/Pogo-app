import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pogo/dynamoModels/CandidateDemographics.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';
import 'models/IssueFactorValues.dart' hide IssueFactorValues;
import 'models/UserIssueFactorValues.dart' hide UserIssueFactorValues;

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
