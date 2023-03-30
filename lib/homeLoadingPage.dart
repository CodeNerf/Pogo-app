import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'Home.dart';
import 'LandingPage.dart';
import 'dynamoModels/Ballot.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';
import 'awsFunctions.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'dynamoModels/UserIssueFactorValues.dart';

class HomeLoadingPage extends StatefulWidget {
  final UserDemographics user;
  const HomeLoadingPage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeLoadingPage> createState() => _HomeLoadingPageState();
}

class _HomeLoadingPageState extends State<HomeLoadingPage> {
  late Ballot _userBallot;
  late UserIssueFactorValues _currentUserFactors;
  late List<CandidateDemographics> _candidateStack;
  late List<CandidateIssueFactorValues> _candidateStackFactors;
  @override
  void initState() {
    _initializeObjects();
    super.initState();
  }

  void _initializeObjects() async {
    bool retry = true;
    int retryCount = 0;
    String email = widget.user.userId;
    _userBallot = Ballot.empty();

    while (retry) {
      try {
        await Future.wait([
          getAllCandidateDemographics(),
          getAllCandidateIssueFactorValues(),
          getUserIssueFactorValues(email),
          getUserBallot(email)
        ]).then((List<dynamic> values) {
          _candidateStack = values[0];
          _candidateStackFactors = values[1];
          _currentUserFactors = values[2];
          _userBallot.localCandidateIds = values[3];
        });
        retry = false;
      } catch (e) {
        retryCount++;
        retry = true;
        safePrint(e);
        safePrint("Retrying $retryCount");
      }
    }

    _setObjectStates(_currentUserFactors, _candidateStack, _userBallot,
        _candidateStackFactors);
  }

  void _setObjectStates(
      UserIssueFactorValues uifv,
      List<CandidateDemographics> s,
      Ballot ub,
      List<CandidateIssueFactorValues> cifv) {
    setState(() {
      _candidateStackFactors = cifv;
      _currentUserFactors = uifv;
      _candidateStack = s;
      _userBallot = ub;
    });
    _getLoginStreak();
  }

  void _getLoginStreak() async {
    //TODO: move to homeloadingpage when data is in db
    //this function will be used to determine how many consecutive days the user has logged in
    DateTime lastLoginDate = DateFormat("yyyy-MM-dd").parse(widget.user.lastLogin);
    DateTime now = DateTime.now();
    if(now.year == lastLoginDate.year) {
      if(now.month == lastLoginDate.month) {
        if(now.day == (lastLoginDate.day + 1)) {
          //increment login streak
          widget.user.loginStreak = widget.user.loginStreak + 1;
          if(widget.user.loginStreakRecord < widget.user.loginStreak) {
            //new login streak record
            widget.user.loginStreakRecord = widget.user.loginStreak;
          }
          await putUserDemographics(widget.user);
        }
      }
      else {
        //check new month
      }
    }
    else {
      //check new year
    }
    _goHome();
  }

  void _goHome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          currentUserFactors: _currentUserFactors,
          candidateStack: _candidateStack,
          currentUserDemographics: widget.user,
          userBallot: _userBallot,
          candidateStackFactors: _candidateStackFactors,
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
