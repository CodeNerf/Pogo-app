import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pogo/amplifyFunctions.dart';
import '../HomeLoadingPage.dart';
import '../dynamoModels/UserDemographics.dart';
import '../awsFunctions.dart';
import '../dynamoModels/UserIssueFactorValues.dart';
import 'VoterInfo.dart';

class Issues extends StatefulWidget {
  final UserIssueFactorValues ratings;
  final UserDemographics answers;
  late final Widget nextPage = HomeLoadingPage(
    user: answers,
  );
  late final Widget lastPage = VoterInfo(
    ratings: ratings,
    answers: answers,
  );
  Issues({Key? key, required this.ratings, required this.answers})
      : super(key: key);

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  final List<String> _issuesLogo = [
    'assets/gunPolicyPogo.jpeg',
    'assets/climatePogo.jpg',
    'assets/educationPogo.jpeg',
    'assets/marijuana.png',
    'assets/healthcarePogo.jpg',
    'assets/housingPogo.jpg',
    'assets/economyPogo.jpg',
    'assets/immigrationPogo.jpg',
    'assets/policingPogo.jpg',
    'assets/reproductiveHealthPogo.jpg'
  ];
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
  int _nextButtonColor = 0xFF808080;
  final int _backgroundColor = 0xFFE1E1E1;
  double _alignRating = 0;
  double _valueRating = 0;
  final Color _ratingBarColor = Colors.black;
  final List<String> _leftAlignText = [
    'Gun Control',
    'Acceptance',
    'Public',
    'Legalization',
    'Government Funded',
    'Affordable Housing',
    'Market Regulation',
    'Inclusive',
    'Divestment and Reallocation',
    'Abortion + \nContraceptive Rights'
  ];
  final List<String> _rightAlignText = [
    'Gun Rights',
    'Doubt',
    'School Choice',
    'Criminalization',
    'Private',
    'Market Rate Housing',
    'Market Deregulation',
    'Exclusive',
    'Investment',
    'Abortion + \nContraceptive Restrictions'
  ];
  int _issueIndex = 0;
  String _buttonText = 'Next';

  @override
  void initState() {
    super.initState();
    _alignRating = widget.ratings.gunPolicyScore.toDouble();
    _valueRating = widget.ratings.gunPolicyWeight.toDouble();
    if (_alignRating > 0 && _valueRating > 0) {
      _nextButtonColor = 0xFFF3D433;
    } else {
      _nextButtonColor = 0xFF808080;
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
    if (_alignRating > 0 && _valueRating > 0) {
      _nextButtonColor = 0xFFF3D433;
    } else {
      _nextButtonColor = 0xFF808080;
    }
    setState(() {});
  }

  void _checkRatings(context) async {
    if (_alignRating > 0 && _valueRating > 0) {
      if (_issueIndex == _issuesLogo.length - 1) {
        //finished survey
        widget.answers.surveyCompletion = true;
        try {
          await Future.wait([
            putUserDemographics(widget.answers),
            putUserIssueFactorValues(widget.ratings),
            matchCandidatesToUser(widget.answers.userId),
          ]).then((List<dynamic> values) {
            safePrint(
                "UserDemographics and UserIssueFactorValues updated. Candidates matched.");
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
      } else {
        //load next issue
        if (_issueIndex == _issuesLogo.length - 2) {
          _buttonText = 'Submit';
        }
        _issueIndex++;
        _setRatings();
        _updateButton();
      }
    }
  }

  void _goBack() async {
    if (_issueIndex > 0) {
      //load previous issue
      if (_issueIndex == _issuesLogo.length - 1) {
        _buttonText = 'Next';
      }
      _issueIndex--;
      _setRatings();
      _updateButton();
    } else {
      //go to voter info page
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget.lastPage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(_backgroundColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        _goBack();
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
                            _pogoLogo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 210,
                      width: 300,
                      child: Image(
                        image: AssetImage(
                          _issuesLogo[_issueIndex],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      _issuesText[_issueIndex],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              //Align
              const Text(
                'How do you align?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              RatingBar(
                initialRating: _alignRating,
                itemCount: 5,
                direction: Axis.horizontal,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.square,
                    color: _ratingBarColor,
                  ),
                  empty: Icon(
                    Icons.square_outlined,
                    color: _ratingBarColor,
                  ),
                  half: Icon(
                    Icons.square_foot,
                    color: _ratingBarColor,
                  ),
                ),
                onRatingUpdate: (rating) {
                  _updateAlignRating(rating);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _leftAlignText[_issueIndex],
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(_rightAlignText[_issueIndex],
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
              //Value
              const SizedBox(height: 30),
              const Text(
                'How much do you care?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              RatingBar(
                initialRating: _valueRating,
                itemCount: 5,
                direction: Axis.horizontal,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.square,
                    color: _ratingBarColor,
                  ),
                  empty: Icon(
                    Icons.square_outlined,
                    color: _ratingBarColor,
                  ),
                  half: Icon(
                    Icons.square_foot,
                    color: _ratingBarColor,
                  ),
                ),
                onRatingUpdate: (rating) {
                  _updateValueRating(rating);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'A little',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text('A lot',
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
              //Next question button
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  _checkRatings(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(_nextButtonColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _buttonText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
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
