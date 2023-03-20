import 'dart:convert';
import 'package:amplify_core/amplify_core.dart';
//import 'APIKey.dart';
import 'package:http/http.dart' as http;
import 'package:pogo/googleFunctions/APIKey.dart';
import 'CivicModels.dart';

/*
Future<List<Election>> getElection() async {
  final queryParams = {'key': "theKey"};
  final url =
      Uri.https("www.googleapis.com", "/civicinfo/v2/elections", queryParams);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    final electionsJson = jsonResponse['elections'] as List<dynamic>?;
    final List<Election> elections = electionsJson != null
        ? electionsJson.map((election) => Election.fromJson(election)).toList()
        : <Election>[];
    return List<Election>.from(elections);
  } else {
    safePrint(
        'Request failed with status: ${response.statusCode} ${response.reasonPhrase}.');
    return <Election>[];
  }
}
*/

Future<List<PollingLocation>> getPollingLocation(String address) async {
  final queryParams = {
    'key': googleAPIKey,
    'address': address,
    'electionId':
        '2000', //TODO remove test election when we find a working address
  };
  final url =
      Uri.https("www.googleapis.com", "civicinfo/v2/voterinfo", queryParams);
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final locationsJson = jsonResponse['pollingLocations'] as List<dynamic>?;
      final locations = locationsJson != null
          ? locationsJson
              .map((location) => PollingLocation.fromJson(location))
              .toList()
          : <PollingLocation>[];
      return List<PollingLocation>.from(locations);
    } else {
      safePrint(
          'Request failed with status:  ${response.statusCode} ${response.reasonPhrase}');
      return <PollingLocation>[];
    }
  } catch (e) {
    safePrint("Error occurred in getPollingLocation(): $e");
    return <PollingLocation>[];
  }
}

/*
Future<List<Candidate>> getCandidates(String Address, String electionId) async {
  final queryParams = {
    'key': "theKey",
    'address': Address,
    'electionId': electionId,
  };
  final url =
      Uri.https("www.googleapis.com", "civicinfo/v2/voterinfo", queryParams);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    final electionJson = jsonResponse['election'];
    final date = electionJson['electionDay'];
    final candidatesJson = jsonResponse['contests'][0]['candidates'];
    final candidates = candidatesJson != null
        ? candidatesJson
            .map((candidate) => Candidate.fromJson(candidate, date))
            .toList()
        : <Candidate>[];
    return List<Candidate>.from(candidates);
  } else {
    safePrint(
        'Request failed with status:  ${response.statusCode} ${response.reasonPhrase}');
    return <Candidate>[];
  }
}
 */
