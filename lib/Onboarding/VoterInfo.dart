import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pogo/Onboarding/Issues/GunPolicy.dart';
import '../LandingPage.dart';
import '../LoginPage.dart';
import '../RegisterPage.dart';

class VoterInfo extends StatefulWidget {
  const VoterInfo({Key? key}) : super(key: key);

  @override
  State<VoterInfo> createState() => _VoterInfoState();
}
class _VoterInfoState extends State<VoterInfo> {
 String surveyPogoLogo = 'assets/Pogo_logo_horizontal.png';
  String votedropdownvalue = 'Yes';   
  
  // List of items in our dropdown menu
  var vote = [    
    'Yes',
    'No',
    'Not sure',
    
  ];
    String partiesdropdownvalue = 'Republican';   
  
  // List of items in our dropdown menu
  var parties = [    
    'Republican',
    'Democrat',
    'Liberterian',
    'Green',
    'Independent',
  ];
  String votePartydropdownvalue = 'Republican';   
  
  // List of items in our dropdown menu
  var voteParty = [    
    'Republican',
    'Democrat',
    'Liberterian',
    'Green',
    'Independent',
  ];


  String statedropdownvalue = 'Yes';   
  
  // List of items in our dropdown menu
  var state = [    
    'Yes',
    'No',
    
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Transform.scale(
                  scale: 0.30,
                  child: Image(
                    image: AssetImage(
                      surveyPogoLogo,
                    ),
                  ),
                ),
         centerTitle: true,
                backgroundColor: Colors.grey[300]
      ),
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, ),
      )),
   const SizedBox(height: 10),

            DropdownButtonFormField(
                decoration: InputDecoration(
    enabledBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    focusedBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    filled: true,
    fillColor: Colors.grey[300],

  ),  
              // Initial Value
              value: votedropdownvalue,
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                isExpanded: true,
                  focusColor: Colors.transparent,
              // Array list of items
              items: vote.map((String vote) {
                return DropdownMenuItem(
                  value: vote,
                  child: Text(vote),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, ),
      )),
   const SizedBox(height: 10),

  DropdownButtonFormField(
   
                decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder( //<-- SEE HERE
                borderSide: BorderSide(color: Colors.black, width: 2),
                                    ),
                   focusedBorder: const OutlineInputBorder( //<-- SEE HERE
                  borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    filled: true,
    fillColor: Colors.grey[300],

  ),
  
              // Initial Value
              value: partiesdropdownvalue,
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                isExpanded: true,
                  focusColor: Colors.transparent,
              // Array list of items
              items: parties.map((String parties) {
                return DropdownMenuItem(
                  value: parties,
                  child: Text(parties),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, ),
      )),
    const SizedBox(height: 10),
            DropdownButtonFormField(
                decoration: InputDecoration(
    enabledBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    focusedBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    filled: true,
    fillColor: Colors.grey[300],

  ),
              value: votePartydropdownvalue,
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                isExpanded: true,
                  focusColor: Colors.transparent,
              // Array list of items
              items: voteParty.map((String voteParty) {
                return DropdownMenuItem(
                  value: voteParty,
                  child: Text(voteParty),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, ),
      )),
  const SizedBox(height: 10),

DropdownButtonFormField(
                decoration: InputDecoration(
    enabledBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    focusedBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    filled: true,
    fillColor: Colors.grey[300],

  ),
              // Initial Value
              value: statedropdownvalue,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                isExpanded: true,
                  focusColor: Colors.transparent,
              // Array list of items
              items: state.map((String state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GunPolicy()));
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