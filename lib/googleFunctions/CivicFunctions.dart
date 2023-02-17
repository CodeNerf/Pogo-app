import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';
import 'APIKey.dart';
import 'package:http/http.dart' as http;
import 'CivicModels.dart';

Future<void> getElection() async {
  final queryParams = {'key': googleAPIKey};
  final url = Uri.https(
      "civicinfo.googleapis.com", "/civicinfo/v2/elections", queryParams);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    safePrint(jsonResponse);
  } else {
    safePrint(
        'Request failed with status: ${response.statusCode} ${response.reasonPhrase}.');
  }
}

Future<void> getPollingLocation(String address) async {
  final queryParams = {
    'key': googleAPIKey,
    'address': address,
    'electionId': '2000',
  };
  final url = Uri.https(
      "civicinfo.googleapis.com", "civicinfo/v2/voterinfo", queryParams);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    final locationsJson = jsonResponse['pollingLocations'] as List<dynamic>;
    final locations = locationsJson != null
        ? locationsJson
            .map((location) => PollingLocation.fromJson(location))
            .toList()
        : <PollingLocation>[];
    safePrint(locations);
  } else {
    safePrint(
        'Request failed with status:  ${response.statusCode} ${response.reasonPhrase}');
  }
}
