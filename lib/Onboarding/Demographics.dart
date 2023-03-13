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
  String _ageSelection = '16-25 years old';
  late String _ethnicitySelection = '';
  late String _genderSelection = '';
  String pogoLogo = 'assets/Pogo_logo_horizontal.png';

  @override
  void initState() {
    super.initState();
    setState(() {
      _ethnicitySelection = widget.answers.racialIdentity;
      _genderSelection = widget.answers.gender;
    });
  }

  // List of items for each dropdown menu
  final List<String> _ageList = [
    '16-25 years old',
    '26-35 years old',
    '36-55 years old',
    '56+ years old',
  ];

  final List<String> _ethnicityList = [
    '',
    'Black',
    'White',
    'Asian',
    'American Indian/Alaska Native',
    'Native Hawaiian/Pacific Islander',
    'Hispanic/Latino',
  ];

  final List<String> _genderList = [
    '',
    'Female',
    'Male',
    'Non-binary',
    'Gender Non-conforming',
    'Other',
  ];

  void _nextPage() async {
    widget.answers.racialIdentity = _ethnicitySelection;
    widget.answers.gender = _genderSelection;
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
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Choose your age category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                value: _ageSelection,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                focusColor: Colors.transparent,
                items: _ageList.map((String age) {
                  return DropdownMenuItem(
                    value: age,
                    child: Text(age),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _ageSelection = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'I identify as',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                value: _ethnicitySelection,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                focusColor: Colors.transparent,
                items: _ethnicityList.map((String race) {
                  return DropdownMenuItem(
                    value: race,
                    child: Text(race),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _ethnicitySelection = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'I identify as',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                value: _genderSelection,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                focusColor: Colors.transparent,
                items: _genderList.map((String gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _genderSelection = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),
              MaterialButton(
                height: 50,
                onPressed: () {
                  _nextPage();
                },
                color: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: const Text(
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
