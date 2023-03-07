class CandidateDemographics {
  String _startDate = '';
  String _racialIdentity = '';
  String _fname = '';
  String _lname = '';
  String _gender = '';
  String _candidateId = '';
  String _profileImageURL = '';
  String _electionType = '';
  String _seatType = '';
  String _politicalAffiliation = '';
  String _birth = '';
  String _zip = '';

  CandidateDemographics.empty();

  CandidateDemographics(this._startDate, this._racialIdentity, this._fname, this._lname, this._gender, this._candidateId, this._profileImageURL, this._electionType, this._seatType, this._politicalAffiliation, this._birth, this._zip);

  String get zip => _zip;

  String get birth => _birth;

  String get politicalAffiliation => _politicalAffiliation;

  String get seatType => _seatType;

  String get electionType => _electionType;

  String get profileImageURL => _profileImageURL;

  String get candidateId => _candidateId;

  String get gender => _gender;

  String get lname => _lname;

  String get fname => _fname;

  String get racialIdentity => _racialIdentity;

  String get startDate => _startDate;

  set zip(String value) {
    _zip = value;
  }

  set birth(String value) {
    _birth = value;
  }

  set politicalAffiliation(String value) {
    _politicalAffiliation = value;
  }

  set seatType(String value) {
    _seatType = value;
  }

  set electionType(String value) {
    _electionType = value;
  }

  set profileImageURL(String value) {
    _profileImageURL = value;
  }

  set candidateId(String value) {
    _candidateId = value;
  }

  set gender(String value) {
    _gender = value;
  }

  set lname(String value) {
    _lname = value;
  }

  set fname(String value) {
    _fname = value;
  }

  set racialIdentity(String value) {
    _racialIdentity = value;
  }

  set startDate(String value) {
    _startDate = value;
  }
}