import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'Demographics2.dart';
import 'Issues.dart';
import 'VoterInfo.dart';
import '../dynamoModels/UserIssueFactorValues.dart';

class VoterInfo2 extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  final int issuesIndex;
  const VoterInfo2({Key? key, required this.ratings, required this.answers, required this.issuesIndex})
      : super(key: key);

  @override
  State<VoterInfo2> createState() => _VoterInfo2State();
}

class _VoterInfo2State extends State<VoterInfo2> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  bool _regStatusExpand = false;
  bool _partyExpand = false;
  bool _preferenceExpand = false;
  bool _residencyExpand = false;
  Color _nextButtonColor = const Color(0xFF808080);

  void _nextPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Issues(
              ratings: widget.ratings,
              answers: widget.answers,
              issuesIndex: widget.issuesIndex,
            )));
  }

  void _expandTap(bool expanded, int index) {
    if(expanded) {
      switch (index) {
        case 0:
          _regStatusExpand = true;
          _residencyExpand = false;
          _partyExpand = false;
          _preferenceExpand = false;
          break;
        case 1:
          _regStatusExpand = false;
          _residencyExpand = true;
          _partyExpand = false;
          _preferenceExpand = false;
          break;
        case 2:
          _regStatusExpand = false;
          _residencyExpand = false;
          _partyExpand = true;
          _preferenceExpand = false;
          break;
        case 3:
          _regStatusExpand = false;
          _residencyExpand = false;
          _partyExpand = false;
          _preferenceExpand = true;
          break;
      }
      setState(() {});
    }
    else {
      _regStatusExpand = false;
      _residencyExpand = false;
      _partyExpand = false;
      _preferenceExpand = false;
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

  void _goBack() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Demographics2(
          ratings: widget.ratings,
          answers: widget.answers,
          issuesIndex: widget.issuesIndex,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.answers.politicalAffiliation != "") {
      _nextButtonColor = const Color(0xFFF3D433);
    }
  }

  void radioButtonSelected(int tileIndex, String selection, bool status) {
    if(tileIndex == 0) {
      //set registration status
      widget.answers.voterRegistrationStatus = status;
    }
    else if(tileIndex == 1) {
      //set registered state status
      widget.answers.liveInRegisteredState = status;
    }
    else if(tileIndex == 2) {
      //set political party affiliation
      widget.answers.politicalAffiliation = selection;
    }
    else {
      //set how do you vote
      widget.answers.partyVoting = selection;
    }
    //check if all options are filled, changed button to yellow if so
    if(widget.answers.partyVoting != "" && widget.answers.politicalAffiliation != "") {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => _goBack(),
          ),
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
                    "Voter Info",
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

                //registration status dropdown
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
                      initiallyExpanded: _regStatusExpand,
                      onExpansionChanged: (bool expanded) {
                        _expandTap(expanded, 0);
                      },
                      title: const Text(
                        'registration status',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'Are you registered to vote?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Yes', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: true,
                          groupValue: widget.answers.voterRegistrationStatus,
                          onChanged: (Object? o) {
                            radioButtonSelected(0, "", true);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('No', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: false,
                          groupValue: widget.answers.voterRegistrationStatus,
                          onChanged: (Object? o) {
                            radioButtonSelected(0, "", false);
                          }
                        ),
                      ],
                    ),
                  ),
                ),

                //do you live in registered state dropdown
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
                      initiallyExpanded: _residencyExpand,
                      onExpansionChanged: (bool expanded) {
                        _expandTap(expanded, 1);
                      },
                      title: const Text(
                        'registered state',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Do you currently live in the state that you are registered to vote in?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Yes', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: true,
                          groupValue: widget.answers.liveInRegisteredState,
                          onChanged: (Object? o) {
                            radioButtonSelected(1, "", true);
                          }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('No', style: optionsTextStyle()),
                          activeColor: Colors.black,
                          value: false,
                          groupValue: widget.answers.liveInRegisteredState,
                          onChanged: (Object? o) {
                            radioButtonSelected(1, "", false);
                          }
                        ),
                      ],
                    ),
                  ),
                ),

                //political party dropdown
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
                      initiallyExpanded: _partyExpand,
                      onExpansionChanged: (bool expanded) {
                        _expandTap(expanded, 2);
                      },
                      title: const Text(
                        'political party',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Which political party do you align with?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Republican', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Republican",
                            groupValue: widget.answers.politicalAffiliation,
                            onChanged: (String? s) {
                              radioButtonSelected(2, s!, false);
                            }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Democratic', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Democratic",
                            groupValue: widget.answers.politicalAffiliation,
                            onChanged: (String? s) {
                              radioButtonSelected(2, s!, false);
                            }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Libertarian', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Libertarian",
                            groupValue: widget.answers.politicalAffiliation,
                            onChanged: (String? s) {
                              radioButtonSelected(2, s!, false);
                            }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Green', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Green",
                            groupValue: widget.answers.politicalAffiliation,
                            onChanged: (String? s) {
                              radioButtonSelected(2, s!, false);
                            }
                        ),
                        RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          title: Text('Independent', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Independent",
                            groupValue: widget.answers.politicalAffiliation,
                            onChanged: (String? s) {
                              radioButtonSelected(2, s!, false);
                            }
                        ),
                      ],
                    ),
                  ),
                ),

                //how do you vote dropdown
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
                      initiallyExpanded: _preferenceExpand,
                      onExpansionChanged: (bool expanded) {
                        _expandTap(expanded, 3);
                      },
                      title: const Text(
                        'how do you vote?',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            'Which political party do you vote for?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ),
                        RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text('Republican', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Republican",
                            groupValue: widget.answers.partyVoting,
                            onChanged: (String? s) {
                              radioButtonSelected(3, s!, false);
                            }
                        ),
                        RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text('Democratic', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Democratic",
                            groupValue: widget.answers.partyVoting,
                            onChanged: (String? s) {
                              radioButtonSelected(3, s!, false);
                            }
                        ),
                        RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text('Libertarian', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Libertarian",
                            groupValue: widget.answers.partyVoting,
                            onChanged: (String? s) {
                              radioButtonSelected(3, s!, false);
                            }
                        ),
                        RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text('Green', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Green",
                            groupValue: widget.answers.partyVoting,
                            onChanged: (String? s) {
                              radioButtonSelected(3, s!, false);
                            }
                        ),
                        RadioListTile(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            title: Text('Independent', style: optionsTextStyle()),
                            activeColor: Colors.black,
                            value: "Independent",
                            groupValue: widget.answers.partyVoting,
                            onChanged: (String? s) {
                              radioButtonSelected(3, s!, false);
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