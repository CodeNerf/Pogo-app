import 'package:flutter/material.dart';
import 'package:pogo/Onboarding/Demographics2.dart';
import 'package:pogo/Onboarding/Issues.dart';
import '../dynamoModels/UserDemographics.dart';
import '../dynamoModels/UserIssueFactorValues.dart';

class VoterInfo extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  final int issuesIndex;
  const VoterInfo({Key? key, required this.ratings, required this.answers, required this.issuesIndex}) : super(key: key);

  @override
  State<VoterInfo> createState() => _VoterInfoState();
}

class _VoterInfoState extends State<VoterInfo> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  late UserDemographics _answers;
 String _voteMenuSelection = '';
  final List<String> _voteMenu = ['Yes', 'No'];

  String _partyMenuSelection = '';
  final List<String> _partyMenu = ['Republican', 'Democrat', 'Libertarian', 'Green', 'Independent'];

  String _votingPartyMenuSelection = '';
  final List<String> _votingPartyMenu = ['Republican', 'Democrat', 'Libertarian', 'Green', 'Independent'];

  String _registeredStateMenuSelection = '';
  final List<String> _registeredStateMenu = ['Yes', 'No'];

 @override
 void initState() {
   super.initState();
   setState(() {
     _answers = widget.answers;
     if(_answers.voterRegistrationStatus) {
       _voteMenuSelection = 'Yes';
     }
     else {
       _voteMenuSelection = 'No';
     }
     _partyMenuSelection = _answers.politicalAffiliation;
     //TODO: need party user votes with in db and if they live in state they are registered in
     _votingPartyMenuSelection = _answers.politicalAffiliation;
     //statedropdownvalue = answers.registeredState;
   });
 }

 void _goNextPage() {
   if(_voteMenuSelection == 'Yes') {
     widget.answers.voterRegistrationStatus = true;
   }
   widget.answers.politicalAffiliation = _partyMenuSelection;
   //TODO: add party user votes for String to db in case this is needed in matching algorithm
   //TODO: add user lives in registered state bool to db in case this value is needed in future
   Navigator.push(context, MaterialPageRoute(builder: (context) => Issues(ratings: widget.ratings, answers: widget.answers, issuesIndex: widget.issuesIndex,)));
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

Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Scaffold(
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
      body: Container(
        color: Color(0xFFF1F4F8),
        padding: const EdgeInsets.all(20.0),
        transformAlignment: Alignment.center,
        child: ListView(
          children: 
            [Column(
              children: [
                const SizedBox(height: 70),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                ),
                const SizedBox(height: 50),
                Expandable(
              title: 'Registration status',
              chooseText: 'Are you registered to vote?',
              options: [
                'Yes', 'No'
              ],
              onIndexChanged: _handleIndexChanged,
            ),
            const SizedBox(height: 20),
            Expandable(
              title: 'Political party',
              chooseText: 'What is your political party',
              options: [
                'Republican', 'Democrat', 'Libertarian', 'Green', 'Independent'
              ],
              onIndexChanged: _handleIndexChanged,
            ),
            const SizedBox(height: 20),
            Expandable(
              title: 'Voting preference',
              chooseText: 'How do you vote?',
              options: [
                'Republican', 'Democrat', 'Libertarian', 'Green', 'Independent'
              ],
              onIndexChanged: _handleIndexChanged,
            ),
            const SizedBox(height: 20),
            Expandable(
              title: 'Voter residency',
              chooseText: 'Do you live in your registered state',
              options: [
                'Yes', 'No'
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
                      _goNextPage();
                    },
                    color: const Color(0xFFF3D433),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Issues",
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