import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'ForgotPasswordPage.dart';
import 'SignInSignUpPage.dart';

class EnterNewPasswordPage extends StatefulWidget {
  final String email;
  final Function(int) switchPage;
  const EnterNewPasswordPage({Key? key, required this.email, required this.switchPage}) : super(key: key);

  @override
  State<EnterNewPasswordPage> createState() => _EnterNewPasswordPageState();
}

class _EnterNewPasswordPageState extends State<EnterNewPasswordPage> {
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  String _errorText = '';
  bool _obscure = true;
  Icon _eye = Icon(Icons.remove_red_eye);

  Future _confirmNewPassword(context) async {
    try {
      if (_passwordController.text.isEmpty) {
        setState(() {
          _errorText = 'Password cannot be blank.';
        });
      } else if (_codeController.text.isEmpty) {
        setState(() {
          _errorText = 'Code cannot be blank.';
        });
      }
      //send link to user email to reset password
      else if (await confirmResetPassword(
          widget.email, _passwordController.text, _codeController.text)) {
        widget.switchPage(0);
      } else {
        setState(() {
          _errorText =
              'Could not reset password. Check to make sure all fields are correct and try again.';
        });
      }
    } catch (e) {
      safePrint("An error occurred in _confirmNewPassword: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //confused creature
        const SizedBox(
          height: 200,
          width: 200,
          child: FittedBox(
              fit: BoxFit.contain,
              child: Image(
                image: AssetImage('assets/forgotPasswordImage.png'),
              )
          ),
        ),

        //reset password text
        const Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Text(
            'Reset Password',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 30,
              color: Color(0xFF0E0E0E),
            ),
          ),
        ),

        //ERROR TEXT
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Text(
            _errorText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),

        //code textfield
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'code',
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
                  hintText: 'new password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_obscure) {
                        setState(() {
                          _obscure = false;
                          _eye = const Icon(Icons.remove_red_eye_outlined, color: Colors.grey);
                        });
                      } else {
                        setState(() {
                          _obscure = true;
                          _eye = const Icon(Icons.remove_red_eye, color: Colors.grey);
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
                  _confirmNewPassword(context);
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
      ],
    );
  }
}
