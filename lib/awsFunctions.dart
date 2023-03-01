import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dynamoModels/UserIssueFactorValues.dart';
import 'models/IssueFactorValues.dart' hide IssueFactorValues;
import 'models/UserIssueFactorValues.dart' hide UserIssueFactorValues;

Future<void> putUserIssueFactorValue(
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
