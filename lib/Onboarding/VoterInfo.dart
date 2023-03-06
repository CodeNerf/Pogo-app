import 'package:flutter/material.dart';
import 'package:pogo/Onboarding/Issues/GunPolicy.dart';
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
  late UserDemographics answers;
 String votedropdownvalue = '';
  List<String> vote = ['Yes', 'No', 'Not sure'];

  String partiesdropdownvalue = '';
  List<String> parties = ['Republican', 'Democrat', 'Libertarian', 'Green', 'Independent'];

  String votePartydropdownvalue = '';
  List<String> voteParty = ['Republican', 'Democrat', 'Libertarian', 'Green', 'Independent'];

  String statedropdownvalue = '';
  List<String> state = ['Yes', 'No'];

 @override
 void initState() {
   super.initState();
   setState(() {
     answers = widget.answers;
   });
 }

 void goNextPage() {
   if(votedropdownvalue == 'Yes') {
     widget.answers.voterRegistrationStatus = true;
   }
   widget.answers.politicalAffiliation = partiesdropdownvalue;
   //TODO: add party user votes for String to db in case this is needed in matching algorithm
   //TODO: add user lives in registered state bool to db in case this value is needed in future
   Navigator.push(context, MaterialPageRoute(builder: (context) => GunPolicy(ratings: widget.ratings, answers: widget.answers,)));
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
              value: votedropdownvalue.isNotEmpty ? votedropdownvalue : null,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              focusColor: Colors.transparent,
              items: vote.map((String vote) {
                return DropdownMenuItem(
                  value: vote,
                  child: Text(vote),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  votedropdownvalue = newValue!;
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
              value: partiesdropdownvalue.isNotEmpty ? partiesdropdownvalue : null,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              focusColor: Colors.transparent,
              items: parties.map((String parties) {
                return DropdownMenuItem(
                  value: parties,
                  child: Text(parties),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  partiesdropdownvalue = newValue!;
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
              value: votePartydropdownvalue.isNotEmpty ? votePartydropdownvalue : null,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              focusColor: Colors.transparent,
              items: voteParty.map((String voteParty) {
                return DropdownMenuItem(
                  value: voteParty,
                  child: Text(voteParty),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  votePartydropdownvalue = newValue!;
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
              value: statedropdownvalue.isNotEmpty ? statedropdownvalue : null,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              focusColor: Colors.transparent,
              items: state.map((String state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  statedropdownvalue = newValue!;
                });
              },
            ),
  const SizedBox(height: 30),

            MaterialButton(

                    height: 50,
                    onPressed: () {
                      goNextPage();
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