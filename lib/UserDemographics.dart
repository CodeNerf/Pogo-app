class UserDemographics {
  String _age;
  String _ethnicity;
  String _gender;
  String _registered;
  String _party;
  String _howYouVote;
  String _liveInRegisteredState;

  UserDemographics(this._age, this._ethnicity, this._gender, this._registered, this._party, this._howYouVote, this._liveInRegisteredState);

  //getters
  String get age => _age;
  String get ethnicity => _ethnicity;
  String get gender => _gender;
  String get registered => _registered;
  String get party => _party;
  String get howYouVote => _howYouVote;
  String get liveInRegisteredState => _liveInRegisteredState;

  //setters
  set age(String s) => _age = s;
  set ethnicity(String s) => _ethnicity = s;
  set gender(String s) => _gender = s;
  set registered(String s) => _registered = s;
  set party(String s) => _party = s;
  set howYouVote(String s) => _howYouVote = s;
  set liveInRegisteredState(String s) => _liveInRegisteredState = s;
}