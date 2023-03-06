import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/UserIssuesFactors.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/dataModelManipulation.dart';
import 'Home.dart';
import 'user.dart';
//import 'CandidateDemographics.dart';
import 'awsFunctions.dart';
import 'dynamoModels/CandidateDemographics.dart';

class HomeLoadingPage extends StatefulWidget {
  const HomeLoadingPage({Key? key}) : super(key: key);

  @override
  State<HomeLoadingPage> createState() => _HomeLoadingPageState();
}

class _HomeLoadingPageState extends State<HomeLoadingPage> {
  //TODO: implement user issues object
  late user currentUser;
  late UserIssuesFactors currentUserFactors;
  late List<CandidateDemographics> candidateStack;
  @override
  void initState() {
    initializeObjects();
    super.initState();
  }

  void initializeObjects() async {
    currentUser = await fetchCurrentUserAttributes();
    currentUserFactors = await fetchCurrentUserFactors(currentUser.email);
    candidateStack = await getAllCandidateDemographics();
    setObjectStates(currentUser, currentUserFactors, candidateStack);
  }

  void setObjectStates(user u, UserIssuesFactors uif, List<CandidateDemographics> s) {
    setState(() {
      currentUser = u;
      currentUserFactors = uif;
      candidateStack = s;
    });
    goHome();
  }
  
  void goHome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(currentUser: currentUser, currentUserFactors: currentUserFactors, candidateStack: candidateStack,),
      ),
    );
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


