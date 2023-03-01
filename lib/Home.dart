import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'UserIssuesFactors.dart';
import 'UserProfile.dart';
import 'VoterGuide.dart';
import 'CandidateInfo.dart';
import 'Podium.dart';
import 'user.dart';

class Home extends StatefulWidget {
  final user currentUser;
  final UserIssuesFactors currentUserFactors;
  const Home({Key? key, required this.currentUser, required this.currentUserFactors}) : super(key: key);

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
  UserIssuesFactors currentUserFactors = UserIssuesFactors(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

  late List<Widget> _widgetOptions;

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
    setState(() {
      _widgetOptions = <Widget>[VoterGuide(), CandidateUserMatching(), CandidateInfo(), UserProfile(currentUser: currentUser, currentUserFactors: currentUserFactors,)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE1E1E1),
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
              label: 'Match',
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
