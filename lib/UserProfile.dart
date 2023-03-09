import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pogo/LoginPage.dart';
import 'package:pogo/awsFunctions.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'dynamoModels/UserDemographics.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'user.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'dart:math';
import 'EditPersonalInfoPage.dart';

class UserProfile extends StatefulWidget {
  final UserIssueFactorValues currentUserFactors;
  UserDemographics currentUserDemographics;
  UserProfile({Key? key, required this.currentUserFactors, required this.currentUserDemographics}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String firstIssue = "";
  String secondIssue = "";
  String thirdIssue = "";
  List<num> ratings = [];
  final TextEditingController _profilePicController = TextEditingController();
  String errorText = '';
  
  @override
  void initState() {
    super.initState();
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
          topIssues.add('DRUG POLICY');
          break;
        case 2:
          topIssues.add('ECONOMY');
          break;
        case 3:
          topIssues.add('EDUCATION');
          break;
        case 4:
          topIssues.add('GUN POLICY');
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
        topIssues.add('REPRODUCTIVE RIGHTS');
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

  //change profile pic
  Future<void> changeProfilePic() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter the url of your new profile picture:'),
                TextField(
                  controller: _profilePicController,
                  decoration: InputDecoration(labelText: widget.currentUserDemographics.profileImageURL),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if(_profilePicController.text != widget.currentUserDemographics.profileImageURL) {
                  widget.currentUserDemographics.profileImageURL = _profilePicController.text;
                  putUserDemographics(widget.currentUserDemographics);
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFF3D433),
                elevation: 0,
                minimumSize: Size(double.infinity, 48),
              ),
              child: const Text('Save New Picture' ,style: TextStyle(fontSize:17, color: Colors.black ),),
            ),
          ],
        );
      },
    );
  }

  Widget profilePic() {
    String pic = widget.currentUserDemographics.profileImageURL;
    bool validURL = Uri.parse(pic).isAbsolute;
    if(validURL) {
      return CircularProfileAvatar(
        '',
        radius: 60,
        elevation: 5,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image(
            image: NetworkImage(pic),
          ),
        ),
      );
    }
    else {
      return const Icon(FontAwesomeIcons.person);
    }
  }

  List<Widget> getRatingCircles() {
    List<Widget> circles = [];
    circles.add(Column(children: [ratingCircles('Education\n', widget.currentUserFactors.educationScore), ratingCircles('Care', widget.currentUserFactors.educationWeight)],));
    circles.add(Column(children: [ratingCircles('Climate\n', widget.currentUserFactors.climateScore), ratingCircles('Care', widget.currentUserFactors.climateWeight)],));
    circles.add(Column(children: [ratingCircles('Drug Policy\n', widget.currentUserFactors.drugPolicyScore), ratingCircles('Care', widget.currentUserFactors.drugPolicyWeight)],));
    circles.add(Column(children: [ratingCircles('Economy\n', widget.currentUserFactors.economyScore), ratingCircles('Care', widget.currentUserFactors.economyWeight)],));
    circles.add(Column(children: [ratingCircles('Healthcare\n', widget.currentUserFactors.healthcareScore), ratingCircles('Care', widget.currentUserFactors.healthcareWeight)],));
    circles.add(Column(children: [ratingCircles('Immigration\n', widget.currentUserFactors.immigrationScore), ratingCircles('Care', widget.currentUserFactors.immigrationWeight)],));
    circles.add(Column(children: [ratingCircles('Policing\n', widget.currentUserFactors.policingScore), ratingCircles('Care', widget.currentUserFactors.policingWeight)],));
    circles.add(Column(children: [ratingCircles('Reproductive\nHealth', widget.currentUserFactors.reproductiveScore), ratingCircles('Care', widget.currentUserFactors.reproductiveWeight)],));
    circles.add(Column(children: [ratingCircles('Gun Control\n', widget.currentUserFactors.gunPolicyScore), ratingCircles('Care', widget.currentUserFactors.gunPolicyWeight)],));
    circles.add(Column(children: [ratingCircles('Housing\n', widget.currentUserFactors.housingScore), ratingCircles('Care', widget.currentUserFactors.housingWeight)],));
    return circles;
  }

  Widget ratingCircles(String name, num rating) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: CircularPercentIndicator(
        radius: 25,
        lineWidth: 6,
        progressColor: const Color(0xFFF3D433),
        backgroundColor: const Color(0xFF8B9DDE),
        footer: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        percent: rating/5,
        center: Text(
          '$rating',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String checkRegistered(bool voterRegistrationStatus) {
    if(voterRegistrationStatus) {
      return 'Registered to Vote';
    }
    else {
      return 'Not registered to Vote';
    }
  }

  showAlert(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      content: Text('A low rating for a political issue means that you align more to the left on that issue. A high rating means you align more to the right.\nThe higher your care rating is for an issue, the more you care about that issue.\nYou can retake the survey at any time to change your ratings by clicking the "Retake Survey" button below.'),
    );
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }

  void editPersonalInfo(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPersonalInfoPage(userDemographics: widget.currentUserDemographics)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //hello name text
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                    'Hello, ${widget.currentUserDemographics.firstName}',
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
                    child: FittedBox(
                    fit: BoxFit.cover,
                    child: profilePic(),
                  ),
                  ),
                ),
              ),
            ),
/*
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Personal Info',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
           IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                UserDemographics updatedUserDemographics = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPersonalInfoPage(userDemographics: widget.currentUserDemographics)),
                );
                if (updatedUserDemographics != null) {
                  setState(() {
                    widget.currentUserDemographics = updatedUserDemographics;
                  });
                }
              },
            )
            ],
          ),

          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: ${widget.currentUserDemographics.userId}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Phone: ${widget.currentUserDemographics is UserDemographics ? widget.currentUserDemographics.phoneNumber : "N/A"}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Address: ${widget.currentUserDemographics is UserDemographics ? widget.currentUserDemographics.addressLine1 : "N/A"}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
    ),
  ),
),
            */
          //personal info
            ExpansionTile(
              title: Row(
                children: [
                  const Text(
                    'Personal Info',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      editPersonalInfo(context);
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 25,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.grey[200],
              collapsedBackgroundColor: Colors.grey[500],
              initiallyExpanded: true,
              textColor: Colors.black,
              collapsedTextColor: Colors.black,
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                          'Email: ${widget.currentUserDemographics.userId}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            'Last Name: ${widget.currentUserDemographics.lastName}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            'Phone Number: ${widget.currentUserDemographics.phoneNumber}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            'Gender: ${widget.currentUserDemographics.gender}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            'Ethnicity : ${widget.currentUserDemographics.racialIdentity}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            'Political Affiliation: ${widget.currentUserDemographics.politicalAffiliation}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Text(
                            checkRegistered(widget.currentUserDemographics.voterRegistrationStatus),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //survey results
            ExpansionTile(
              title: Row(
                children: [
                  const Text(
                    'Survey Results',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showAlert(context);
                    },
                    child: const Icon(
                      CupertinoIcons.question_circle,
                      size: 25,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.grey[200],
              collapsedBackgroundColor: Colors.grey[500],
              textColor: Colors.black,
              collapsedTextColor: Colors.black,
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: getRatingCircles(),
                  ),
                ),
              ],
            ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          firstIssue,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          secondIssue,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          thirdIssue,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    /*
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
                    */
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            //share ballot social media
            /*
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
             */
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3D433),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                        child: Text(
                          'Retake Survey',
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
      ),
    );
  }
}

