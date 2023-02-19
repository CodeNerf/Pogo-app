import 'dart:convert';
import 'dart:ffi';

import 'package:amplify_core/amplify_core.dart';

import 'APIKey.dart';
import 'package:http/http.dart' as http;

class Election extends Model {
  Long id;
  String name;
  String electionDay;
  String ocdDivisionId;

  Election(
      {required this.id,
      required this.name,
      required this.electionDay,
      required this.ocdDivisionId});

  factory Election.fromJson(Map<String, dynamic> json) {
    return Election(
      id: json['id'],
      name: json['name'],
      electionDay: json['electionDay'],
      ocdDivisionId: json['ocdDivisionId'],
    );
  }
}

Future<void> getElection() async {
  final url = Uri.parse(
      "https://www.googleapis.com/civicinfo/v2/elections?key=$googleAPIKey");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    safePrint(jsonResponse);
  } else {
    safePrint(
        'Request failed with status: ${response.statusCode} ${response.reasonPhrase}.');
  }
}
