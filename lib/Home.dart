import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Voter Guide',
      style: optionStyle,
    ),
    Text(
      'Match',
      style: optionStyle,
    ),
    Text(
      'Candidates',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage('assets/briefcase.png'),
                color: Colors.black,
            ),
            label: 'Voter Guide',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/speech.png'),
              color: Colors.black,
            ),
            label: 'Match',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/vote.png'),
              color: Colors.black,
            ),
            label: 'Candidates',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/user.png'),
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF3D433),
        onTap: _onItemTapped,
      ),
    );
  }
}
