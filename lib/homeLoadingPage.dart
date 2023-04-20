import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/dynamoModels/Demographics/CandidateDemographics.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import 'package:pogo/dynamoModels/IssueFactorValues/CandidateIssueFactorValues.dart';
import 'package:pogo/dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import 'package:pogo/dynamoModels/MatchingStatistics.dart';
import 'Home.dart';
import 'LandingPage.dart';
import 'dynamoModels/Ballot.dart';
import 'awsFunctions.dart';

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
  late List<MatchingStatistics> _candidateStackStatistics;
  @override
  void initState() {
    _initializeObjects();
    super.initState();
  }

  void _initializeObjects() async {
    bool retry = true;
    int retryCount = 0;
    String email = widget.user.id;
    _userBallot = Ballot.empty();

    while (retry) {
      try {
        await Future.wait([
          getUserCandidatesWithDeferred(email),
          getUserCandidateStackIssueFactorValues(email),
          getUserIssueFactorValues(email),
          getUserBallot(email),
          getUserCandidateStackStatistics(email),
        ]).then((List<dynamic> values) {
          _candidateStack = values[0];
          _candidateStackFactors = values[1];
          _currentUserFactors = values[2];
          _userBallot.localCandidateIds = values[3];
          _candidateStackStatistics = values[4];
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
        _candidateStackFactors, _candidateStackStatistics);
  }

  void _setObjectStates(
      UserIssueFactorValues uifv,
      List<CandidateDemographics> s,
      Ballot ub,
      List<CandidateIssueFactorValues> cifv,
      List<MatchingStatistics> ms) {
    setState(() {
      _candidateStackFactors = cifv;
      _currentUserFactors = uifv;
      _candidateStack = s;
      _userBallot = ub;
      _candidateStackStatistics = ms;
    });
    _getLoginStreak();
  }

  void _getLoginStreak() async {
    //this function will be used to determine how many consecutive days the user has logged in
    DateTime lastLoginDate =
        DateFormat("yyyy-MM-dd").parse(widget.user.lastLogin);
    DateTime now = DateTime.now();
    widget.user.lastLogin = DateFormat('yyyy-MM-dd').format(DateTime.now());
    lastLoginDate =
        DateTime(lastLoginDate.year, lastLoginDate.month, lastLoginDate.day);
    now = DateTime(now.year, now.month, now.day);
    int daysBetween = (now.difference(lastLoginDate).inHours / 24).round();
    if (daysBetween == 1) {
      //increment loginStreak
      widget.user.loginStreak = widget.user.loginStreak + 1;
    }
    else if (daysBetween > 1) {
      //reset login streak
      widget.user.loginStreak = 1;
    } else {
      //login same day as last login, do nothing
    }
    //determine if new record
    if (widget.user.loginStreak > widget.user.loginStreakRecord) {
      widget.user.loginStreakRecord = widget.user.loginStreak;
    }
    await putUserDemographics(widget.user);
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
          candidateStackStatistics: _candidateStackStatistics,
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
