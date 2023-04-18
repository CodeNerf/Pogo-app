import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
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
  bool _buttonVisible = false;

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
            _buttonVisible = true;
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
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "PERSONALIZE\nYOUR\nSEARCH",
                      style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 10.0,
                            offset: Offset(0, 2),
                            color: Colors.black38,
                          ),
                        ],
                        fontWeight: FontWeight.w900,
                        fontSize: 34,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 2,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(
                      "assets/surveyLanding.png",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Visibility(
                  visible: _buttonVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3D433),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Demographics2(
                                        ratings: widget.ratings,
                                        answers: widget.answers,
                                        issuesIndex: 0,
                                      )));
                        },
                        child: const Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'PoGo',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0E0E0E),
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
