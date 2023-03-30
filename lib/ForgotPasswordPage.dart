import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'EnterNewPasswordPage.dart';
import 'SignInSignUpPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  final _emailController = TextEditingController();
  String _errorText = '';

  Future _requestPasswordResetCode(context) async {
    try {
      if (_emailController.text.isEmpty) {
        setState(() {
          _errorText = 'Email cannot be blank.';
        });
      }
      //send link to user email to reset password
      else if (await resetPassword(_emailController.text)) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EnterNewPasswordPage(email: _emailController.text),
          ),
        );
      } else {
        setState(() {
          _errorText =
              'Could not send the password reset code. Please check that the email entered is correct.';
        });
      }
    } catch (e) {
      safePrint("An error occurred in _requestPasswordResetCode: $e");
    }
  }

  void _goBack() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const SignInSignUpPage(index: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => _goBack(),
        ),
        centerTitle: true,
        title: Image(
          image: AssetImage(_pogoLogo),
          width: 150,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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

              //forgot password text
              const Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Text(
                  'Forgot Password?',
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
                  r"""Don't worry! It happens. Enter the email associated with your account to receive a password reset code.""",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Color(0xFF57636C),
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

              //EMAIL
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'example@email.com',
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
                        _requestPasswordResetCode(context);
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
          ),
        ),
      ),
    );
  }
}
