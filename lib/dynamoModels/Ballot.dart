class Ballot {
  List<String> localCandidateIds = List.filled(35, '');
  //List<String> stateCandidateIds = List.filled(35, '');
  //List<String> federalCandidateIds = List.filled(35, '');

  Ballot.candidateIds({required this.localCandidateIds /*, required this.stateCandidateIds, required this.federalCandidateIds */});


  Ballot.empty();

  //factory constructor
  factory Ballot.fromJson(Map json) {
    return Ballot.candidateIds(
      localCandidateIds: json['localCandidateIds'],
      //stateCandidateIds: json['stateCandidateIds'],
      //federalCandidateIds: json['federalCandidateIds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localCandidateIds': localCandidateIds,
      //'stateCandidateIds': stateCandidateIds,
      //'federalCandidateIds': federalCandidateIds,
    };
  }
}