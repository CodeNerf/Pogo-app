class Demographics {
  String id;
  String dateOfBirth;
  String profileImageURL;
  String gender;
  String racialIdentity;
  String politicalAffiliation;
  String addressLine1;
  String city;
  String zipCode;
  String phoneNumber;
  String email;

  // Constructor
  Demographics(
      {required this.id,
      required this.dateOfBirth,
      required this.profileImageURL,
      required this.gender,
      required this.racialIdentity,
      required this.politicalAffiliation,
      required this.addressLine1,
      required this.city,
      required this.zipCode,
      required this.phoneNumber,
      required this.email});
}
