import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'UserProfile.dart';
import 'VoterGuide.dart';
import 'CandidateInfo.dart';
import 'Podium.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'user.dart';

class Home extends StatefulWidget {
  final user currentUser;
  final UserIssueFactorValues currentUserFactors;
  final List<CandidateDemographics> candidateStack;
  const Home({Key? key, required this.currentUser, required this.currentUserFactors, required this.candidateStack}) : super(key: key);

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
  UserIssueFactorValues currentUserFactors = UserIssueFactorValues(userId: '', climateScore: 0, climateWeight: 0, drugPolicyScore: 0, drugPolicyWeight: 0, economyScore: 0, economyWeight: 0, educationScore: 0, educationWeight: 0, gunPolicyScore: 0, gunPolicyWeight: 0, healthcareScore: 0, healthcareWeight: 0, housingScore: 0, housingWeight: 0, immigrationScore: 0, immigrationWeight: 0, policingScore: 0, policingWeight: 0, reproductiveScore: 0, reproductiveWeight: 0);
  List<CandidateDemographics> candidateStack = [];
  late List<Widget> _widgetOptions;

  updateStack(List<CandidateDemographics> stack) {
    setState(() {
      candidateStack = stack;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentUser = widget.currentUser;
    currentUserFactors = widget.currentUserFactors;
    candidateStack = widget.candidateStack;
    setState(() {
      _widgetOptions = <Widget>[VoterGuide(), Podium(candidateStack: candidateStack, updateStack: updateStack,), CandidateInfo(), UserProfile(currentUser: currentUser, currentUserFactors: currentUserFactors,)];
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
              label: 'Candidates',
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
