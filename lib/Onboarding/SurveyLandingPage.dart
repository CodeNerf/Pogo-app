import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/Onboarding/AddressAutocomplete.dart';
import 'package:pogo/Onboarding/Issues.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import '../dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import '../amplifyFunctions.dart';
import '../SignInSignUpPage.dart';
import 'Demographics2.dart';
import 'VoterInfo2.dart';

class SurveyLandingPage extends StatefulWidget {
  //check for survey completion, if completed then create ratings object with database values
  UserDemographics answers = UserDemographics(id: '');
  UserIssueFactorValues ratings = UserIssueFactorValues(userId: '');
  final int pageSelect;
  SurveyLandingPage({Key? key, required this.pageSelect}) : super(key: key);

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
            switch (widget.pageSelect) {
              case 0:
                //route to demographics
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Demographics2(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 0,
                        )));
                break;
              case 1:
                //route to voter info
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoterInfo2(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 0,
                        )));
                break;
              case 2:
              //route to issue 1
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 0,
                        )));
                break;
              case 3:
              //route to issue 2
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 1,
                        )));
                break;
              case 4:
              //route to issue 3
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 2,
                        )));
                break;
              case 5:
              //route to issue 4
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 3,
                        )));
                break;
              case 6:
              //route to issue 5
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 4,
                        )));
                break;
              case 7:
              //route to issue 6
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 5,
                        )));
                break;
              case 8:
              //route to issue 7
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 6,
                        )));
                break;
              case 9:
              //route to issue 8
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 7,
                        )));
                break;
              case 10:
              //route to issue 9
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 8,
                        )));
                break;
              case 11:
              //route to issue 10
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Issues(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 9,
                        )));
                break;
              default:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Demographics2(
                          ratings: widget.ratings,
                          answers: widget.answers,
                          issuesIndex: 0,
                        )));
                break;
            }
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
