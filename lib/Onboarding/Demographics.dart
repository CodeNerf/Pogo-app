import 'package:flutter/material.dart';
import 'package:pogo/UserDemographics.dart';
import 'VoterInfo.dart';
import '../UserIssuesFactors.dart';

class Demographics extends StatefulWidget {
  final UserIssuesFactors ratings;
  final UserDemographics answers;
  const Demographics({Key? key, required this.ratings, required this.answers}) : super(key: key);

  @override
  State<Demographics> createState() => _DemographicsState();
}
class _DemographicsState extends State<Demographics> {
 String surveyPogoLogo = 'assets/Pogo_logo_horizontal.png';
  String agesdropdownvalue = '16-25 years old';
    String pogoLogo = 'assets/Pogo_logo_horizontal.png';

  // List of items in our dropdown menu
  var ages = [    
    '16-25 years old',
    '26-35 years old',
    '36-55 years old',
    '56+ years old',
  ];

  late String racesdropdownvalue= 'Black';   
  
  // List of items in our dropdown menu
  var races = [    
    'Black',
    'White',
    'Asian',
    'American Indian/Alaska Native',
    'Native Hawaiian/Pacific Islander',
    'Hispanic/Latino',
  ];

    String gendersdropdownvalue = 'Female';   
  
  // List of items in our dropdown menu
  var genders = [    
    'Female',
    'Male',
    'Non-binary',
    'Gender Non-conforming',
   'Other',
  ];

  

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
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: Image(
                            image: AssetImage(
                              pogoLogo,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               const SizedBox(height: 30),
  Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Choose your age category',
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
                value: agesdropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
                    focusColor: Colors.transparent,
                // Array list of items
                items: ages.map((String ages) {
                  return DropdownMenuItem(
                    value: ages,
                    child: Text(ages),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    agesdropdownvalue = newValue!;
                  });
                },
              ),

 const SizedBox(height: 30),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          'I identify as',
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
                value: racesdropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                  isExpanded: true,
                    focusColor: Colors.transparent,
                // Array list of items
                items: races.map((String races) {
                  return DropdownMenuItem(
                    value: races,
                    child: Text(races),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    racesdropdownvalue = newValue!;
                  });
                },
              ),

               const SizedBox(height: 30),
 Align(
        alignment: Alignment.topLeft,
        child: Text(
          'I identify as',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, ),
        )),   const SizedBox(height: 10),

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
                value: gendersdropdownvalue,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
               isExpanded: true,
                    focusColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                items: genders.map((String genders) {
                  return DropdownMenuItem(
                    value: genders,
                    child: Text(genders),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    gendersdropdownvalue = newValue!;
                  });
                },
              ),

  const SizedBox(height: 30),

              MaterialButton(

                      height: 50,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VoterInfo(ratings: widget.ratings, answers: widget.answers,)));
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
      ),
    );
  }
}