import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/IssueFactorValues.dart';

Future<void> putIssueFactorValue(IssueFactorValues issueFactorValues) async {
  var client = http.Client();
  try {
    var response = await client.post(Uri.https('example.com', 'whatsit/create'),
        body: {'name': 'doodle', 'color': 'blue'});
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var uri = Uri.parse(decodedResponse['uri'] as String);
    print(await client.get(uri));
  } finally {
    client.close();
  }
}
