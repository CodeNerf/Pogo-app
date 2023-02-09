import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pogo/Onboarding/Demographics.dart';
import 'package:pogo/RegisterPage.dart';

class SurveyLandingPage extends StatefulWidget {
  const SurveyLandingPage({Key? key}) : super(key: key);

  @override
  State<SurveyLandingPage> createState() => _SurveyLandingPageState();
}
class _SurveyLandingPageState extends State<SurveyLandingPage> {
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        
       child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          
          child: Column(

              mainAxisAlignment : MainAxisAlignment.center,
            children: 
            
            <Widget>[

    
              Column(
                
                children: <Widget>[
              

                  Text(
                    "Personalize your search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,

                    ),
                    
                  ),
SizedBox(
                    height: 140,
                ),
                  Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/surveryLanding.png",
               
              )),
                   Container(
                height: MediaQuery.of(context).size.height / 5,
          
                    
              ),
             
              
                
                ],
              ),
              
              Column(
                children: <Widget>[
                  // the login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 70,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Demographics()));
                    },
                 color: Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                ],
              )
            ],
          ),
        ),
      ),
      );
  
  }
}