import 'package:flutter/material.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'dynamoModels/Ballot.dart';
import 'Home.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';
import 'user.dart';
import 'awsFunctions.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'dynamoModels/UserIssueFactorValues.dart';

class HomeLoadingPage extends StatefulWidget {
  const HomeLoadingPage({Key? key}) : super(key: key);

  @override
  State<HomeLoadingPage> createState() => _HomeLoadingPageState();
}

class _HomeLoadingPageState extends State<HomeLoadingPage> {
  late Ballot userBallot;
  late user currentUser;
  late UserDemographics currentUserDemographics;
  late UserIssueFactorValues currentUserFactors;
  late List<CandidateDemographics> candidateStack;
  late List<CandidateIssueFactorValues> candidateStackFactors;
  @override
  void initState() {
    initializeObjects();
    super.initState();
  }

  void initializeObjects() async {
    userBallot =
        Ballot.empty(); //TODO: initialize userBallot with database ballot
    currentUser = await fetchCurrentUserAttributes();
    currentUserDemographics = await getUserDemographics(currentUser.email);
    // Need to push associated user factors to the database before running this function.
    currentUserFactors = await getUserIssueFactorValues(currentUser.email);
    candidateStack = await getAllCandidateDemographics();
    candidateStackFactors = await getAllCandidateIssueFactorValues();
    setObjectStates(currentUserFactors, candidateStack, currentUserDemographics, userBallot, candidateStackFactors);
  }

  void setObjectStates(UserIssueFactorValues uifv, List<CandidateDemographics> s, UserDemographics ud, Ballot ub, List<CandidateIssueFactorValues> cifv) {
    setState(() {
      candidateStackFactors = cifv;
      currentUserFactors = uifv;
      candidateStack = s;
      currentUserDemographics = ud;
      userBallot = ub;
    });
    goHome();
  }

  void goHome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          currentUserFactors: currentUserFactors,
          candidateStack: candidateStack,
          currentUserDemographics: currentUserDemographics,
          userBallot: userBallot,
          candidateStackFactors: candidateStackFactors,
        ),
      ),
    );
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
