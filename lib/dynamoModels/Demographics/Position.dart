class Position {
  String title;
  String organization;
  String years;

  // Constructor
  Position(
      {required this.title, required this.organization, required this.years});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      title: json['title'],
      organization: json['organization'],
      years: json['years'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'organization': organization,
      'years': years,
    };
  }
}
