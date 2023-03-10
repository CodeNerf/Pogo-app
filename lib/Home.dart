import 'package:flutter/material.dart';
import 'package:pogo/CandidateProfile.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'dynamoModels/Ballot.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'UserProfile.dart';
import 'VoterGuide.dart';
import 'BallotPage.dart';
import 'Podium.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'user.dart';

class Home extends StatefulWidget {
  final UserDemographics currentUserDemographics;
  final UserIssueFactorValues currentUserFactors;
  final List<CandidateDemographics> candidateStack;
  final Ballot userBallot;
  final List<CandidateIssueFactorValues> candidateStackFactors;
  const Home({Key? key, required this.currentUserFactors, required this.candidateStack, required this.currentUserDemographics, required this.userBallot, required this.candidateStackFactors}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String PogoLogo = 'assets/Pogo_logo_horizontal.png';
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  //TODO: implement user issues object
  //objects
  user currentUser = user.all('','','','','');
  List<CandidateDemographics> ballotStack = [];
  late Ballot userBallot;
  late UserIssueFactorValues currentUserFactors;
  late List<CandidateDemographics> candidateStack;
  late UserDemographics currentUserDemographics;
  late List<Widget> _widgetOptions;
  late List<CandidateIssueFactorValues> candidateStackFactors;
  List<CandidateDemographics> filteredCandidateStack = [];

  updateBallot(CandidateDemographics candidate, List<CandidateDemographics> podiumStack) {
    userBallot.localCandidateIds.add(candidate.candidateId);
    ballotStack.add(candidate);
    setState(() {
      candidateStack = podiumStack;
    });
  }

  removeFromBallot(String candidatePic) {
    CandidateDemographics candidate = ballotStack.firstWhere((element) => element.profileImageURL == candidatePic);
    userBallot.localCandidateIds.remove(candidate.candidateId);
    ballotStack.remove(candidate);
    if(filteredCandidateStack.isNotEmpty) {
      if(candidate.seatType != candidateStack[0].seatType) {
        filteredCandidateStack.add(candidate);
      }
      else {
        candidateStack.add(candidate);
      }
    }
    else {
      candidateStack.add(candidate);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> loadCandidateProfile(String fullName) async {
    List<String> splitName = fullName.split(' ');
    CandidateDemographics searchCandidate = candidateStack.firstWhere((element) => element.firstName == splitName[0] && element.lastName == splitName[1]);
    CandidateIssueFactorValues searchCandidateValues = candidateStackFactors.firstWhere((element) => element.candidateId == searchCandidate.candidateId);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CandidateProfile(candidate: searchCandidate, candidateValues: searchCandidateValues),
      ),
    );
  }

  void filterPodiumCandidates(String category) async {
    if(filteredCandidateStack.isNotEmpty) {
      await unFilterPodiumCandidates();
    }
    int i = 0;
    while(i < candidateStack.length) {
      if(candidateStack[i].seatType != category) {
        filteredCandidateStack.add(candidateStack[i]);
        candidateStack.remove(candidateStack[i]);
      }
      else {
        i++;
      }
    }
    setState(() {
      _selectedIndex = 1;
      candidateStack = candidateStack;
      filteredCandidateStack = filteredCandidateStack;
    });
  }

  Future<void> unFilterPodiumCandidates() async {
    while(filteredCandidateStack.isNotEmpty) {
      candidateStack.add(filteredCandidateStack[0]);
      filteredCandidateStack.remove(filteredCandidateStack[0]);
    }
    setState(() {
      _selectedIndex = 1;
      candidateStack = candidateStack;
      filteredCandidateStack = filteredCandidateStack;
    });
    candidateStack.shuffle();
  }

  @override
  void initState() {
    super.initState();
    candidateStackFactors = widget.candidateStackFactors;
    currentUserFactors = widget.currentUserFactors;
    candidateStack = widget.candidateStack;
    currentUserDemographics = widget.currentUserDemographics;
    userBallot = widget.userBallot;
    setState(() {
      _widgetOptions = <Widget>[
      VoterGuide(currentUserDemographics: currentUserDemographics,),
        Podium(candidateStack: candidateStack, userBallot: userBallot, updateBallot: updateBallot, candidateStackFactors: candidateStackFactors, unFilterPodiumCandidates: unFilterPodiumCandidates, loadCandidateProfile: loadCandidateProfile,),
        BallotPage(userBallot: userBallot, candidateStack: candidateStack, ballotStack: ballotStack, removeFromBallot: removeFromBallot, loadCustomCandidatesInPodium: filterPodiumCandidates,),
        UserProfile(currentUserFactors: currentUserFactors, currentUserDemographics: currentUserDemographics,),
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
              image: AssetImage(PogoLogo),
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
