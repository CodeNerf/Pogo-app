import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';

import 'ForgotPasswordPage.dart';
import 'HomeLoadingPage.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'amplifyFunctions.dart';
import 'awsFunctions.dart';

class SignIn extends StatefulWidget {
  final Function(int) switchPage;
  const SignIn({Key? key, required this.switchPage}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailSignInController = TextEditingController();
  final _passwordSignInController = TextEditingController();
  bool _obscure = true;
  Icon _eye = const Icon(Icons.remove_red_eye);
  String _errorText = '';
  double _errorSizeBoxSize = 0;

  Future _signIn(context) async {
    if (await signInUser(
        _emailSignInController.text, _passwordSignInController.text)) {
      safePrint("checking isUserSignedIn()");
      if (await isUserSignedIn()) {
        //check if survey is completed
        UserDemographics user =
            await getUserDemographics(_emailSignInController.text);
        user.lastLogin = DateFormat('yyyy-MM-dd').format(DateTime.now());
        safePrint(user.lastLogin);
        await putUserDemographics(user);
        if (user.surveyCompletion == true) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeLoadingPage(user: user),
            ),
          );
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurveyLandingPage(),
            ),
          );
        }
        //TODO: make account confirmation not necessary for logging in (maybe)
        /* this checks if user is confirmed, not currently possible due to cognito settings
        safePrint("checking isUserConfirmed()");
        //check if user is confirmed
        if(await isUserConfirmed()) {
          safePrint("checking isSurveyCompleted()");
          //check if survey is completed
          if(await isSurveyCompleted()) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLoadingPage(),
              ),
            );
          }
          else {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurveyLandingPage(),
              ),
            );
          }
        }
        else {
          if (await resendConfirmationCode(emailController.text)) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserConfirmationPage(email: emailController.text, password: passwordController.text),
              ),
            );
          }
        }
        */
      } else {
        setState(() {
          _errorText = 'Could not log in.';
        });
      }
    } else {
      setState(() {
        _errorText = 'Could not log in.';
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree.
    _emailSignInController.dispose();
    _passwordSignInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //sign up / sign in
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //inactive sign in button
              const Text(
                "Sign In",
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
              //sign up button
              GestureDetector(
                onTap: () {
                  widget.switchPage(1);
                },
                child: const Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Sign Up",
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
              ),
            ],
          ),
        ),
        //sign in to continue your search
        const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Sign in to continue your search",
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
        ),
        //EMAIL
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _emailSignInController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'example@email.com',
                ),
              ),
            ),
          ),
        ),
        //password
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                obscureText: _obscure,
                controller: _passwordSignInController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_obscure) {
                        setState(() {
                          _obscure = false;
                          _eye = const Icon(Icons.remove_red_eye_outlined,
                              color: Colors.grey);
                        });
                      } else {
                        setState(() {
                          _obscure = true;
                          _eye = const Icon(Icons.remove_red_eye,
                              color: Colors.grey);
                        });
                      }
                    },
                    child: _eye,
                  ),
                ),
              ),
            ),
          ),
        ),

        //forgot password text button
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () async {
                widget.switchPage(2);
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),

        //sign in button
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 40, 25, 20),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF3D433),
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
                onTap: () {
                  _signIn(context);
                },
                child: const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0E0E0E),
                      fontSize: 30,
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
}
