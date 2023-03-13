class UserNationalBallot {
  final String userId;
  final String presidential;
  final String congressional;

  UserNationalBallot(
      {required this.userId,
      required this.presidential,
      required this.congressional});

  factory UserNationalBallot.fromJson(Map json) {
    return UserNationalBallot(
        userId: json['userId'],
        presidential: json['presidential'],
        congressional: json['congressional']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'presidential': presidential,
      'congressional': congressional
    };
  }
}

class UserStateBallot {
  final String userId;
  final String governor;
  final String secretaryOfState;
  final String attorneyGeneral;
  final List<String> stateSupremeCourt;
  final String comptroller;
  final String treasurer;
  final String stateRepresentative;
  final List<String> stateSenators;
  final List<String> stateLegislators;
  final String superintendent;
  final String educationCommissioner;
  final List<String> stateBoardOfEducation;
  final String publicServiceCommissioner;
  final String agricultureCommissioner;
  final List<String> bondInitiatives;
  final List<String> amendments;
  final List<String> recallElections;

  UserStateBallot(
      {required this.userId,
      required this.governor,
      required this.secretaryOfState,
      required this.attorneyGeneral,
      required this.stateSupremeCourt,
      required this.comptroller,
      required this.treasurer,
      required this.stateRepresentative,
      required this.stateSenators,
      required this.stateLegislators,
      required this.superintendent,
      required this.educationCommissioner,
      required this.stateBoardOfEducation,
      required this.publicServiceCommissioner,
      required this.agricultureCommissioner,
      required this.bondInitiatives,
      required this.amendments,
      required this.recallElections});

  factory UserStateBallot.fromJson(Map json) {
    return UserStateBallot(
        userId: json['userId'],
        governor: json['governor'],
        secretaryOfState: json['secretaryOfState'],
        attorneyGeneral: json['attorneyGeneral'],
        stateSupremeCourt: json['stateSupremeCourt'],
        comptroller: json['comptroller'],
        treasurer: json['treasurer'],
        stateRepresentative: json['stateRepresentative'],
        stateSenators: json['stateSenators'],
        stateLegislators: json['stateLegislators'],
        superintendent: json['superintendent'],
        educationCommissioner: json['educationCommissioner'],
        stateBoardOfEducation: json['stateBoardOfEducation'],
        publicServiceCommissioner: json['publicServiceCommissioner'],
        agricultureCommissioner: json['agricultureCommissioner'],
        bondInitiatives: json['bondInitiatives'],
        amendments: json['amendments'],
        recallElections: json['recallElections']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'governor': governor,
      'secretaryOfState': secretaryOfState,
      'attorneyGeneral': attorneyGeneral,
      'stateSupremeCourt': stateSupremeCourt,
      'comptroller': comptroller,
      'treasurer': treasurer,
      'stateRepresentative': stateRepresentative,
      'stateSenators': stateSenators,
      'stateLegislators': stateLegislators,
      'superintendent': superintendent,
      'educationCommissioner': educationCommissioner,
      'stateBoardOfEducation': stateBoardOfEducation,
      'publicServiceCommissioner': publicServiceCommissioner,
      'agricultureCommissioner': agricultureCommissioner,
      'bondInitiatives': bondInitiatives,
      'amendments': amendments,
      'recallElections': recallElections
    };
  }
}

class UserLocalBallot {
  final String userId;
  final String mayor;
  final List<String> cityCouncil;
  final String countySheriff;
  final List<String> trialCourtJudges;
  final String registerOfDeeds;
  final List<String> schoolBoard;
  final List<String> prosecuters;
  final List<String> coroners;
  final List<String> planningAndZoningCommissions;
  final List<String> publicWorksCommissions;
  final String commissionerOfRevenue;

  UserLocalBallot(
      {required this.userId,
      required this.mayor,
      required this.cityCouncil,
      required this.countySheriff,
      required this.trialCourtJudges,
      required this.registerOfDeeds,
      required this.schoolBoard,
      required this.prosecuters,
      required this.coroners,
      required this.planningAndZoningCommissions,
      required this.publicWorksCommissions,
      required this.commissionerOfRevenue});

  factory UserLocalBallot.fromJson(Map json) {
    return UserLocalBallot(
        userId: json['userId'],
        mayor: json['mayor'],
        cityCouncil: json['cityCouncil'],
        countySheriff: json['countySheriff'],
        trialCourtJudges: json['trialCourtJudges'],
        registerOfDeeds: json['registerOfDeeds'],
        schoolBoard: json['schoolBoard'],
        prosecuters: json['prosecuters'],
        coroners: json['coroners'],
        planningAndZoningCommissions: json['planningAndZoningCommissions'],
        publicWorksCommissions: json['publicWorksCommissions'],
        commissionerOfRevenue: json['commissionerOfRevenue']);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'mayor': mayor,
      'cityCouncil': cityCouncil,
      'countySheriff': countySheriff,
      'trialCourtJudges': trialCourtJudges,
      'registerOfDeeds': registerOfDeeds,
      'schoolBoard': schoolBoard,
      'prosecuters': prosecuters,
      'coroners': coroners,
      'planningAndZoningCommissions': planningAndZoningCommissions,
      'publicWorksCommissions': publicWorksCommissions,
      'commissionerOfRevenue': commissionerOfRevenue,
    };
  }
}
