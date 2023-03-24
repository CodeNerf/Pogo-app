import 'package:flutter/material.dart';
import 'package:pogo/RegisterPage.dart';

class AppWalkThrough extends StatefulWidget {
  @override
  State<AppWalkThrough> createState() => _AppWalkThroughState();
}

class _AppWalkThroughState extends State<AppWalkThrough> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 4; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

Widget _indicator(bool isActive) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    width: 15.0,
    height: 15.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: isActive ? Colors.black : Colors.black,
        width: 2.0,
      ),
      color: isActive ? Colors.black : Color(0xE5E5E5),
    ),
  );
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFF1F4F8),
    body: SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      // First page of the walkthrough
                      Center(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                  SizedBox(height: 30),
                            Center(
                              child: Image.asset(
                                'assets/appWalkThrough1.png',
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(height: 10.0),

                            Text(
                              "No more scrambling before elections",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                                color: Color(0xFF0E0E0E),
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Take Politics on the Go with an all-in-one hub for your voting info. Research candidates and personalize your ballot. Get started in three easy steps!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Second page of the walkthrough
                       Center(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                  SizedBox(height: 30),
                            Center(
                              child: Image.asset(
                                'assets/appWalkThrough2.png',
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10.0),

                            Text(
                              "Create an account & tell us about yourself",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                                color: Color(0xFF0E0E0E),
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Sign up for FREE to store your voting decisions. Help us create the best personalized experience for you. With your input PoGo will ensure your election research is a breeze.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Third page of the walkthrough
                      Center(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                  SizedBox(height: 30),
                            Center(
                              child: Image.asset(
                                'assets/appWalkThrough3.png',
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            Text(
                              "Take a stance on popular issues",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                                color: Color(0xFF0E0E0E),
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "What topics matter to you? Let us know how much you care. Using your results we will match you with candidates on your ballot that most closely align.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),

                       // Fourth page of the walkthrough
                      Center(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                  SizedBox(height: 30),
                            Center(
                              child: Image.asset(
                                'assets/appWalkThrough4.png',
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Center(
                            child: Text(
                              "Start Swiping!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                                color: Color(0xFF0E0E0E),
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0,
                                height: 1.2,
                              ),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                           RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    style: TextStyle(
      color: Color(0xFF57636C),
      fontSize: 20,
      fontFamily: 'Inter',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 1.6,
    ),
    children: [
      TextSpan(text: 'See your tailored list of candidates in the podium, "'),
      TextSpan(text: 'Swipe Right', style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: '" to save them to your ballot. Take a deep dive into candidate profiles, view your voting info, and bring up your civic score through polls.'),
    ],
  ),
),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          Positioned(
  top: 16.0,
  right: 16.0,
  child: TextButton(
    onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterPage()));
        },
    child: Text(
      'Skip',
      style: TextStyle(
        color: Color(0xFF57636C),
        fontSize: 25,
        fontFamily: 'Inter',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 1.6,
      ),
    ),
  ),
),
        ],
      ),
    ),
  );
}
}