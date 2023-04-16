import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'AppWalkThrough.dart';
import 'SignInSignUpPage.dart';
import 'amplifyFunctions.dart';
import 'Onboarding/AddressAutocomplete.dart';
import 'dart:math';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 599,
                    height: 212,
                    margin: EdgeInsets.only(left: 5, top: 30, right: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Pogo_logo_horizontal.png"),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Politics on the Go",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Color(0xFF0E0E0E),
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Informing the next generation of voters ",
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
                ],
              ),
              SizedBox(height: 40),
              Column(
                // ignore: sort_child_properties_last
                children: <Widget>[
                  // the login button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInSignUpPage(
                                      index: 0,
                                    )));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          //height: 42,
                          color: Color(0xFF5F5D5D),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF3D433),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignInSignUpPage(index: 1)));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          //height: 42,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment:
                    MainAxisAlignment.center, // center the widgets vertically
                crossAxisAlignment: CrossAxisAlignment
                    .center, // center the widgets horizontally
              )
            ],
          ),
        ),
      ),
    );
  }
}
