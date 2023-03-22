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
                  color: Color(0xFFF1F4F8),
          padding: const EdgeInsets.all(20.0),
          transformAlignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 200),
            Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
          "Demographic Info",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            color: Color(0xFF0E0E0E),
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
            height: 1.2,
          ),
        ),
      ),
    ),
              const SizedBox(height: 50),


   Container(
  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(15.0),
    color: Color(0xFFF1F4F8),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      DropdownButtonFormField(
        decoration: InputDecoration.collapsed(hintText: 'your age'),
        value: _ageSelection,
        icon: const Icon(Icons.keyboard_arrow_up),
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
    ],
  ),
),



   Container(
  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(15.0),
    color: Color(0xFFF1F4F8),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      DropdownButtonFormField(
        decoration: InputDecoration.collapsed(hintText: 'race/ethnicity'),
        value: _ethnicitySelection,
        icon: const Icon(Icons.keyboard_arrow_up),
        isExpanded: true,
        focusColor: Colors.transparent,
        items: _ethnicityList.map((String ethnicity) {
          return DropdownMenuItem(
            value: ethnicity,
            child: Text(ethnicity),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _ethnicitySelection = newValue!;
          });
        },
      ),
    ],
  ),
),

              Container(
  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(15.0),
    color: Color(0xFFF1F4F8),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      DropdownButtonFormField(
        decoration: InputDecoration.collapsed(hintText: 'gender'),
        value: _genderSelection,
        icon: const Icon(Icons.keyboard_arrow_up),
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
    ],
  ),
),

 
              
        
              const SizedBox(height: 30),
        Padding(
  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0), 
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end, 
    children: [
      MaterialButton(
        minWidth: 150, 
        height: 60,
        onPressed: () {
          _nextPage();
        },
        color: const Color(0xFFF3D433),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Next",
          style: TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    ],
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}
