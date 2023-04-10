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
      placeOfEducation: json['placeOfEducation'],
      degreeInformation: json['degreeInformation'],
      yearOfGraduation: json['yearOfGraduation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeOfEducation': placeOfEducation,
      'degreeInformation': degreeInformation,
      'yearOfGraduation': yearOfGraduation,
    };
  }
}
