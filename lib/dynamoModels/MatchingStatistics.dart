class MatchingStatistics {
  final String candidateId;
  num correlationCoefficient;
  num rSquared;

  MatchingStatistics({
    required this.candidateId,
    this.correlationCoefficient = 0,
    this.rSquared = 0,
  });

  //factory constructor
  factory MatchingStatistics.fromJson(Map json) {
    return MatchingStatistics(
      candidateId: json['candidateId'],
      correlationCoefficient: json['R'],
      rSquared: json['R-Squared'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateId': candidateId,
      'R': correlationCoefficient,
      'R-Squared': rSquared,
    };
  }
}
