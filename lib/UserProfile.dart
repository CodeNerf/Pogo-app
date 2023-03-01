import 'package:flutter/material.dart';
import 'package:pogo/LoginPage.dart';
import 'package:pogo/models/UserIssueFactorValues.dart'
    hide UserIssueFactorValues;
import 'amplifyFunctions.dart';
import 'awsFunctions.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'dynamoModels/CandidateIssueFactorValues.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  //this is just for testing purposes, to be removed later
  Future logout(BuildContext context) async {
    var m = {
      "reproductiveWeight": 4,
      "policingScore": 2,
      "housingScore": 2,
      "reproductiveScore": 2,
      "healthcareScore": 5,
      "drugPolicyScore": 5,
      "immigrationScore": 2,
      "educationScore": 2,
      "drugPolicyWeight": 1,
      "policingWeight": 3,
      "gunPolicyWeight": 5,
      "climateWeight": 3,
      "immigrationWeight": 3,
      "candidateId": "Iamfromflutter",
      "housingWeight": 4,
      "economyWeight": 2,
      "economyScore": 2,
      "climateScore": 4,
      "healthcareWeight": 4,
      "gunPolicyScore": 5,
      "educationWeight": 2
    };
    var uifv = CandidateIssueFactorValues.fromJson(m);

    print(getCandidateIssueFactorValues("Iamfromflutter"));
    logoutUser();
    if (await checkLoggedIn()) {
      //successfully logged out, send to login
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      //logout not working (this shouldn't ever happen)
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('USER PROFILE PAGE'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  onTap: () async {
                    logout(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3D433),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                        child: Text(
                      'Logout',
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
