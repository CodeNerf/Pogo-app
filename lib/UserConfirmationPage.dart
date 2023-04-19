import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogo/AppWalkThrough.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import 'amplifyFunctions.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';

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
        UserIssueFactorValues newValues = UserIssueFactorValues(userId: _email);
        await putUserIssueFactorValues(newValues);
        if (await checkLoggedIn()) {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AppWalkThrough()));
        }
      } else if (await isUserConfirmed()) {
        if (await checkLoggedIn()) {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Image(
            image: AssetImage(_pogoLogo),
            width: 150,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //guy holding sign
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image(
                        image: AssetImage('assets/accountConfirmation.png'),
                      )),
                ),

                //forgot password text
                const Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Text(
                    'Confirm Your Account',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Color(0xFF0E0E0E),
                    ),
                  ),
                ),

                //forgot password instructions text
                const Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Text(
                    r"""Enter the code sent to your email to confirm your account!""",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Color(0xFF57636C),
                    ),
                  ),
                ),

                //enter new password error text
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Text(
                    _errorText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),

                //code
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[90],
                      border:
                          Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _codeController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'enter code',
                        ),
                      ),
                    ),
                  ),
                ),

                //submit button
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
                          _confirm(context);
                        },
                        child: const Center(
                          child: Text(
                            'Submit',
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

                //request new code button
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
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
                          _resendCode();
                        },
                        child: const Center(
                          child: Text(
                            'Request Another Code',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0E0E0E),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
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
