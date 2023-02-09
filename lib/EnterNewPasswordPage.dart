import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'ForgotPasswordPage.dart';
import 'LoginPage.dart';

class EnterNewPasswordPage extends StatefulWidget {
  final String email;
  const EnterNewPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  State<EnterNewPasswordPage> createState() => _EnterNewPasswordPageState();
}

class _EnterNewPasswordPageState extends State<EnterNewPasswordPage> {
  String pogoLogo = 'assets/Pogo_logo_horizontal.png';
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  String errorText = '';
  bool obscure = true;
  Icon eye = Icon(Icons.remove_red_eye);

  Future confirmReset(context) async {
    if(passwordController.text.isEmpty) {
      setState(() {
        errorText = 'Password cannot be blank.';
      });
    }
    else if(codeController.text.isEmpty) {
      setState(() {
        errorText = 'Code cannot be blank.';
      });
    }
    //send link to user email to reset password
    else if(await confirmResetPassword(widget.email, passwordController.text, codeController.text)) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
    else {
      setState(() {
        errorText = 'Could not reset password. Check to make sure all fields are correct and try again.';
      });
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
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: Image(
                          image: AssetImage(
                            pogoLogo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 150),

              //instructions
              const Text(
                'Enter a new password that is at least 8 characters long and contains at least 1 uppercase letter and 1 symbol. Then enter the password reset code that was sent to your email.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),

              //ERROR TEXT
              Text(
                errorText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 15),

              //password textfield
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
                      controller: passwordController,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'New Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if(obscure) {
                              setState(() {
                                obscure = false;
                                eye = const Icon(Icons.remove_red_eye_outlined);
                              });
                            }
                            else {
                              setState(() {
                                obscure = true;
                                eye = const Icon(Icons.remove_red_eye);
                              });
                            }
                          },
                          child: eye,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //code textfield
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
              const SizedBox(height: 20),

              //submit button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  //TODO: create login() backend function
                  onTap: () async {
                    confirmReset(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3D433),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }
}