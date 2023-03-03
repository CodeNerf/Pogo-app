import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/UserIssuesFactors.dart';
import 'package:pogo/amplifyFunctions.dart';
import 'package:pogo/dataModelManipulation.dart';
import 'Home.dart';
import 'user.dart';

class HomeLoadingPage extends StatefulWidget {
  const HomeLoadingPage({Key? key}) : super(key: key);

  @override
  State<HomeLoadingPage> createState() => _HomeLoadingPageState();
}

class _HomeLoadingPageState extends State<HomeLoadingPage> {
  //TODO: implement user issues object
  late user currentUser;
  late UserIssuesFactors currentUserFactors;

  @override
  void initState() {
    initializeObjects();
    super.initState();
  }

  void initializeObjects() async {
    currentUser = await fetchCurrentUserAttributes();
    currentUserFactors = await fetchCurrentUserFactors(currentUser.email);
    setObjectStates(currentUser, currentUserFactors);
  }

  void setObjectStates(user u, UserIssuesFactors uif) {
    setState(() {
      currentUser = u;
      currentUserFactors = uif;
    });
    goHome();
  }
  
  void goHome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(currentUser: currentUser, currentUserFactors: currentUserFactors,),
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


