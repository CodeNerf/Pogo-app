import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'Onboarding/SurveyLandingPage.dart';

class UserConfirmationPage extends StatefulWidget {
  final String email;
  final String password;
  const UserConfirmationPage({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  State<UserConfirmationPage> createState() => _UserConfirmationPage();
}

class _UserConfirmationPage extends State<UserConfirmationPage> {
  String pogoLogo = 'assets/Pogo_logo_horizontal.png';
  final codeController = TextEditingController();
  late String email = widget.email;
  late String password = widget.password;
  String errorText = '';
  double errorSizeBoxSize = 0;
  Color errorTextColor = Colors.green;

  Future confirm(context) async {
    if(await confirmUser(email, codeController.text)) {
      await signInUser(email, password);
      if (await checkLoggedIn()) {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SurveyLandingPage())
        );
      }
    }
    else {
      setState(() {
        errorText = 'Account could not be confirmed. Check if the code entered was correct or request for a new code to be sent.';
        errorSizeBoxSize = 10;
        errorTextColor = Colors.red;
      });
    }
  }

  Future resendCode() async {
    if(await resendConfirmationCode(email)) {
      errorText = 'A new code was sent to your email.';
      errorSizeBoxSize = 10;
      errorTextColor = Colors.green;
    }
    else {
      //this shouldn't happen
      errorText = 'Error occurred when requesting for a new code.';
      errorSizeBoxSize = 10;
      errorTextColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E1E1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  pogoLogo,
                ),
              ),
              const SizedBox(height: 150),
              //account confirmation instructions
              const Text(
                'Enter the code that was sent to your email to confirm your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),

              //ERROR TEXT
              Text(
                errorText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: errorTextColor,
                ),
              ),
              SizedBox(height: errorSizeBoxSize),

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
                      controller: codeController,
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
                    confirm(context);
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
                    resendCode();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3D433),
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
    );
  }
}
