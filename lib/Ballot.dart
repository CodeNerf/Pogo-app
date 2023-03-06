class Ballot {
  List<String> mayorListPicURLs = [];
  List<String> cityClerkPicURLs = [];
  List<String> townCityCouncilPicURLs = [];
  List<String> countyCommissionerPicURLs = [];
  List<String> countyBoardOfSupervisorsPicURLs = [];
  List<String> countySheriffPicURLs = [];
  List<String> trialCourtJudgesPicURLs = [];
  List<String> countyRegisterOfDeedsPicURLs = [];
  List<String> schoolBoardPicURLs = [];
  List<String> prosecutorsPicURLs = [];
  List<String> coronersPicURLs = [];
  List<String> planningZoningCommissionersPicURLs = [];
  List<String> publicWorksCommissionersPicURLs = [];

  Ballot(
      this.mayorListPicURLs,
      this.cityClerkPicURLs,
      this.townCityCouncilPicURLs,
      this.countyCommissionerPicURLs,
      this.countyBoardOfSupervisorsPicURLs,
      this.countySheriffPicURLs,
      this.trialCourtJudgesPicURLs,
      this.countyRegisterOfDeedsPicURLs,
      this.schoolBoardPicURLs,
      this.prosecutorsPicURLs,
      this.coronersPicURLs,
      this.planningZoningCommissionersPicURLs,
      this.publicWorksCommissionersPicURLs);

  Ballot.empty();
}