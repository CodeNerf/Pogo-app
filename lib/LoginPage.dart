import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pogo/Onboarding/SurveyLandingPage.dart';
import 'package:pogo/UserConfirmationPage.dart';
//import 'package:pogo/models/ModelProvider.dart';
import 'package:pogo/user.dart';
import 'Home.dart';
import 'RegisterPage.dart';
import 'homeLoadingPage.dart';
import 'ForgotPasswordPage.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/UserIssueFactorValues.dart';

//TODO: add more ways to login: google, instagram, etc..
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String signInPogoLogo = 'assets/Pogo_logo_horizontal.png';
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();
  bool obscure = true;
  Icon eye = Icon(Icons.remove_red_eye);
  String errorText = '';
  user guest = user.all("Guest", "", "", "", "");
  UserIssueFactorValues guestFactors = UserIssueFactorValues(userId: '', climateScore: 0, climateWeight: 0, drugPolicyScore: 0, drugPolicyWeight: 0, economyScore: 0, economyWeight: 0, educationScore: 0, educationWeight: 0, gunPolicyScore: 0, gunPolicyWeight: 0, healthcareScore: 0, healthcareWeight: 0, housingScore: 0, housingWeight: 0, immigrationScore: 0, immigrationWeight: 0, policingScore: 0, policingWeight: 0, reproductiveScore: 0, reproductiveWeight: 0);

  Future login(context) async {
    if (await signInUser(emailController.text, passwordController.text)) {
      safePrint("checking isUserSignedIn()");
      if (await isUserSignedIn()) {
        //check if survey is completed
        safePrint("checking isSurveyCompleted()");
        if (await isSurveyCompleted()) {
          safePrint("SURVEY IS COMPLETE");
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeLoadingPage(),
            ),
          );
        } else {
          safePrint("SURVEY IS NOT COMPLETE");
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
          errorText = 'Could not log in.';
        });
      }
    } else {
      setState(() {
        errorText = 'Could not log in.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E1E1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //LOGO
                Transform.scale(
                  scale: 0.7,
                  child: Image(
                    image: AssetImage(
                      signInPogoLogo,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                //ERROR TEXT
                Text(
                  errorText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                //email textfield
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
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

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
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (obscure) {
                                setState(() {
                                  obscure = false;
                                  eye =
                                      const Icon(Icons.remove_red_eye_outlined);
                                });
                              } else {
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

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () async {
                      login(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3D433),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                        'Login',
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

                //guest button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(currentUser: guest, currentUserFactors: guestFactors, candidateStack: [],),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                        'Continue as Guest',
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
                //register
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    ' Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
