import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'VoterInfo.dart';
import '../dynamoModels/UserIssueFactorValues.dart';

class Demographics extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  final int issuesIndex;
  const Demographics({Key? key, required this.ratings, required this.answers, required this.issuesIndex})
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
    if (mounted) {
  setState(() {
      _ethnicitySelection = widget.answers.racialIdentity;
      _genderSelection = widget.answers.gender;
    });
}
    
  }

//   // List of items for each dropdown menu
//   final List<String> _ageList = [
//     '16-25 years old',
//     '26-35 years old',
//     '36-55 years old',
//     '56+ years old',
//   ];
// List<String> ageRanges = [  '16-25 years old',  '26-35 years old',  '36-55 years old',  '56+ years old',];

//   final List<String> ethnicityList = [
//     '',
//     'Black',
//     'White',
//     'Asian',
//     'American Indian/Alaska Native',
//     'Native Hawaiian/Pacific Islander',
//     'Hispanic/Latino',
//   ];

//   final List<String> genderList = [
//     '',
//     'Female',
//     'Male',
//     'Non-binary',
//     'Gender Non-conforming',
//     'Other',
//   ];

  void _nextPage() async {
    widget.answers.racialIdentity = _ethnicitySelection;
    widget.answers.gender = _genderSelection;
    //widget.answers.dateOfBirth = dateOfBirthStringHere;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VoterInfo(
                  ratings: widget.ratings,
                  answers: widget.answers,
                  issuesIndex: widget.issuesIndex,
                )));
  }

  int _selectedOption = -1;

Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Scaffold(
      body: Container(
        color: Color(0xFFF1F4F8),
        padding: const EdgeInsets.only(right: 10),
        transformAlignment: Alignment.center,
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 70),
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
                  Expandable(
                    title: 'Your age',
                    chooseText: 'Choose your age category',
                    options: [
                      '16-25 years old',
                      '26-35 years old',
                      '36-55 years old',
                      '56+ years old',
                    ],
                    onIndexChanged: _handleIndexChanged,
                  ),
                  const SizedBox(height: 20),
                  Expandable(
                    title: 'Race/ethnicity',
                    chooseText: 'I identify as...',
                    options: [
                      'Black',
                      'White',
                      'Asian',
                      'American Indian/Alaska Native',
                      'Native Hawaiian/Pacific Islander',
                      'Hispanic/Latino',
                    ],
                    onIndexChanged: _handleIndexChanged,
                  ),
                  const SizedBox(height: 20),
                  Expandable(
                    title: 'Gender',
                    chooseText: 'I identify as...',
                    options: [
                      'Female',
                      'Male',
                      'Non-binary',
                      'Gender Non-conforming',
                   ],
                    onIndexChanged: _handleIndexChanged,
                  ),
                  const SizedBox(height: 40),
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
                   const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}

  _handleIndexChanged(int? p1) {
  }
}
class Expandable extends StatefulWidget {
  final String title;
  final String chooseText;
  final List<String> options;
  final Function(int?)? onIndexChanged;

  Expandable({
    required this.title,
    required this.chooseText,
    required this.options,
    this.onIndexChanged,
  });

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> {
  int _selectedIndex = -1;
  bool _expanded = false;
  static _ExpandableState? _lastExpanded;

  void _handleIndexChanged(int? index) {
    setState(() {
      _selectedIndex = index ?? -1;
      if (widget.onIndexChanged != null) {
        widget.onIndexChanged!(_selectedIndex);
      }
    });
  }

  void collapse() {
    setState(() {
      _expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (_lastExpanded != null && _lastExpanded != this) {
                  _lastExpanded!.collapse();
                }
                _expanded = !_expanded;
                if (_expanded) {
                  _lastExpanded = this;
                }
              });
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0),
                  bottom: Radius.circular(_expanded ? 0.0 : 15.0),
                ),
                color: Color(0xFFF1F4F8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                        color: Color(0xFF57636C),
                      ),
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: 40,
                    color: Color(0xFF57636C),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.chooseText,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < widget.options.length; i++)
                    Column(
                      children: [
                        Container(
                          child: RadioListTile(
                            dense: true,
                            title: Text(
                              widget.options[i],
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Color(0xFF57636C),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(bottom: .0),
                            value: i,
                            groupValue: _selectedIndex,
                            onChanged: _handleIndexChanged,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}