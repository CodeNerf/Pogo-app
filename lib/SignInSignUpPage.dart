import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pogo/EnterNewPasswordPage.dart';
import 'package:pogo/UserConfirmationPage.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:validators/validators.dart';
import 'ForgotPasswordPage.dart';
import 'HomeLoadingPage.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'SignInWidget.dart';
import 'SignUpWidget.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/Demographics/UserDemographics.dart';
//import 'SignUpAddress.dart';
import 'package:intl/intl.dart';

import 'guestFlow/GuestIssues.dart';

class SignInSignUpPage extends StatefulWidget {
  final int index;
  const SignInSignUpPage({Key? key, required this.index}) : super(key: key);

  @override
  State<SignInSignUpPage> createState() => _SignInSignUpPageState();
}

class _SignInSignUpPageState extends State<SignInSignUpPage> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  late List<Widget> _widgetOptions;
  int _selectedIndex = 0;
  String _email = "";
  void _switchSection(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToResetPassword(String e) async {
    setState(() {
      _email = e;
      _selectedIndex = 3;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _widgetOptions = <Widget>[
        SignIn(
          switchPage: _switchSection,
        ),
        SignUp(
          switchPage: _switchSection,
        ),
        ForgotPasswordPage(
          resetPasswordPage: _goToResetPassword,
        ),
        EnterNewPasswordPage(email: _email, switchPage: _switchSection),
      ];
    });
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFFF1F4F8),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            centerTitle: true,
            title: Image(
              image: AssetImage(_pogoLogo),
              width: 150,
            ),
          ),
          body: SingleChildScrollView(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          persistentFooterButtons: [
            Column(
              children: [
                //continue as guest button
                Padding(
                  padding: const EdgeInsets.fromLTRB(65, 0, 65, 10),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9b9c98),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GuestIssues(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'Continue as Guest',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0E0E0E),
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //TODO: commenting out social media buttons as implementing functionality for those is not currently possible
                /*
                //or continue with
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: Text(
                      "Or Continue with:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF57636C),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD9D9D9),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/google.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {
                          // Add icon onTap functionality
                        },
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD9D9D9),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/facebook.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {
                          // Add icon onTap functionality
                        },
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD9D9D9),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/twitter.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {
                          // Add icon onTap functionality
                        },
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD9D9D9),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/instagram.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {
                          // Add icon onTap functionality
                        },
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD9D9D9),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/tiktok.png',
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () {
                          // Add icon onTap functionality
                        },
                      ),
                    ),
                  ],
                ),
                 */
              ],
            ),
          ],
          persistentFooterAlignment: AlignmentDirectional.center,
        ),
      ),
    );
  }
}
