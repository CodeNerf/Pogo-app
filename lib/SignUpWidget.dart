import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'UserConfirmationPage.dart';
import 'amplifyFunctions.dart';
import 'awsFunctions.dart';
import 'dynamoModels/Demographics/UserDemographics.dart';

class SignUp extends StatefulWidget {
  final Function(int) switchPage;
  const SignUp({Key? key, required this.switchPage}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _fnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  Icon _eye = const Icon(Icons.remove_red_eye);
  String _errorText = '';

  // Regular expression for validating email address
  final _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  Map<String, dynamic> hasRequiredCharacters(String input) {
    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasNumber = false;
    bool hasSpecialChar = false;
    String errorString =
        'Password must contain at least: 1 uppercase, 1 lowercase, 1 number, 1 special character';

    final uppercasePattern = RegExp(r'[A-Z]');
    final lowercasePattern = RegExp(r'[a-z]');
    final numberPattern = RegExp(r'[0-9]');
    final specialCharPattern = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    for (int i = 0; i < input.length; i++) {
      if (uppercasePattern.hasMatch(input[i])) {
        hasUppercase = true;
      } else if (lowercasePattern.hasMatch(input[i])) {
        hasLowercase = true;
      } else if (numberPattern.hasMatch(input[i])) {
        hasNumber = true;
      } else if (specialCharPattern.hasMatch(input[i])) {
        hasSpecialChar = true;
      }
    }

    bool result = hasUppercase && hasLowercase && hasNumber && hasSpecialChar;

    if (result) {
      errorString = '';
    }

    return {'result': result, 'message': errorString};
  }

  Future _signUp(context) async {
    Map<String, dynamic> hasPasswordRequirements =
        hasRequiredCharacters(_passwordController.text);
    if (_fnameController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your name.';
      });
    } else if (_emailController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your email.';
      });
    } else if (!_emailRegex.hasMatch(_emailController.text)) {
      setState(() {
        _errorText = 'Invalid email address.';
      });
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter a password.';
      });
      //Checks if password has uppercase lowercase and special character
    } else if (!hasPasswordRequirements['result']) {
      setState(() {
        _errorText = hasPasswordRequirements['message'];
      });
    } else if (await signUpUser(_emailController.text, _passwordController.text,
        _fnameController.text)) {
      UserDemographics userDemographics = UserDemographics(
          id: _emailController.text, firstName: _fnameController.text);
      userDemographics.lastLogin =
          DateFormat('yyyy-MM-dd').format(DateTime.now());
      userDemographics.loginStreak = 1;
      await putUserDemographics(userDemographics);
      await putUserBallot(_emailController.text, [], [], []);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserConfirmationPage(
                  email: _emailController.text,
                  password: _passwordController.text)));
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree.
    _fnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // sign up / sign in
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //sign in button
              GestureDetector(
                onTap: () {
                  widget.switchPage(0);
                },
                child: const Opacity(
                  opacity: 0.5,
                  child: Text(
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
                ),
              ),
              //inactive sign up button
              const Text(
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
            ],
          ),
        ),
        //get started. make an account today!
        const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Get started. Make an account today!",
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
        //sign up error text
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
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
        //FIRST NAME
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _fnameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'your first name',
                ),
              ),
            ),
          ),
        ),
        //EMAIL
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _emailController,
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
                controller: _passwordController,
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

        //sign up button
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
                  _signUp(context);
                },
                child: const Center(
                  child: Text(
                    'Sign Up',
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
