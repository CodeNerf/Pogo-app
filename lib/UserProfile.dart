import 'package:amplify_core/amplify_core.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pogo/SignInSignUpPage.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:pogo/dynamoModels/Demographics/CandidateDemographics.dart';
import 'LandingPage.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'dynamoModels/Ballot.dart';
import 'dynamoModels/Demographics/UserDemographics.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'dart:math';
import 'EditPersonalInfoPage.dart';
import 'package:share_plus/share_plus.dart';

class UserProfile extends StatefulWidget {
  final UserIssueFactorValues currentUserFactors;
  final UserDemographics currentUserDemographics;
  final List<CandidateDemographics> currentUserBallotCandidates;
  const UserProfile(
      {Key? key,
      required this.currentUserFactors,
      required this.currentUserDemographics,
      required this.currentUserBallotCandidates})
      : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String _firstIssue = "";
  String _secondIssue = "";
  String _thirdIssue = "";
  String _fourthIssue = "";
  final List<num> _ratings = [];
  final TextEditingController _profilePicController = TextEditingController();
  UserDemographics userDemographics = UserDemographics(id: '');
  final List<Widget> _issueDropdownResults = [];
  final List<bool> _issueExpanded = [];

  @override
  void initState() {
    super.initState();
    _ratings.add(widget.currentUserFactors.climateWeight);
    _ratings.add(widget.currentUserFactors.drugPolicyWeight);
    _ratings.add(widget.currentUserFactors.economyWeight);
    _ratings.add(widget.currentUserFactors.educationWeight);
    _ratings.add(widget.currentUserFactors.gunPolicyWeight);
    _ratings.add(widget.currentUserFactors.healthcareWeight);
    _ratings.add(widget.currentUserFactors.housingWeight);
    _ratings.add(widget.currentUserFactors.immigrationWeight);
    _ratings.add(widget.currentUserFactors.policingWeight);
    _ratings.add(widget.currentUserFactors.reproductiveWeight);
    for(int i = 0; i < _ratings.length; i++) {
      _issueExpanded.add(false);

    }
    _setTopIssues(_ratings);
  }

  void _setTopIssues(List<num> ratings) async {
    //will have to change strings to asset image icons
    List<String> topIssues = [];
    var indexMaxCare = ratings.indexOf(ratings.reduce(max));
    for (int i = 0; i < 4; i++) {
      switch (indexMaxCare) {
        case 0:
          topIssues.add('assets/climateIcon.png');
          break;
        case 1:
          topIssues.add('assets/drugPolicyIcon.png');
          break;
        case 2:
          topIssues.add('assets/economyIcon.png');
          break;
        case 3:
          topIssues.add('assets/educationIcon.png');
          break;
        case 4:
          topIssues.add('assets/gunControlIcon.png');
          break;
        case 5:
          topIssues.add('assets/healthcareIcon.png');
          break;
        case 6:
          topIssues.add('assets/housingIcon.png');
          break;
        case 7:
          topIssues.add('assets/immigrationIcon.png');
          break;
        case 8:
          topIssues.add('assets/policingIcon.png');
          break;
        case 9:
          topIssues.add('assets/reproductiveIcon.png');
          break;
      }
      ratings[indexMaxCare] = 0;
      indexMaxCare = ratings.indexOf(ratings.reduce(max));
    }
    setState(() {
      _firstIssue = topIssues[0];
      _secondIssue = topIssues[1];
      _thirdIssue = topIssues[2];
      _fourthIssue = topIssues[3];
    });
  }

