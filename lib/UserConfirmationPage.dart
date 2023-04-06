import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogo/AppWalkThrough.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'amplifyFunctions.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'dynamoModels/UserIssueFactorValues.dart';

class UserConfirmationPage extends StatefulWidget {
  final String email;
  final String password;
  const UserConfirmationPage(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<UserConfirmationPage> createState() => _UserConfirmationPage();
}

class _UserConfirmationPage extends State<UserConfirmationPage> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  final _codeController = TextEditingController();
  late final String _email = widget.email;
  late final String _password = widget.password;
  String _errorText = '';
  double _errorSizeBoxSize = 0;
  Color _errorTextColor = Colors.green;

  Future _confirm(context) async {
    try {
      if (await confirmUser(_email, _codeController.text)) {
        await signInUser(_email, _password);
        UserIssueFactorValues newValues = UserIssueFactorValues(
            userId: _email,
            climateScore: 0,
            climateWeight: 0,
            drugPolicyScore: 0,
            drugPolicyWeight: 0,
            economyScore: 0,
            economyWeight: 0,
            educationScore: 0,
            educationWeight: 0,
            gunPolicyScore: 0,
            gunPolicyWeight: 0,
            healthcareScore: 0,
            healthcareWeight: 0,
            housingScore: 0,
            housingWeight: 0,
            immigrationScore: 0,
            immigrationWeight: 0,
            policingScore: 0,
            policingWeight: 0,
            reproductiveScore: 0,
            reproductiveWeight: 0);
        await putUserIssueFactorValues(newValues);
        if (await checkLoggedIn()) {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AppWalkThrough()));
        }
      }
      else if (await isUserConfirmed()) {
        if(await checkLoggedIn()) {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AppWalkThrough()));
        }
      } else {
        setState(() {
          _errorText =
              'Account could not be confirmed. Check if the code entered was correct or request for a new code to be sent.';
          _errorSizeBoxSize = 10;
          _errorTextColor = Colors.red;
        });
      }
    } catch (e) {
      safePrint("Error occurred in _confirm: $e");
    }
  }

  Future _resendCode() async {
    try {
      if (await resendConfirmationCode(_email)) {
        setState(() {
          _errorText = 'A new code was sent to your email.';
          _errorSizeBoxSize = 10;
          _errorTextColor = Colors.green;
        });
      } else {
        //this shouldn't happen
        setState(() {
          _errorText = 'Error occurred when requesting for a new code.';
          _errorSizeBoxSize = 10;
          _errorTextColor = Colors.red;
        });
      }
    } catch (e) {
      safePrint("Error occurred in _resendCode: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE1E1E1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.7,
                  child: Image(
                    image: AssetImage(
                      _pogoLogo,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                //account confirmation instructions
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: const Text(
                    'Enter the code that was sent to your email to confirm your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                //ERROR TEXT
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    _errorText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _errorTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //CODE
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Code',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                //submit button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () async {
                      _confirm(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3D433),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                //resend code button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () async {
                      _resendCode();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                        'Request New Code',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
