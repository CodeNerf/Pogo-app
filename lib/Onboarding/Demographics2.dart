import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'VoterInfo.dart';
import '../dynamoModels/UserIssueFactorValues.dart';
import 'VoterInfo2.dart';

class Demographics2 extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  final int issuesIndex;
  const Demographics2({Key? key, required this.ratings, required this.answers, required this.issuesIndex})
      : super(key: key);

  @override
  State<Demographics2> createState() => _Demographics2State();
}

class _Demographics2State extends State<Demographics2> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  bool ageExpand = false;
  bool ethnicityExpand = false;
  bool genderExpand = false;
  Color _nextButtonColor = Color(0xFF808080);

  void _nextPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VoterInfo2(
              ratings: widget.ratings,
              answers: widget.answers,
              issuesIndex: widget.issuesIndex,
            )));
  }

  void _expandTap(bool expanded, int index) {
    if(expanded) {
      switch (index) {
        case 0:
          ageExpand = true;
          ethnicityExpand = false;
          genderExpand = false;
          break;
        case 1:
          ageExpand = false;
          ethnicityExpand = true;
          genderExpand = false;
          break;
        case 2:
          ageExpand = false;
          ethnicityExpand = false;
          genderExpand = true;
          break;
      }
      setState(() {});
    }
    else {
      ageExpand = false;
      ethnicityExpand = false;
      genderExpand = false;
      setState(() {});
    }
  }

  TextStyle optionsTextStyle() {
    return const TextStyle(
        fontFamily: 'Inter',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 15.0,
        color: Color(0xFF57636C),
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.answers.racialIdentity != "") {
      _nextButtonColor = const Color(0xFFF3D433);
    }
  }

  void radioButtonSelected(int tileIndex, String selection) {
    if(tileIndex == 0) {
      //set age range
      widget.answers.dateOfBirth = selection;
    }
    else if(tileIndex == 1) {
      //set race/ethnicity
      widget.answers.racialIdentity = selection;
    }
    else {
      //set gender
      widget.answers.gender = selection;
    }
    //check if all options are filled, changed button to yellow if so
    if(widget.answers.racialIdentity != "" && widget.answers.dateOfBirth != "" && widget.answers.gender != "") {
      _nextButtonColor = const Color(0xFFF3D433);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Image(
            image: AssetImage(_pogoLogo),
            width: 150,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //demographic info text
                const Padding(
                  padding: EdgeInsets.only(bottom: 50),
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

                //age dropdown
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ExpansionTile(
                      key: GlobalKey(),
                      initiallyExpanded: ageExpand,
                      onExpansionChanged: (bool expanded) {
                        _expandTap(expanded, 0);
                      },
                      title: const Text(
                        'your age',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      children: [
                        const Text(
                          'Choose your age category',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            color: Color(0xFF57636C),
                          ),
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('18-25', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "18-25",
                          groupValue: widget.answers.dateOfBirth,
                          onChanged: (String? s) {
                            radioButtonSelected(0, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('26-35', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "26-35",
                          groupValue: widget.answers.dateOfBirth,
                          onChanged: (String? s) {
                            radioButtonSelected(0, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('36-55', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "36-55",
                          groupValue: widget.answers.dateOfBirth,
                          onChanged: (String? s) {
                            radioButtonSelected(0, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('56+', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "56+",
                          groupValue: widget.answers.dateOfBirth,
                          onChanged: (String? s) {
                            radioButtonSelected(0, s!);
                          }
                        ),
                      ],
                    ),
                  ),
                ),

                //ethnicity dropdown
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ExpansionTile(
                      key: GlobalKey(),
                      initiallyExpanded: ethnicityExpand,
                      onExpansionChanged: (bool expanded) {
                        _expandTap(expanded, 1);
                      },
                      title: const Text(
                        'race/ethnicity',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      children: [
                        const Text(
                          'I identify as...',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            color: Color(0xFF57636C),
                          ),
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Black', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Black",
                          groupValue: widget.answers.racialIdentity,
                          onChanged: (String? s) {
                            radioButtonSelected(1, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('White', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "White",
                          groupValue: widget.answers.racialIdentity,
                          onChanged: (String? s) {
                            radioButtonSelected(1, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Asian', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Asian",
                          groupValue: widget.answers.racialIdentity,
                          onChanged: (String? s) {
                            radioButtonSelected(1, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('American Indian/Alaska Native', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "American Indian/Alaska Native",
                          groupValue: widget.answers.racialIdentity,
                          onChanged: (String? s) {
                            radioButtonSelected(1, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Native Hawaiian/Pacific Islander', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Native Hawaiian/Pacific Islander",
                          groupValue: widget.answers.racialIdentity,
                          onChanged: (String? s) {
                            radioButtonSelected(1, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Hispanic/Latino', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Hispanic/Latino",
                          groupValue: widget.answers.racialIdentity,
                          onChanged: (String? s) {
                            radioButtonSelected(1, s!);
                          }
                        ),
                      ],
                    ),
                  ),
                ),

                //gender dropdown
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ExpansionTile(
                      key: GlobalKey(),
                      initiallyExpanded: genderExpand,
                      onExpansionChanged: (bool expanded) {
                        _expandTap(expanded, 2);
                      },
                      title: const Text(
                        'gender',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      children: [
                        const Text(
                          'I identify as...',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            color: Color(0xFF57636C),
                          ),
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Female', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Female",
                          groupValue: widget.answers.gender,
                          onChanged: (String? s) {
                            radioButtonSelected(2, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Male', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Male",
                          groupValue: widget.answers.gender,
                          onChanged: (String? s) {
                            radioButtonSelected(2, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Non-binary', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Non-binary",
                          groupValue: widget.answers.gender,
                          onChanged: (String? s) {
                            radioButtonSelected(2, s!);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Gender Non-conforming', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: "Gender Non-conforming",
                          groupValue: widget.answers.gender,
                          onChanged: (String? s) {
                            radioButtonSelected(2, s!);
                          }
                        ),
                      ],
                    ),
                  ),
                ),

                //next button
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
                        color: _nextButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
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
      ),
    );
  }
}