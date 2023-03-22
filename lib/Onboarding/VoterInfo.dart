import 'package:flutter/material.dart';
import 'package:pogo/Onboarding/Issues.dart';
import '../dynamoModels/UserDemographics.dart';
import '../dynamoModels/UserIssueFactorValues.dart';

class VoterInfo extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  const VoterInfo({Key? key, required this.ratings, required this.answers}) : super(key: key);

  @override
  State<VoterInfo> createState() => _VoterInfoState();
}

class _VoterInfoState extends State<VoterInfo> {
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
   Navigator.push(context, MaterialPageRoute(builder: (context) => Issues(ratings: widget.ratings, answers: widget.answers,)));
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        decoration: InputDecoration.collapsed(hintText: 'registration status'),
        value: _voteMenuSelection.isNotEmpty ? _voteMenuSelection : null,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        focusColor: Colors.transparent,
        items: _voteMenu.map((String vote) {
          return DropdownMenuItem(
            value: vote,
            child: Text(vote),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _voteMenuSelection = newValue!;
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
        decoration: InputDecoration.collapsed(hintText: 'political party'),
        value: _partyMenuSelection.isNotEmpty ? _partyMenuSelection : null,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        focusColor: Colors.transparent,
        items: _partyMenu.map((String parties) {
          return DropdownMenuItem(
            value: parties,
            child: Text(parties),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _partyMenuSelection = newValue!;
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
        decoration: InputDecoration.collapsed(hintText: 'how do you vote?'),
        value: _votingPartyMenuSelection.isNotEmpty ? _votingPartyMenuSelection : null,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        focusColor: Colors.transparent,
        items: _votingPartyMenu.map((String voteParty) {
          return DropdownMenuItem(
            value: voteParty,
            child: Text(voteParty),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _votingPartyMenuSelection = newValue!;
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
        decoration: InputDecoration.collapsed(hintText: 'do you live in your registered state?'),
        value: _registeredStateMenuSelection.isNotEmpty ? _registeredStateMenuSelection : null,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        focusColor: Colors.transparent,
        items: _registeredStateMenu.map((String state) {
          return DropdownMenuItem(
            value: state,
            child: Text(state),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _registeredStateMenuSelection = newValue!;
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
          _goNextPage();
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
  )),
          ],
          
        ),
      ),
    );
  }
}