import 'package:flutter/material.dart';
import 'package:pogo/LoginPage.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'user.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class UserProfile extends StatefulWidget {
  final user currentUser;
  final UserIssueFactorValues currentUserFactors;
  const UserProfile({Key? key, required this.currentUser, required this.currentUserFactors}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String fname = "";
  String lname = "";
  String email = "";
  String phone = "";
  String address = "";
  String firstIssue = "";
  String secondIssue = "";
  String thirdIssue = "";
  List<num> ratings = [];
  @override
  void initState() {
    super.initState();
    fname = widget.currentUser.fname;
    lname = widget.currentUser.lname;
    email = widget.currentUser.email;
    phone = widget.currentUser.phone;
    address = widget.currentUser.address;
    ratings.add(widget.currentUserFactors.climateWeight);
    ratings.add(widget.currentUserFactors.drugPolicyWeight);
    ratings.add(widget.currentUserFactors.economyWeight);
    ratings.add(widget.currentUserFactors.educationWeight);
    ratings.add(widget.currentUserFactors.gunPolicyWeight);
    ratings.add(widget.currentUserFactors.healthcareWeight);
    ratings.add(widget.currentUserFactors.housingWeight);
    ratings.add(widget.currentUserFactors.immigrationWeight);
    ratings.add(widget.currentUserFactors.policingWeight);
    ratings.add(widget.currentUserFactors.reproductiveWeight);
    setTopIssues(ratings);
  }

  void setTopIssues(List<num> ratings) async {
    List<String> topIssues = [];
    var maxCare = ratings.reduce(max);
    var indexMaxCare = ratings.indexOf(ratings.reduce(max));
    for(int i = 0; i < 3; i++) {
      switch(indexMaxCare) {
        case 0:
          topIssues.add('CLIMATE');
          break;
        case 1:
          topIssues.add('DRUGPOLICY');
          break;
        case 2:
          topIssues.add('ECONOMY');
          break;
        case 3:
          topIssues.add('EDUCATION');
          break;
        case 4:
          topIssues.add('GUNPOLICY');
          break;
        case 5:
          topIssues.add('HEALTHCARE');
          break;
        case 6:
          topIssues.add('HOUSING');
          break;
        case 7:
          topIssues.add('IMMIGRATION');
          break;
        case 8:
          topIssues.add('POLICING');
          break;
        case 9:
        topIssues.add('REPRODUCTIVERIGHTS');
          break;
      }
      ratings[indexMaxCare] = 0;
      maxCare = ratings.reduce(max);
      indexMaxCare = ratings.indexOf(ratings.reduce(max));
    }
    setState(() {
      firstIssue = topIssues[0];
      secondIssue = topIssues[1];
      thirdIssue = topIssues[2];
    });
  }

  //this is just for testing purposes, to be removed later
  Future logout(context) async {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //hello name text
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                  'Hello, $fname',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //profile picture
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,10),
              child: GestureDetector(
                onTap: () {
                  changeProfilePic();
                },
                child: CircularProfileAvatar(
                  '',
                  radius: 40,
                  child: const FlutterLogo(),
                ),
              ),
            ),
          ),

          //expandable section
          /*
          ExpandablePanel(
              header: Text('Personal Info'),
              expanded: Text('Email: $email',),
              collapsed: const Text(''),
          ),

           */

          //Personal info
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Info',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email: $email',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Phone: $phone',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Address: $address',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          //survey results
          Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height/10,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Survey Results',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,0,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '...',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          //top issues
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Your Top Issues: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        firstIssue,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        secondIssue,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        thirdIssue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),


          //share ballot social media
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Share Your \nBallot',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        FontAwesomeIcons.facebook,
                      ),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        FontAwesomeIcons.instagram,
                      ),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        FontAwesomeIcons.snapchat,
                      ),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        FontAwesomeIcons.twitter,
                      ),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        FontAwesomeIcons.linkedin,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          //logout button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  logout(context);
                },
                child: Container(
                  //alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3D433),
                    borderRadius: BorderRadius.circular(50),
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
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurveyLandingPage(),
                    ),
                  );
                },
                child: Container(
                  //alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3D433),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                      child: Text(
                        'Re-Take Survey',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> changeProfilePic() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
