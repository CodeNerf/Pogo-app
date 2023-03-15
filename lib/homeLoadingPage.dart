import 'package:flutter/material.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'Home.dart';
import 'dynamoModels/Ballot.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';
import 'awsFunctions.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'dynamoModels/UserIssueFactorValues.dart';

class HomeLoadingPage extends StatefulWidget {
  final UserDemographics user;
  HomeLoadingPage({Key? key, required this.user}) : super(key: key);

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
    String email = await fetchCurrentUserEmail();
    _userBallot = Ballot.empty();
    _userBallot.localCandidateIds = await getUserBallot(email);
    _currentUserFactors = await getUserIssueFactorValues(email);
    _candidateStack = await getAllCandidateDemographics();
    _candidateStackFactors = await getAllCandidateIssueFactorValues();
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
