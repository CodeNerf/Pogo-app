import 'package:flutter/material.dart';
import 'package:pogo/LoginPage.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'package:pogo/awsFunctions.dart';
import '../dynamoModels/UserIssueFactorValues.dart';
import '../amplifyFunctions.dart';
import 'Demographics.dart';

class SurveyLandingPage extends StatefulWidget {
  //check for survey completion, if completed then create ratings object with database values
  UserDemographics answers = UserDemographics(
      userId: '',
      phoneNumber: '',
      registrationState: '',
      addressLine1: '',
      pollingLocation: '',
      voterRegistrationStatus: false,
      firstName: '',
      lastName: '',
      dateOfBirth: '',
      zipCode: '',
      profileImageURL: '',
      gender: '',
      racialIdentity: '',
      politicalAffiliation: '');
  UserIssueFactorValues ratings = UserIssueFactorValues(
      userId: '',
      climateScore: 0,
      climateWeight: 0,
      drugPolicyScore: 0,
      drugPolicyWeight: 0,
      economyScore: 0,
      economyWeight: 0,
      educationScore: 0,
      educationWeight: 0,
      gunPolicyScore: 0,
      gunPolicyWeight: 0,
      healthcareScore: 0,
      healthcareWeight: 0,
      housingScore: 0,
      housingWeight: 0,
      immigrationScore: 0,
      immigrationWeight: 0,
      policingScore: 0,
      policingWeight: 0,
      reproductiveScore: 0,
      reproductiveWeight: 0);
  SurveyLandingPage({Key? key}) : super(key: key);

  @override
  State<SurveyLandingPage> createState() => _SurveyLandingPageState();
}

class _SurveyLandingPageState extends State<SurveyLandingPage> {
  late UserIssueFactorValues currentUserFactors;
  late UserDemographics currentAnswers;
  bool _buttonVisible = false;
  @override
  void initState() {
    getUserFactors();
    super.initState();
  }

  void getUserFactors() async {
    // String userid = await fetchCurrentUserEmail();
    var currentUser = await fetchCurrentUserAttributes();
    // Need to push associated user factors to the database before running this function.
    currentUserFactors = await getUserIssueFactorValues(currentUser.email);
    currentAnswers = await getUserDemographics(currentUser.email);
    setState(() {
      widget.ratings = currentUserFactors;
      widget.answers = currentAnswers;
      _buttonVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Personalize your search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(
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
                  Visibility(
                    visible: _buttonVisible,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 70,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Demographics(
                                      ratings: widget.ratings,
                                      answers: widget.answers,
                                    )));
                      },
                      color: const Color.fromARGB(255, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
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
