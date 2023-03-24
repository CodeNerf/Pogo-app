import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        transformAlignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Are you registered to vote?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
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
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'What is your political party?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
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
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'How do you vote?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
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

                 const SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Do you live in your registered state?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
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
  const SizedBox(height: 30),

            MaterialButton(

                    height: 50,
                    onPressed: () {
                      _goNextPage();
                    },
                 color: Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
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
    );
  }
}