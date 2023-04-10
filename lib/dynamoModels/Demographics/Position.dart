class Position {
  String title;
  String company;
  String date;

  // Constructor
  Position({required this.title, required this.company, required this.date});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      title: json['title'],
      company: json['company'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'date': date,
    };
  }
}
