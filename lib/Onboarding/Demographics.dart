import 'package:flutter/material.dart';
import 'package:pogo/Onboarding/SurveyLandingPage.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'VoterInfo.dart';
import '../dynamoModels/UserIssueFactorValues.dart';

class Demographics extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  const Demographics({Key? key, required this.ratings, required this.answers})
      : super(key: key);

  @override
  State<Demographics> createState() => _DemographicsState();
}

class _DemographicsState extends State<Demographics> {
  late UserDemographics answers;
  String agesdropdownvalue = '18-25 years old';
  String racesdropdownvalue = 'Black';
  String gendersdropdownvalue = 'Female';
  final Widget lastPage = SurveyLandingPage();
  String pogoLogo = 'assets/Pogo_logo_horizontal.png';

  @override
  void initState() {
    super.initState();
    setState(() {
      answers = widget.answers;
    });
  }

  // List of items for each dropdown menu
  List<String> agesList = [
    '18-25 years old',
    '26-35 years old',
    '36-55 years old',
    '56+ years old',
  ];

  List<String> racesList = [
    'Black',
    'White',
    'Asian',
    'American Indian/Alaska Native',
    'Native Hawaiian/Pacific Islander',
    'Hispanic/Latino',
  ];

  List<String> gendersList = [
    'Female',
    'Male',
    'Non-binary',
    'Gender Non-conforming',
    'Other',
  ];

  void nextPage() async {
    widget.answers.racialIdentity = racesdropdownvalue;
    widget.answers.gender = gendersdropdownvalue;
    //TODO: the age dropdown needs to be turned into a date picker for bday
    //widget.answers.dateOfBirth = dateOfBirthStringHere;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VoterInfo(
              ratings: widget.ratings,
              answers: widget.answers,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          transformAlignment: Alignment.center,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Choose your age category',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                value: agesdropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                focusColor: Colors.transparent,
                items: agesList.map((String age) {
                  return DropdownMenuItem(
                    value: age,
                    child: Text(age),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    agesdropdownvalue = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'I identify as',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                value: racesdropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                focusColor: Colors.transparent,
                items: racesList.map((String race) {
                  return DropdownMenuItem(
                    value: race,
                    child: Text(race),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    racesdropdownvalue = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'I identify as',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                value: gendersdropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                focusColor: Colors.transparent,
                items: gendersList.map((String gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    gendersdropdownvalue = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),
              MaterialButton(
                height: 50,
                onPressed: () {
                  nextPage();
                },
                color: Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
