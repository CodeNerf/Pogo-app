import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogo/dynamoModels/MatchingStatistics.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import '../dynamoModels/Ballot.dart';
import '../dynamoModels/CandidateIssueFactorValues.dart';
import '../awsFunctions.dart';
import '../dynamoModels/CandidateDemographics.dart';
import '../dynamoModels/UserIssueFactorValues.dart';
import 'GuestHome.dart';

class GuestLoadingPage extends StatefulWidget {
  final UserIssueFactorValues ratings;
  const GuestLoadingPage({Key? key, required this.ratings}) : super(key: key);

  @override
  State<GuestLoadingPage> createState() => _GuestLoadingPageState();
}

class _GuestLoadingPageState extends State<GuestLoadingPage> {
  late Ballot _guestBallot;
  late UserIssueFactorValues _guestFactors;
  late List<CandidateDemographics> _candidateStack;
  late List<CandidateIssueFactorValues> _candidateStackFactors;
  late List<MatchingStatistics> _matchingStatisticsList;
  @override
  void initState() {
    _initializeObjects();
    super.initState();
  }

  void _initializeObjects() async {
    bool retry = true;
    int retryCount = 0;
    _guestBallot = Ballot.empty();
    _guestFactors = widget.ratings;
    while (retry) {
      try {
        var lists = await matchCandidatesToUserTest(widget.ratings);
        _candidateStack = lists[0];
        _candidateStackFactors = lists[1];
        _matchingStatisticsList = lists[2];
        retry = false;
      } catch (e) {
        retryCount++;
        retry = true;
        safePrint(e);
        safePrint("Retrying $retryCount");
      }
    }

    _setObjectStates(_guestFactors, _candidateStack, _guestBallot,
        _candidateStackFactors, _matchingStatisticsList);
  }

  void _setObjectStates(
      UserIssueFactorValues uifv,
      List<CandidateDemographics> s,
      Ballot ub,
      List<CandidateIssueFactorValues> cifv,
      List<MatchingStatistics> ms) {
    setState(() {
      _candidateStackFactors = cifv;
      _guestFactors = uifv;
      _candidateStack = s;
      _guestBallot = ub;
      _matchingStatisticsList = ms;
    });
    _goHomeGuest();
  }

  void _goHomeGuest() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuestHome(
          guestFactors: _guestFactors,
          guestCandidateStack: _candidateStack,
          guestBallot: _guestBallot,
          guestCandidateStackFactors: _candidateStackFactors,
          guestMatchingStatistics: _matchingStatisticsList,
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
