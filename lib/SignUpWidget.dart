import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import 'UserConfirmationPage.dart';
import 'amplifyFunctions.dart';
import 'awsFunctions.dart';

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
  double _errorSizeBoxSize = 0;

  // Regular expression for validating email address
  final _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  Future _signUp(context) async {
    if (_fnameController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your name.';
        _errorSizeBoxSize = 10;
      });
    } else if (_emailController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your email.';
        _errorSizeBoxSize = 10;
      });
    } else if (!_emailRegex.hasMatch(_emailController.text)) {
      setState(() {
        _errorText = 'Invalid email address.';
        _errorSizeBoxSize = 10;
      });
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter a password.';
        _errorSizeBoxSize = 10;
      });
    } else if (await signUpUser(_emailController.text, _passwordController.text,
        _fnameController.text)) {
      UserDemographics userDemographics = UserDemographics(
          id: _emailController.text,
          phoneNumber: '',
          registrationState: '',
          addressLine1: '',
          pollingLocation: '',
          voterRegistrationStatus: false,
          firstName: _fnameController.text,
          lastName: '',
          dateOfBirth: '',
          zipCode: '',
          profileImageURL: '',
          gender: '',
          racialIdentity: '',
          politicalAffiliation: '',
          surveyCompletion: false,
          polls: 0,
          loginStreak: 0,
          loginStreakRecord: 0,
          lastLogin: '');
      putUserDemographics(userDemographics);
      putUserBallot(_emailController.text, [], [], []);
      //TODO: create blank ballot then push to db
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
        //FIRST NAME
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