  Future _logout(context) async {
    try {
      logoutUser();
      if (await checkLoggedIn()) {
        //successfully logged out, send to login
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
          return const LandingPage();
        }));
      } else {
        //logout not working (this shouldn't ever happen)
      }
    } catch (e) {
      safePrint("Error occurred in _logout: $e");
    }
  }

  final List<String> _issuesText = [
    'GUN POLICY',
    'CLIMATE CHANGE',
    'EDUCATION',
    'DRUG POLICY',
    'HEALTHCARE',
    'HOUSING',
    'ECONOMY',
    'IMMIGRATION',
    'POLICING',
    'REPRODUCTIVE RIGHTS'
  ];

  //change profile pic
  Future<void> _changeProfilePic() async {
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
                  decoration: InputDecoration(
                      labelText:
                          widget.currentUserDemographics.profileImageURL),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (_profilePicController.text !=
                    widget.currentUserDemographics.profileImageURL) {
                  widget.currentUserDemographics.profileImageURL =
                      _profilePicController.text;
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
              child: const Text(
                'Save New Picture',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _profilePic() {
    String pic = widget.currentUserDemographics.profileImageURL;
    bool validURL = Uri.parse(pic).isAbsolute;
    if (validURL) {
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
    } else {
      return const Icon(FontAwesomeIcons.person);
    }
  }

  List<Widget> _getRatingCircles() {
    List<Widget> circles = [];
    circles.add(Row(
      children: [
        _ratingCircles('Alignment', widget.currentUserFactors.educationScore),
        _ratingCircles('Concern', widget.currentUserFactors.educationWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles('Alignment', widget.currentUserFactors.climateScore),
        _ratingCircles('Concern', widget.currentUserFactors.climateWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles(
            'Alignment', widget.currentUserFactors.drugPolicyScore),
        _ratingCircles('Concern', widget.currentUserFactors.drugPolicyWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles('Alignment', widget.currentUserFactors.economyScore),
        _ratingCircles('Concern', widget.currentUserFactors.economyWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles(
            'Alignment', widget.currentUserFactors.healthcareScore),
        _ratingCircles('Concern', widget.currentUserFactors.healthcareWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles(
            'Alignment', widget.currentUserFactors.immigrationScore),
        _ratingCircles('Concern', widget.currentUserFactors.immigrationWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles('Alignment', widget.currentUserFactors.policingScore),
        _ratingCircles('Concern', widget.currentUserFactors.policingWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles('Alignment',
            widget.currentUserFactors.reproductiveScore),
        _ratingCircles('Concern', widget.currentUserFactors.reproductiveWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles(
            'Alignment', widget.currentUserFactors.gunPolicyScore),
        _ratingCircles('Concern', widget.currentUserFactors.gunPolicyWeight)
      ],
    ));
    circles.add(Row(
      children: [
        _ratingCircles('Alignment', widget.currentUserFactors.housingScore),
        _ratingCircles('Concern', widget.currentUserFactors.housingWeight)
      ],
    ));
    return circles;
  }

  Widget _ratingCircles(String name, num rating) {
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
        percent: rating / 5,
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

  _showAlert(context) {
    //function below is used to collapse all other dropdowns when another is clicked
    void expandTap(bool expanded, int index) {
      if (expanded) {
        switch (index) {
          case 0:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 0) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 1:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 1) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 2:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 2) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 3:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 3) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 4:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 4) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 5:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 5) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 6:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 6) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 7:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 7) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 8:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 8) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          case 9:
            for(int i = 0; i < _issueExpanded.length; i++) {
              if(i == 9) {
                _issueExpanded[i] = true;
              }
              else {
                _issueExpanded[i] = false;
              }
            }
            break;
          default:
            for(int i = 0; i < _issueExpanded.length; i++) {
              _issueExpanded[i] = false;
            }
            break;
        }
      } else {
        setState(() {});
      }
    }
    //pop up for survey results
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //issue 1 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[0],
                          onExpansionChanged: (bool expanded) {
                            setState(() => expandTap(expanded, 0));
                          },
                          title: const Text(
                            "EDUCATION",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[0],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 4,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 2 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[1],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 1));
                            setState;
                          },
                          title: const Text(
                            "CLIMATE",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[1],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 3,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 3 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[2],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 2));
                            setState;
                          },
                          title: const Text(
                            "DRUG POLICY",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[2],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 5,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 4 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[3],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 3));
                            setState;
                          },
                          title: const Text(
                            "ECONOMY",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[3],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 8,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 5 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[4],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 4));
                            setState;
                          },
                          title: const Text(
                            "HEALTHCARE",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[4],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 6,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 6 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[5],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 5));
                            setState;
                          },
                          title: const Text(
                            "IMMIGRATION",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[5],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 9,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 7 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[6],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 6));
                            setState;
                          },
                          title: const Text(
                            "POLICING",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[6],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 10,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 8 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[7],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 7));
                            setState;
                          },
                          title: const Text(
                            "REPRODUCTIVE HEALTH",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[7],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 11,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 9 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[8],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 8));
                            setState;
                          },
                          title: const Text(
                            "GUN POLICY",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[8],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 2,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //issue 10 dropdown
                        ExpansionTile(
                          key: GlobalKey(),
                          initiallyExpanded: _issueExpanded[9],
                          onExpansionChanged: (bool expanded){
                            setState(() => expandTap(expanded, 9));
                            setState;
                          },
                          title: const Text(
                            "HOUSING",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Color(0xFF57636C),
                            ),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _getRatingCircles()[9],
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurveyLandingPage(pageSelect: 7,),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
            ),);
        });
  }

  void _editPersonalInfo(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditPersonalInfoPage(
              userDemographics: widget.currentUserDemographics)),
    );
  }

  String getUserExperience(int polls) {
    //this function will be used to determine the level of the user, e.g 0 polls - beginner
    switch (polls) {
      case 0:
        return 'Beginner';
      case 1:
        return 'Novice';
      case 2:
        return 'Intermediate';
      case 3:
        return 'Advanced';
      case 4:
        return 'Expert';
      default:
        return 'Pro';
    }
  }

  String getLoginStreakText() {
    if (widget.currentUserDemographics.loginStreak ==
        widget.currentUserDemographics.loginStreakRecord) {
      return 'New Record!';
    }
    return '';
  }

  String ballotMessage() {
    String message = "Check out my PoGo ballot! I'm going to vote for:\n";
    for (int i = 0; i < widget.currentUserBallotCandidates.length; i++) {
      message += "${widget.currentUserBallotCandidates[i].candidateName}\n";
    }
    return message;
  }

  String pogoLinkMessage() {
    //differentiate between android and ios here
    return "Come download the PoGo app! https://www.politicsonthego.info";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        color: const Color(0xFFF1F4F8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //hello name
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Hello ${widget.currentUserDemographics.firstName}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            //profile picture
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: GestureDetector(
                onTap: () {
                  _changeProfilePic();
                },
                child: CircularProfileAvatar(
                  '',
                  radius: 40,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: _profilePic(),
                  ),
                ),
              ),
            ),

            //user profile level and streak container
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              //overall container
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(3, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  //row of contents
                  child: Row(
                    children: [
                      //user level and polls
                      Row(
                        children: [
                          //star circle
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFD9D9D9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 0.1,
                                  blurRadius: 4,
                                  offset: const Offset(-3, 6),
                                ),
                              ],
                            ),
                            child: const FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.star_rate,
                                color: Color(0xFF8CC461),
                              ),
                            ),
                          ),
                          //experience level and polls
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              width: 100,
                              height: 50,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      getUserExperience(
                                          widget.currentUserDemographics.polls),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0E0E0E),
                                        fontSize: 22,
                                      ),
                                    ),
                                    AutoSizeText(
                                      '${widget.currentUserDemographics.polls} Polls',
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF57636C),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      //user streak
                      Row(
                        children: [
                          //star circle
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFD9D9D9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 0.1,
                                  blurRadius: 4,
                                  offset: const Offset(-3, 6),
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image(
                                  image: AssetImage('assets/flame.png'),
                                ),
                              ),
                            ),
                          ),
                          //experience level and polls
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              width: 100,
                              height: 50,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //TODO: placeholder streak values will need to be replaced
                                  children: [
                                    AutoSizeText(
                                      '${widget.currentUserDemographics.loginStreak} day streak',
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0E0E0E),
                                        fontSize: 22,
                                      ),
                                    ),
                                    AutoSizeText(
                                      getLoginStreakText(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF57636C),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //       builder: (context) => AddressAutocomplete(
            //     //           userDemographics: userDemographics)),
            //     // );
            //   },
            //   child: Center(
            //     child: Text(
            //       'Click here to go to Address Autocomplete Page',
            //       style: TextStyle(
            //         decoration: TextDecoration.underline,
            //         color: Colors.blue,
            //         fontSize: 18.0,
            //       ),
            //     ),
            //   ),
            // ),

            //your top issues, top issues icons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //your top issues
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Your top issues',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xFF0E0E0E),
                      ),
                    ),
                  ),
                  //top issues icons
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image(
                              image: AssetImage(_firstIssue),
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image(
                              image: AssetImage(_secondIssue),
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image(
                              image: AssetImage(_thirdIssue),
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9F9F9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image(
                              image: AssetImage(_fourthIssue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //invite friends and share your ballot
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              //overall container
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(3, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      //toaster pull up
                      showModalBottomSheet(
                          context: context,
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          backgroundColor: const Color(0xFFFFFFFF),
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 13.0),
                                    child: Container(
                                      height: 7,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFD9D9D9),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: Text(
                                      "Invite Friends",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Share.share(
                                            pogoLinkMessage(),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFD9D9D9),
                                          ),
                                          child: const FittedBox(
                                            fit: BoxFit.cover,
                                            child:
                                                Icon(Icons.ios_share_rounded),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: Text(
                                      "Share your ballot!",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (widget.currentUserBallotCandidates
                                              .isNotEmpty) {
                                            Share.share(
                                              ballotMessage(),
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFD9D9D9),
                                          ),
                                          child: const FittedBox(
                                            fit: BoxFit.cover,
                                            child:
                                                Icon(Icons.ios_share_rounded),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      //row of contents
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          AutoSizeText(
                            'Invite Friends & Share Your Ballot!',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF0E0E0E),
                            ),
                          ),
                          Divider(
                            color: Color(0xFFDBE2E7),
                            height: 10,
                            thickness: 1,
                          ),
                          AutoSizeText(
                            'Help your friends vote informed',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //personal info
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              //overall container
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(3, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      _editPersonalInfo(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      //row of contents
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          AutoSizeText(
                            'Personal Info',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF0E0E0E),
                            ),
                          ),
                          Divider(
                            color: Color(0xFFDBE2E7),
                            height: 10,
                            thickness: 1,
                          ),
                          AutoSizeText(
                            'Edit your personal info',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //survey results
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              //overall container
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(3, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      _showAlert(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      //row of contents
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          AutoSizeText(
                            'Survey Results',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF0E0E0E),
                            ),
                          ),
                          Divider(
                            color: Color(0xFFDBE2E7),
                            height: 10,
                            thickness: 1,
                          ),
                          AutoSizeText(
                            'View and edit your stance on popular issues',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xFF57636C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //logout button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF3D433),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    _logout(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
