import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/CandidateProfile.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import 'package:pogo/HamburgerMenuFunctions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'awsFunctions.dart';
import 'dynamoModels/Ballot.dart';
import 'dynamoModels/Demographics/CandidateDemographics.dart';
import 'UserProfile.dart';
import 'VoterGuide.dart';
import 'BallotPage.dart';
import 'Podium.dart';
import 'dynamoModels/IssueFactorValues/CandidateIssueFactorValues.dart';
import 'dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import 'dynamoModels/MatchingStatistics.dart';

class Home extends StatefulWidget {
  final UserDemographics _currentUserDemographics;
  final UserIssueFactorValues _currentUserFactors;
  final List<CandidateDemographics> _candidateStack;
  final Ballot _userBallot;
  final List<CandidateIssueFactorValues> _candidateStackFactors;
  final List<MatchingStatistics> _candidateStackStatistics;
  const Home(
      {Key? key,
      required UserIssueFactorValues currentUserFactors,
      required List<CandidateDemographics> candidateStack,
      required UserDemographics currentUserDemographics,
      required Ballot userBallot,
      required List<CandidateIssueFactorValues> candidateStackFactors,
      required List<MatchingStatistics> candidateStackStatistics})
      : _candidateStackFactors = candidateStackFactors,
        _userBallot = userBallot,
        _candidateStack = candidateStack,
        _currentUserFactors = currentUserFactors,
        _currentUserDemographics = currentUserDemographics,
        _candidateStackStatistics = candidateStackStatistics,
        super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String stateInitial = "MI";

  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  int _selectedIndex = 0;
  List<CandidateDemographics> _ballotStack = [];
  late Ballot _userBallot;
  late UserIssueFactorValues _currentUserFactors;
  late List<CandidateDemographics> _candidateStack;
  late UserDemographics _currentUserDemographics;
  late List<Widget> _widgetOptions;
  late List<CandidateIssueFactorValues> _candidateStackFactors;
  late List<MatchingStatistics> _candidateStackStatistics;
  List<CandidateDemographics> _filteredCandidateStack = [];
  bool _filtering = false;

  _updateBallot(CandidateDemographics candidate,
      List<CandidateDemographics> podiumStack) {
    _userBallot.localCandidateIds.add(candidate.id);
    _ballotStack.add(candidate);
    putUserBallot(_currentUserDemographics.id, _userBallot.localCandidateIds,
        _userBallot.stateCandidateIds, _userBallot.federalCandidateIds);
    setState(() {
      _candidateStack = podiumStack;
    });
  }

  _removeFromBallot(String candidatePic) {
    CandidateDemographics candidate = _ballotStack
        .firstWhere((element) => element.profileImageURL == candidatePic);
    _userBallot.localCandidateIds.remove(candidate.id);
    _ballotStack.remove(candidate);
    putUserBallot(_currentUserDemographics.id, _userBallot.localCandidateIds,
        _userBallot.stateCandidateIds, _userBallot.federalCandidateIds);
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

  Future<void> _loadCandidateProfile(String fullName) async {
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
              candidateStackFactors: _candidateStackFactors)),
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
          candidateStackStatistics: _candidateStackStatistics,
          candidateStack: _candidateStack,
          userBallot: _userBallot,
          updateBallot: _updateBallot,
          candidateStackFactors: _candidateStackFactors,
          unFilterPodiumCandidates: _unFilterPodiumCandidates,
          loadCandidateProfile: _loadCandidateProfile,
          filter: true,
        );
        _selectedIndex = 1;
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
        candidateStackStatistics: _candidateStackStatistics,
        userBallot: _userBallot,
        updateBallot: _updateBallot,
        candidateStackFactors: _candidateStackFactors,
        unFilterPodiumCandidates: _unFilterPodiumCandidates,
        loadCandidateProfile: _loadCandidateProfile,
        filter: false,
      );
      _selectedIndex = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _candidateStackFactors = widget._candidateStackFactors;
    _currentUserFactors = widget._currentUserFactors;
    _candidateStack = widget._candidateStack;
    _currentUserDemographics = widget._currentUserDemographics;
    _userBallot = widget._userBallot;
    _candidateStackStatistics = widget._candidateStackStatistics;
    if (_userBallot.localCandidateIds.isNotEmpty) {
      for (int i = 0; i < _userBallot.localCandidateIds.length; i++) {
        _ballotStack.add(_candidateStack.firstWhere(
            (element) => element.id == _userBallot.localCandidateIds[i]));
      }
    }
    setState(() {
      _widgetOptions = <Widget>[
        VoterGuide(
          // provide required argument
          user: _currentUserDemographics,
        ),
        Podium(
          candidateStack: _candidateStack,
          candidateStackStatistics: _candidateStackStatistics,
          userBallot: _userBallot,
          updateBallot: _updateBallot,
          candidateStackFactors: _candidateStackFactors,
          unFilterPodiumCandidates: _unFilterPodiumCandidates,
          loadCandidateProfile: _loadCandidateProfile,
          filter: _filtering,
        ),
        BallotPage(
          userBallot: _userBallot,
          candidateStack: _candidateStack,
          ballotStack: _ballotStack,
          removeFromBallot: _removeFromBallot,
          loadCustomCandidatesInPodium: _filterPodiumCandidates,
          loadCandidateProfile: _loadCandidateProfile,
        ),
        UserProfile(
          currentUserFactors: _currentUserFactors,
          currentUserDemographics: _currentUserDemographics,
          currentUserBallotCandidates: _ballotStack,
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
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 40,
          ),
          title: Container(
            padding: const EdgeInsets.only(left: 50),
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(_pogoLogo),
              width: 150,
            ),
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            children: <Widget>[
              SizedBox(
                height: 100,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(right: 300),
                  leading: const Icon(
                    Icons.clear,
                    size: 32,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () =>
                        HamburgerMenuFunctions.registerToVote(stateInitial),
                    child: const Text(
                      'Register to Vote',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        height: 1.24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFDBE2E7),
                    thickness: 2,
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () => HamburgerMenuFunctions.requestAbsenteeBallot(
                        stateInitial),
                    child: const Text(
                      'Request an Absentee Ballot',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        height: 1.24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFDBE2E7),
                    thickness: 2,
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () =>
                        HamburgerMenuFunctions.voteByMail(stateInitial),
                    child: const Text(
                      'Vote by mail',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        height: 1.24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFDBE2E7),
                    thickness: 2,
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () =>
                        HamburgerMenuFunctions.updateRegistration(stateInitial),
                    child: const Text(
                      'Update registration',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        height: 1.24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFDBE2E7),
                    thickness: 2,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Data & Privacy policy',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      height: 1.24,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFDBE2E7),
                    thickness: 2,
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Accessible voting',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      height: 1.24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Add other menu items here
            ],
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
