import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/Onboarding/AddressAutocomplete.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import '../dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import '../amplifyFunctions.dart';
import 'Demographics.dart';
import '../SignInSignUpPage.dart';
import 'Demographics2.dart';

class SurveyLandingPage extends StatefulWidget {
  //check for survey completion, if completed then create ratings object with database values
  UserDemographics answers = UserDemographics(id: '');
  UserIssueFactorValues ratings = UserIssueFactorValues(userId: '');
  SurveyLandingPage({Key? key}) : super(key: key);

  @override
  State<SurveyLandingPage> createState() => _SurveyLandingPageState();
}

class _SurveyLandingPageState extends State<SurveyLandingPage> {
  @override
  void initState() {
    _getUserFactors();
    super.initState();
  }

  void _getUserFactors() async {
    bool retry = true;
    int retryCount = 0;
    String email = '';
    try {
      email = await fetchCurrentUserEmail();
    } catch (e) {
      safePrint("Couldn't fetch user email.");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SignInSignUpPage(index: 0)));
    }
    // Need to push associated user factors to the database before running this function.
    while (retry) {
      try {
        await Future.wait(
                [getUserIssueFactorValues(email), getUserDemographics(email)])
            .then((List<dynamic> values) {
          setState(() {
            widget.ratings = values[0];
            widget.answers = values[1];
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Demographics2(
                      ratings: widget.ratings,
                      answers: widget.answers,
                      issuesIndex: 0,
                    )));
          });
        });
        retry = false;
      } catch (e) {
        retry = true;
        retryCount++;
        safePrint(e);
        safePrint(
            "SurveyLandingPage: Failed to fetch user factors. Retrying... $retryCount");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Scaffold(
        backgroundColor: Color(0xFFE1E1E1),
        body: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: FittedBox(
              fit: BoxFit.fill,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFE1E1E1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
