class Education {
  String placeOfEducation;
  String degreeInformation;
  String yearOfGraduation;
  // Constructor
  Education(
      {required this.placeOfEducation,
      required this.degreeInformation,
      required this.yearOfGraduation});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      placeOfEducation: json['school'],
      degreeInformation: json['degreeInformation'],
      yearOfGraduation: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeOfEducation': placeOfEducation,
      'degreeInformation': degreeInformation,
      'year': yearOfGraduation,
    };
  }
}
