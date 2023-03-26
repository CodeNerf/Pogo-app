import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/CandidateProfile.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'awsFunctions.dart';
import 'dynamoModels/Ballot.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'UserProfile.dart';
import 'VoterGuide.dart';
import 'BallotPage.dart';
import 'Podium.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';
import 'dynamoModels/UserIssueFactorValues.dart';

class Home extends StatefulWidget {
  final UserDemographics _currentUserDemographics;
  final UserIssueFactorValues _currentUserFactors;
  final List<CandidateDemographics> _candidateStack;
  final Ballot _userBallot;
  final List<CandidateIssueFactorValues> _candidateStackFactors;
  const Home(
      {Key? key,
      required UserIssueFactorValues currentUserFactors,
      required List<CandidateDemographics> candidateStack,
      required UserDemographics currentUserDemographics,
      required Ballot userBallot,
      required List<CandidateIssueFactorValues> candidateStackFactors})
      : _candidateStackFactors = candidateStackFactors,
        _userBallot = userBallot,
        _candidateStack = candidateStack,
        _currentUserFactors = currentUserFactors,
        _currentUserDemographics = currentUserDemographics,
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  int _selectedIndex = 0;
  List<CandidateDemographics> _ballotStack = [];
  late Ballot _userBallot;
  late UserIssueFactorValues _currentUserFactors;
  late List<CandidateDemographics> _candidateStack;
  late UserDemographics _currentUserDemographics;
  late List<Widget> _widgetOptions;
  late List<CandidateIssueFactorValues> _candidateStackFactors;
  List<CandidateDemographics> _filteredCandidateStack = [];

  _updateBallot(CandidateDemographics candidate,
      List<CandidateDemographics> podiumStack) {
    _userBallot.localCandidateIds.add(candidate.candidateId);
    _ballotStack.add(candidate);
    putUserBallot(
        _currentUserDemographics.userId,
        _userBallot.localCandidateIds,
        _userBallot.stateCandidateIds,
        _userBallot.federalCandidateIds);
    setState(() {
      _candidateStack = podiumStack;
    });
  }

  _removeFromBallot(String candidatePic) {
    CandidateDemographics candidate = _ballotStack
        .firstWhere((element) => element.profileImageURL == candidatePic);
    _userBallot.localCandidateIds.remove(candidate.candidateId);
    _ballotStack.remove(candidate);
    putUserBallot(
        _currentUserDemographics.userId,
        _userBallot.localCandidateIds,
        _userBallot.stateCandidateIds,
        _userBallot.federalCandidateIds);
    if (_filteredCandidateStack.isNotEmpty) {
      if (candidate.seatType != _candidateStack[0].seatType) {
        _filteredCandidateStack.add(candidate);
      } else {
        _candidateStack.add(candidate);
      }
    } else {
      _candidateStack.add(candidate);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _loadCandidateProfile(String fullName) async {
    List<String> splitName = fullName.split(' ');
    CandidateDemographics searchCandidate = _candidateStack.firstWhere(
        (element) =>
            element.firstName == splitName[0] &&
            element.lastName == splitName[1]);
    CandidateIssueFactorValues searchCandidateValues =
        _candidateStackFactors.firstWhere(
            (element) => element.candidateId == searchCandidate.candidateId);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CandidateProfile(
            candidate: searchCandidate, candidateValues: searchCandidateValues),
      ),
    );
  }

  void _filterPodiumCandidates(String category) async {
    try {
      if (_filteredCandidateStack.isNotEmpty) {
        await _unFilterPodiumCandidates();
      }
      int i = 0;
      while (i < _candidateStack.length) {
        if (_candidateStack[i].seatType != category) {
          _filteredCandidateStack.add(_candidateStack[i]);
          _candidateStack.remove(_candidateStack[i]);
        } else {
          i++;
        }
      }
      setState(() {
        _selectedIndex = 1;
        _candidateStack = _candidateStack;
        _filteredCandidateStack = _filteredCandidateStack;
      });
    } catch (e) {
      safePrint("An error occurred in _filterPodiumCandidates() $e");
    }
  }

  Future<void> _unFilterPodiumCandidates() async {
    while (_filteredCandidateStack.isNotEmpty) {
      _candidateStack.add(_filteredCandidateStack[0]);
      _filteredCandidateStack.remove(_filteredCandidateStack[0]);
    }
    setState(() {
      _selectedIndex = 1;
      _candidateStack = _candidateStack;
      _filteredCandidateStack = _filteredCandidateStack;
    });
    _candidateStack.shuffle();
  }

  @override
  void initState() {
    super.initState();
    _candidateStackFactors = widget._candidateStackFactors;
    _currentUserFactors = widget._currentUserFactors;
    _candidateStack = widget._candidateStack;
    _currentUserDemographics = widget._currentUserDemographics;
    _userBallot = widget._userBallot;
    if (_userBallot.localCandidateIds.isNotEmpty) {
      for (int i = 0; i < _userBallot.localCandidateIds.length; i++) {
        _ballotStack.add(_candidateStack.firstWhere((element) =>
            element.candidateId == _userBallot.localCandidateIds[i]));
      }
    }
    setState(() {
      _widgetOptions = <Widget>[
        VoterGuide(
  currentUserDemographics: _currentUserDemographics, // provide required argument
  user: _currentUserDemographics,
),
        Podium(
          candidateStack: _candidateStack,
          userBallot: _userBallot,
          updateBallot: _updateBallot,
          candidateStackFactors: _candidateStackFactors,
          unFilterPodiumCandidates: _unFilterPodiumCandidates,
          loadCandidateProfile: _loadCandidateProfile,
        ),
        BallotPage(
          userBallot: _userBallot,
          candidateStack: _candidateStack,
          ballotStack: _ballotStack,
          removeFromBallot: _removeFromBallot,
          loadCustomCandidatesInPodium: _filterPodiumCandidates,
        ),
        UserProfile(
          currentUserFactors: _currentUserFactors,
          currentUserDemographics: _currentUserDemographics,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFE5E5E5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(_pogoLogo),
              width: 150,
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 0,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[650],
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/briefcase.png'),
              ),
              label: 'Voter Guide',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/speech.png'),
              ),
              label: 'Podium',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/vote.png'),
              ),
              label: 'Ballot',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/user.png'),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
