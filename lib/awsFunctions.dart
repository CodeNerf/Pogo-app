import 'dart:convert';
import 'package:http/http.dart' as http;
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
            '/userissuefactorvalues'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    print(decodedResponse);
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
    String candidateIssueFactorValuesId) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https('i4tti59faj.execute-api.us-east-1.amazonaws.com',
            '/candidateissuefactorvalues'),
        headers: {
          "content-type": "application/json",
        });
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    return CandidateIssueFactorValues.fromJson(decodedResponse);
  } finally {
    client.close();
  }
}
