class Ballot {
  List<String> localCandidateIds = List.filled(35, '');
  //List<String> stateCandidateIds = List.filled(35, '');
  //List<String> federalCandidateIds = List.filled(35, '');

  Ballot.localCandidateIds({required this.localCandidateIds});
  //Ballot.stateCandidateIds(this.stateCandidateIds);
  //Ballot.federalCandidateIds(this.federalCandidateIds);

  Ballot.empty();

  //factory constructor
  factory Ballot.fromJson(Map json) {
    return Ballot.localCandidateIds(
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