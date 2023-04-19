import 'package:amplify_core/amplify_core.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pogo/CandidateProfile.dart';
import 'package:pogo/SignInSignUpPage.dart';
import '../awsFunctions.dart';
import '../dynamoModels/Ballot.dart';
import '../UserProfile.dart';
import '../VoterGuide.dart';
import '../BallotPage.dart';
import '../Podium.dart';
import '../dynamoModels/Demographics/CandidateDemographics.dart';
import '../dynamoModels/IssueFactorValues/CandidateIssueFactorValues.dart';
import '../dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import '../dynamoModels/MatchingStatistics.dart';

class GuestHome extends StatefulWidget {
  final UserIssueFactorValues _guestFactors;
  final List<CandidateDemographics> _guestCandidateStack;
  final Ballot _guestBallot;
  final List<CandidateIssueFactorValues> _guestCandidateStackFactors;
  final List<MatchingStatistics> _guestMatchingStatistics;
  const GuestHome(
      {Key? key,
      required UserIssueFactorValues guestFactors,
      required List<CandidateDemographics> guestCandidateStack,
      required Ballot guestBallot,
      required List<CandidateIssueFactorValues> guestCandidateStackFactors,
      required List<MatchingStatistics> guestMatchingStatistics})
      : _guestCandidateStackFactors = guestCandidateStackFactors,
        _guestBallot = guestBallot,
        _guestCandidateStack = guestCandidateStack,
        _guestFactors = guestFactors,
        _guestMatchingStatistics = guestMatchingStatistics,
        super(key: key);

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  int _selectedIndex = 0;
  List<CandidateDemographics> _ballotStack = [];
  late Ballot _userBallot;
  late List<CandidateDemographics> _candidateStack;
  late List<Widget> _widgetOptions;
  late List<CandidateIssueFactorValues> _candidateStackFactors;

  List<CandidateDemographics> _filteredCandidateStack = [];

  _updateBallot(CandidateDemographics candidate,
      List<CandidateDemographics> podiumStack) {
    _userBallot.localCandidateIds.add(candidate.id);
    _ballotStack.add(candidate);
    setState(() {
      _candidateStack = podiumStack;
    });
  }

  _removeFromBallot(String candidatePic) {
    CandidateDemographics candidate = _ballotStack
        .firstWhere((element) => element.profileImageURL == candidatePic);
    _userBallot.localCandidateIds.remove(candidate.id);
    _ballotStack.remove(candidate);
    if (_filteredCandidateStack.isNotEmpty) {
      if (candidate.runningPosition != _candidateStack[0].runningPosition) {
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

  Future<void> _loadCandidateProfileFromPodium(String fullName) async {
    CandidateDemographics searchCandidate = _candidateStack
        .firstWhere((element) => element.candidateName == fullName);
    CandidateIssueFactorValues searchCandidateValues = _candidateStackFactors
        .firstWhere((element) => element.candidateId == searchCandidate.id);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CandidateProfile(
            candidate: searchCandidate,
            candidateValues: searchCandidateValues,
            candidateStackFactors: _candidateStackFactors),
      ),
    );
  }

  Future<void> _loadCandidateProfileFromBallot(String fullName) async {
    CandidateDemographics searchCandidate =
        _ballotStack.firstWhere((element) => element.candidateName == fullName);
    CandidateIssueFactorValues searchCandidateValues = _candidateStackFactors
        .firstWhere((element) => element.candidateId == searchCandidate.id);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CandidateProfile(
            candidate: searchCandidate,
            candidateValues: searchCandidateValues,
            candidateStackFactors: _candidateStackFactors),
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
        if (_candidateStack[i].runningPosition != category) {
          _filteredCandidateStack.add(_candidateStack[i]);
          _candidateStack.remove(_candidateStack[i]);
        } else {
          i++;
        }
      }
      setState(() {
        _widgetOptions[1] = Podium(
          candidateStack: _candidateStack,
          userBallot: _userBallot,
          updateBallot: _updateBallot,
          candidateStackFactors: _candidateStackFactors,
          unFilterPodiumCandidates: _unFilterPodiumCandidates,
          loadCandidateProfile: _loadCandidateProfileFromPodium,
          filter: true,
        );
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
      _widgetOptions[1] = Podium(
        candidateStack: _candidateStack,
        userBallot: _userBallot,
        updateBallot: _updateBallot,
        candidateStackFactors: _candidateStackFactors,
        unFilterPodiumCandidates: _unFilterPodiumCandidates,
        loadCandidateProfile: _loadCandidateProfileFromPodium,
        filter: false,
      );
      _selectedIndex = 1;
      _candidateStack = _candidateStack;
      _filteredCandidateStack = _filteredCandidateStack;
    });
    _candidateStack.shuffle();
  }

  @override
  void initState() {
    super.initState();
    _candidateStackFactors = widget._guestCandidateStackFactors;
    _candidateStack = widget._guestCandidateStack;
    _userBallot = widget._guestBallot;
    if (_userBallot.localCandidateIds.isNotEmpty) {
      for (int i = 0; i < _userBallot.localCandidateIds.length; i++) {
        _ballotStack.add(_candidateStack.firstWhere(
            (element) => element.id == _userBallot.localCandidateIds[i]));
      }
    }
    setState(() {
      _widgetOptions = <Widget>[
        lockedPage('Voter Guide'),
        Podium(
          candidateStack: _candidateStack,
          userBallot: _userBallot,
          updateBallot: _updateBallot,
          candidateStackFactors: _candidateStackFactors,
          unFilterPodiumCandidates: _unFilterPodiumCandidates,
          loadCandidateProfile: _loadCandidateProfileFromPodium,
          filter: false,
        ),
        BallotPage(
          userBallot: _userBallot,
          candidateStack: _candidateStack,
          ballotStack: _ballotStack,
          removeFromBallot: _removeFromBallot,
          loadCustomCandidatesInPodium: _filterPodiumCandidates,
          loadCandidateProfile: _loadCandidateProfileFromBallot,
        ),
        lockedPage('Profile'),
      ];
    });
  }

  Widget lockedPage(String pageName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(
            'You must have a PoGo account to access the $pageName',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        //sign up button
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          //overall container
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFF3D433),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(3, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInSignUpPage(
                        index: 0,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                  child: Center(
                    child: AutoSizeText(
                      'Sign Up',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
