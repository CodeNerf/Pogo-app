class Ballot {
  List<String> mayorListIds = [];
  List<String> cityClerkIds = [];
  List<String> townCityCouncilIds = [];
  List<String> countyCommissionerIds = [];
  List<String> countyBoardOfSupervisorsIds = [];
  List<String> countySheriffIds = [];
  List<String> trialCourtJudgesIds = [];
  List<String> countyRegisterOfDeedsIds = [];
  List<String> schoolBoardIds = [];
  List<String> prosecutorsIds = [];
  List<String> coronersIds = [];
  List<String> planningZoningCommissionersIds = [];
  List<String> publicWorksCommissionersIds = [];

  Ballot(
      this.mayorListIds,
      this.cityClerkIds,
      this.townCityCouncilIds,
      this.countyCommissionerIds,
      this.countyBoardOfSupervisorsIds,
      this.countySheriffIds,
      this.trialCourtJudgesIds,
      this.countyRegisterOfDeedsIds,
      this.schoolBoardIds,
      this.prosecutorsIds,
      this.coronersIds,
      this.planningZoningCommissionersIds,
      this.publicWorksCommissionersIds);
}