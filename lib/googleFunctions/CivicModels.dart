class Election {
  final id;
  final String name;
  final String electionDay;
  final String ocdDivisionId;

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
  @override
  String toString() {
    return id + ' ' + name + ' ' + electionDay + ' ' + ocdDivisionId;
  }
}

class PollingLocation {
  final locationName;
  final street;
  final city;
  final state;
  final zip;

  PollingLocation(
      {required this.locationName,
      required this.street,
      required this.city,
      required this.state,
      required this.zip});
  factory PollingLocation.fromJson(Map<String, dynamic> json) {
    return PollingLocation(
        locationName: json['locationName'],
        street: json['line1'] + json['line2'] + json['line3'],
        city: json['city'],
        state: json['state'],
        zip: json['zip']);
  }
  String getFullAddress() {
    return street + city + state + zip;
  }
}

class Candidate {
  final name;
  final party;
  final date;

  Candidate({
    required this.name,
    required this.party,
    required this.date,
  });

  factory Candidate.fromJson(Map<String, dynamic> json, String date) {
    return Candidate(
      name: json['name'],
      party: json['party'],
      date: date,
    );
  }
}
