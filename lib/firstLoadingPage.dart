import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pogo/HomeLoadingPage.dart';
import 'package:pogo/LandingPage.dart';
import 'package:pogo/Onboarding/SurveyLandingPage.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';

class FirstLoadingPage extends StatefulWidget {
  const FirstLoadingPage({Key? key}) : super(key: key);

  @override
  State<FirstLoadingPage> createState() => _FirstLoadingPageState();
}

class _FirstLoadingPageState extends State<FirstLoadingPage> {
  @override
  void initState() {
    super.initState();
    _configure(context);
  }

  void _configure(context) async {
    try {
      bool check = await configureAmplify();
      if (check) {
        _loginCheck(context);
      } else {
        safePrint("Error occurred when configuring amplify");
      }
    } catch (e) {
      safePrint("Error occurred in _configure(): $e");
    }
  }

  void _loginCheck(context) async {
    try {
      bool check = await isUserSignedIn();
      if (check) {
        String email = await fetchCurrentUserEmail();
        UserDemographics user = await getUserDemographics(email);
        if (user.surveyCompletion == true) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeLoadingPage(user: user),
            ),
          );
        }
        else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurveyLandingPage(pageSelect: 0,),
            ),
          );
        }
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
        );
      }
    } catch (e) {
      safePrint("Error occurred in _loginCheck(): $e");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Scaffold(
        backgroundColor: Color(0xFFE1E1E1),
        body: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: FittedBox(
              fit: BoxFit.fill,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFE1E1E1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
