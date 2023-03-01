class user {
  String _fname;
  String _lname;
  String _email;
  String _phone;
  String _address;

  user.all(this._fname, this._lname, this._email, this._phone, this._address);

  String get fname => _fname;
  String get lname => _lname;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;

  set fname(String s) => _fname = s;
  set lname(String s) => _lname = s;
  set email(String s) => _email = s;
  set phone(String s) => _phone = s;
  set address(String s) => _address = s;
}