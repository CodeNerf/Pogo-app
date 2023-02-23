import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pogo/amplifyFunctions.dart';
import '../../UserIssuesFactors.dart';
import '../../HomeLoadingPage.dart';
import '../../UserDemographics.dart';
import 'Policing.dart';
import 'package:pogo/dataModelManipulation.dart';

class ReproductiveRights extends StatefulWidget {
  final UserIssuesFactors ratings;
  final UserDemographics answers;
  late final Widget nextPage = const HomeLoadingPage();
  late final Widget lastPage = Policing(ratings: ratings, answers: answers,);
  ReproductiveRights({Key? key, required this.ratings, required this.answers}) : super(key: key);

  @override
  State<ReproductiveRights> createState() => _ReproductiveRightsState();
}

class _ReproductiveRightsState extends State<ReproductiveRights> {
  String pogoLogo = 'assets/Pogo_logo_horizontal.png';
  String issuesLogo = 'assets/reproductiveHealthPogo.jpg';
  String issuesText = 'REPRODUCTIVE RIGHTS';
  String emptySquare = 'assets/yellowemptysquare.png';
  String yellowSquare = 'assets/yellowsquare.png';
  int nextButtonColor = 0xFF808080;
  int backgroundColor = 0xFFE1E1E1;
  double alignRating = 0;
  double valueRating = 0;
  Color ratingBarColor = Colors.black;
  String leftAlignText = 'Abortion + \nContraceptive Rights';
  String rightAlignText = 'Abortion + \nContraceptive Restrictions';


  @override
  void initState() {
    super.initState();
    setState(() {
      alignRating = widget.ratings.getReproductiveRightsAlign;
      valueRating = widget.ratings.getReproductiveRightsCare;
    });
    updateButton();
  }

  Future updateAlignRating(double rating) async {
    widget.ratings.setReproductiveRightsAlign = rating;
    alignRating = rating;
    updateButton();
  }

  Future updateValueRating(double rating) async {
    widget.ratings.setReproductiveRightsCare = rating;
    valueRating = rating;
    updateButton();
  }

  Future updateButton() async {
    if (alignRating > 0 && valueRating > 0) {
      setState(() {
        nextButtonColor = 0xFFF3D433;
      });
    }
    else {
      setState(() {
        nextButtonColor = 0xFF808080;
      });
    }
  }

  Future checkRatings(context) async {
    //TODO: this is the final survey page, issues and demographics object values have to be pushed to database here
    if (alignRating > 0 && valueRating > 0) {
      if(await updateSurveyCompletion()) {
        String email = await fetchCurrentUserEmail();
        updateUserIssueFactorValues(widget.ratings, email);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.nextPage,
          ),
        );
      }
      else {
        safePrint("Could not update survey completion");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
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
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widget.lastPage,
                          ),
                        );
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
                            pogoLogo,
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
                          issuesLogo,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      issuesText,
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
                initialRating: alignRating,
                itemCount: 5,
                direction: Axis.horizontal,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                  full:
                  Icon(
                    Icons.square,
                    color: ratingBarColor,
                  ),
                  empty:
                  Icon(
                    Icons.square_outlined,
                    color: ratingBarColor,
                  ),
                  half:
                  Icon(
                    Icons.square_foot,
                    color: ratingBarColor,
                  ),
                ),
                onRatingUpdate: (rating) {
                  updateAlignRating(rating);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    leftAlignText,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                      rightAlignText,
                      style: const TextStyle(
                        fontSize: 15,
                      )
                  ),
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
                initialRating: valueRating,
                itemCount: 5,
                direction: Axis.horizontal,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                  full:
                  Icon(
                    Icons.square,
                    color: ratingBarColor,
                  ),
                  empty:
                  Icon(
                    Icons.square_outlined,
                    color: ratingBarColor,
                  ),
                  half:
                  Icon(
                    Icons.square_foot,
                    color: ratingBarColor,
                  ),
                ),
                onRatingUpdate: (rating) {
                  updateValueRating(rating);
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
                  Text(
                      'A lot',
                      style: TextStyle(
                        fontSize: 15,
                      )
                  ),
                ],
              ),
              //Next question button
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  checkRatings(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(nextButtonColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Submit',
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
