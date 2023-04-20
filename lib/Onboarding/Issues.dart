import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pogo/IssuesDefinitions.dart';
import 'package:pogo/amplifyFunctions.dart';
import '../HomeLoadingPage.dart';
import '../dynamoModels/Demographics/UserDemographics.dart';
import '../awsFunctions.dart';
import '../dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import 'VoterInfo.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Issues extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  final int issuesIndex;
  late final Widget nextPage = HomeLoadingPage(
    user: answers,
  );
  late final Widget lastPage = VoterInfo(
    ratings: ratings,
    answers: answers,
    issuesIndex: issuesIndex,
  );
  Issues(
      {Key? key,
      required this.ratings,
      required this.answers,
      required this.issuesIndex})
      : super(key: key);

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  late int _issueIndex;

  final int _nextButtonColor = 0xFFF3D433;
  double _alignRating = 0;
  double _valueRating = 0;
  late bool _backVisibility;
  late bool _forwardVisibility;
  bool _submitVisibility = false;
  late String _submitButtonText;
  late double _submitButtonTextSize;
  final IssuesDefinitions _issueDefs = IssuesDefinitions();

  @override
  void initState() {
    super.initState();
    if(widget.answers.surveyCompletion) {
      _submitButtonText = "Save Changes";
      _submitButtonTextSize = 25;
    }
    else {
      _submitButtonText = "PoGo";
      _submitButtonTextSize = 35;
    }
    _issueIndex = widget.issuesIndex;
    _alignRating = widget.ratings.gunPolicyScore.toDouble();
    _valueRating = widget.ratings.gunPolicyWeight.toDouble();
    //check if any values are 0 (0 means user never completed survey yet) if not make button yellow
    List<num> scores = [
      widget.ratings.gunPolicyScore,
      widget.ratings.policingScore,
      widget.ratings.reproductiveScore,
      widget.ratings.climateScore,
      widget.ratings.educationScore,
      widget.ratings.drugPolicyScore,
      widget.ratings.immigrationScore,
      widget.ratings.economyScore,
      widget.ratings.healthcareScore,
      widget.ratings.housingScore
    ];
    if (!scores.contains(0)) {
      _submitVisibility = true;
    }
    if (_issueIndex > 0 && _issueIndex < 9) {
      _backVisibility = true;
      _forwardVisibility = true;
    } else if (_issueIndex == 0) {
      _backVisibility = false;
      _forwardVisibility = true;
    } else {
      _forwardVisibility = false;
      _backVisibility = true;
    }
  }

  void _setRatings() {
    switch (_issueIndex) {
      case 0:
        _alignRating = widget.ratings.gunPolicyScore.toDouble();
        _valueRating = widget.ratings.gunPolicyWeight.toDouble();
        break;
      case 1:
        _alignRating = widget.ratings.climateScore.toDouble();
        _valueRating = widget.ratings.climateWeight.toDouble();
        break;
      case 2:
        _alignRating = widget.ratings.educationScore.toDouble();
        _valueRating = widget.ratings.educationWeight.toDouble();
        break;
      case 3:
        _alignRating = widget.ratings.drugPolicyScore.toDouble();
        _valueRating = widget.ratings.drugPolicyWeight.toDouble();
        break;
      case 4:
        _alignRating = widget.ratings.healthcareScore.toDouble();
        _valueRating = widget.ratings.healthcareWeight.toDouble();
        break;
      case 5:
        _alignRating = widget.ratings.housingScore.toDouble();
        _valueRating = widget.ratings.housingWeight.toDouble();
        break;
      case 6:
        _alignRating = widget.ratings.economyScore.toDouble();
        _valueRating = widget.ratings.economyWeight.toDouble();
        break;
      case 7:
        _alignRating = widget.ratings.immigrationScore.toDouble();
        _valueRating = widget.ratings.immigrationWeight.toDouble();
        break;
      case 8:
        _alignRating = widget.ratings.policingScore.toDouble();
        _valueRating = widget.ratings.policingWeight.toDouble();
        break;
      case 9:
        _alignRating = widget.ratings.reproductiveScore.toDouble();
        _valueRating = widget.ratings.reproductiveWeight.toDouble();
        break;
    }
  }

  void _updateAlignRating(double rating) {
    switch (_issueIndex) {
      case 0:
        widget.ratings.gunPolicyScore = rating;
        break;
      case 1:
        widget.ratings.climateScore = rating;
        break;
      case 2:
        widget.ratings.educationScore = rating;
        break;
      case 3:
        widget.ratings.drugPolicyScore = rating;
        break;
      case 4:
        widget.ratings.healthcareScore = rating;
        break;
      case 5:
        widget.ratings.housingScore = rating;
        break;
      case 6:
        widget.ratings.economyScore = rating;
        break;
      case 7:
        widget.ratings.immigrationScore = rating;
        break;
      case 8:
        widget.ratings.policingScore = rating;
        break;
      case 9:
        widget.ratings.reproductiveScore = rating;
        break;
    }
    _alignRating = rating;
    _updateButton();
  }

  void _updateValueRating(double rating) {
    switch (_issueIndex) {
      case 0:
        widget.ratings.gunPolicyWeight = rating;
        break;
      case 1:
        widget.ratings.climateWeight = rating;
        break;
      case 2:
        widget.ratings.educationWeight = rating;
        break;
      case 3:
        widget.ratings.drugPolicyWeight = rating;
        break;
      case 4:
        widget.ratings.healthcareWeight = rating;
        break;
      case 5:
        widget.ratings.housingWeight = rating;
        break;
      case 6:
        widget.ratings.economyWeight = rating;
        break;
      case 7:
        widget.ratings.immigrationWeight = rating;
        break;
      case 8:
        widget.ratings.policingWeight = rating;
        break;
      case 9:
        widget.ratings.reproductiveWeight = rating;
        break;
    }
    _valueRating = rating;
    _updateButton();
  }

  void _updateButton() {
    if (widget.ratings.reproductiveScore != 0 || _issueIndex == 9) {
      _submitVisibility = true;
    }
    if (_issueIndex > 0 && _issueIndex < 9) {
      _backVisibility = true;
      _forwardVisibility = true;
    } else if (_issueIndex == 0) {
      _backVisibility = false;
    } else {
      _forwardVisibility = false;
    }
    setState(() {});
  }

  void _checkRatings(context, String backOrForward) async {
    //THIS IS CALLED WHEN NEXT ARROW ICON IS CLICKED
    if (_alignRating == 0) {
      _updateAlignRating(1);
    }
    if (_valueRating == 0) {
      _updateValueRating(1);
    }
    if (backOrForward == "back") {
      if (_issueIndex != 0) {
        _issueIndex--;
        _setRatings();
        _updateButton();
      }
    } else {
      if (_issueIndex != 9) {
        _issueIndex++;
        _setRatings();
        _updateButton();
      }
    }
    if (_issueIndex == 9) {
      widget.ratings.reproductiveScore = 1;
      widget.ratings.reproductiveWeight = 1;
    }
  }

  void _endSurvey(context) async {
    if (widget.ratings.reproductiveScore != 0) {
      widget.answers.surveyCompletion = true;
      try {
        await Future.wait([
          putUserDemographics(widget.answers),
          putUserIssueFactorValues(widget.ratings),
          matchCandidatesToUser(widget.answers.id)
        ]).then((List<dynamic> values) {
          safePrint("UserDemographics and UserIssueFactorValues updated");
        });
      } catch (e) {
        safePrint("Issues.dart: $e");
      }
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeLoadingPage(user: widget.answers),
        ),
      );
    }
  }

  void _goBack() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoterInfo(
          ratings: widget.ratings,
          answers: widget.answers,
          issuesIndex: _issueIndex,
        ),
      ),
    );
  }

  double setInitialAlignScaleValue() {
    if (_alignRating == 0) {
      return 1;
    }
    return _alignRating;
  }

  double setInitialCareScaleValue() {
    if (_valueRating == 0) {
      return 1;
    }
    return _valueRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => _goBack(),
        ),
        centerTitle: true,
        title: Image(
          image: AssetImage(_pogoLogo),
          width: 150,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 20),
              child: SizedBox(
                child: AutoSizeText(
                  'Choose where you stand and how concerned you are with popular issues',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Color(0xFF0E0E0E),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //last card button
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: Visibility(
                    visible: _backVisibility,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            _checkRatings(context, "back");
                          },
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //issue card
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Card(
                    color: const Color(0xFFD9D9D9),
                    elevation: 10,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        //issue pic
                        Expanded(
                          flex: 31,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Stack(
                              children: [
                                //image
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  height:
                                  MediaQuery.of(context).size.height * 0.60 / 3,
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(3, 3),
                                      ),
                                    ],
                                  ),
                                  child: Image(
                                    image: AssetImage(
                                      _issueDefs.issuesLogo[_issueIndex],
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                //inkwell ripple effect when tapped
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      //toaster pull up for issues definitions
                                      showModalBottomSheet(
                                          context: context,
                                          clipBehavior: Clip.antiAlias,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                          ),
                                          isScrollControlled: true,
                                          backgroundColor: const Color(0xFFD9D9D9),
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height * 0.9,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  //white bar to indicate pulling up/down
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 13.0),
                                                    child: Container(
                                                      height: 7,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: const Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  //issue name
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                    child: Text(
                                                      _issueDefs.issuesText[_issueIndex],
                                                      style: const TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFF0E0E0E),
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: SingleChildScrollView(
                                                      physics: const BouncingScrollPhysics(),
                                                      child: Column(
                                                        children: [
                                                          //issue pic
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                            child: Container(
                                                              clipBehavior: Clip.hardEdge,
                                                              height:
                                                              MediaQuery.of(context).size.height * 0.60 / 2.5,
                                                              width: MediaQuery.of(context).size.width * 0.65,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.grey.shade600,
                                                                    spreadRadius: 3,
                                                                    blurRadius: 7,
                                                                    offset: const Offset(3, 3),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Image(
                                                                image: AssetImage(
                                                                  _issueDefs.issuesLogo[_issueIndex],
                                                                ),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                          //issue definition
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                                            child: Text(
                                                              _issueDefs.issuesGeneralDefinitions[_issueIndex],
                                                              style: const TextStyle(
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w500,
                                                                color: Color(0xFF121212),
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          //left align text
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                                                            child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                '• ${_issueDefs.leftAlignText[_issueIndex]}',
                                                                style: const TextStyle(
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Color(0xFF121212),
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          //left definition
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                                                            child: Text(
                                                              '▪ ${_issueDefs.issuesLeftDefinitions[_issueIndex]}',
                                                              style: const TextStyle(
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w500,
                                                                color: Color(0xFF121212),
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          //right align text
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(25, 10, 20, 0),
                                                            child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                '• ${_issueDefs.rightAlignText[_issueIndex]}',
                                                                style: const TextStyle(
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Color(0xFF121212),
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          //right definition
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(35, 10, 35, 20),
                                                            child: Text(
                                                              '▪ ${_issueDefs.issuesRightDefinitions[_issueIndex]}',
                                                              style: const TextStyle(
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w500,
                                                                color: Color(0xFF121212),
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //name of issue
                        Expanded(
                          flex: 6,
                          child: AutoSizeText(
                            _issueDefs.issuesText[_issueIndex],
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: Color(0xFF0E0E0E),
                            ),
                          ),
                        ),
                        //where do you align
                        const Expanded(
                          flex: 6,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: AutoSizeText(
                              'Where do you align?',
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xFF57636C),
                              ),
                            ),
                          ),
                        ),
                        //align slider
                        Expanded(
                          flex: 8,
                          child: Slider(
                            divisions: 4,
                            thumbColor: const Color(0xFFF3D433),
                            activeColor: const Color(0xFF0E0E0E),
                            inactiveColor: const Color(0xFF0E0E0E),
                            min: 1,
                            max: 5,
                            value: setInitialAlignScaleValue(),
                            onChangeEnd: (double value) {
                              _updateAlignRating(value);
                            },
                            onChanged: (double value) {},
                          ),
                        ),
                        //align slider text
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.65 /
                                      3,
                                  child: AutoSizeText(
                                    _issueDefs.leftAlignText[_issueIndex],
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.65 /
                                      2,
                                  child: AutoSizeText(
                                    _issueDefs.rightAlignText[_issueIndex],
                                    maxLines: 3,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //how much do you care
                        const Expanded(
                          flex: 6,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: AutoSizeText(
                              'How much do you care?',
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xFF57636C),
                              ),
                            ),
                          ),
                        ),
                        //care slider
                        Expanded(
                          flex: 8,
                          child: Slider(
                            divisions: 4,
                            thumbColor: const Color(0xFFF3D433),
                            activeColor: const Color(0xFF0E0E0E),
                            inactiveColor: const Color(0xFF0E0E0E),
                            min: 1,
                            max: 5,
                            value: setInitialCareScaleValue(),
                            onChangeEnd: (double value) {
                              _updateValueRating(value);
                            },
                            onChanged: (double value) {},
                          ),
                        ),
                        //care slider text
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              children: const [
                                Text(
                                  'Very Little',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                Spacer(),
                                Text('Extremely',
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //next card button
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: Visibility(
                    visible: _forwardVisibility,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            _checkRatings(context, "forward");
                          },
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //pogo/save changes button
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 20),
              child: Row(
                children: [
                  const Spacer(),
                  Visibility(
                    visible: _submitVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(_nextButtonColor),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            _endSurvey(context);
                          },
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                _submitButtonText,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0E0E0E),
                                  fontSize: _submitButtonTextSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
