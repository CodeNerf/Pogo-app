import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../LoginPage.dart';
import 'Climate.dart';

class GunPolicy extends StatefulWidget {
  const GunPolicy({Key? key}) : super(key: key);

  @override
  State<GunPolicy> createState() => _GunPolicyState();
}

class _GunPolicyState extends State<GunPolicy> {
  String pogoLogo = 'assets/Pogo_logo_horizontal.png';
  String issuesLogo = 'assets/gunPolicyPogo.jpeg';
  String issuesText = 'GUN POLICY';
  String emptySquare = 'assets/yellowemptysquare.png';
  String yellowSquare = 'assets/yellowsquare.png';
  int nextButtonColor = 0xFF808080;
  int backgroundColor = 0xFFE1E1E1;
  double alignRating = 0;
  double valueRating = 0;
  final Widget nextPage = const Climate();
  final Widget lastPage = const LoginPage();
  int ratingBarColor = 0xFFF3D433;
  String leftAlignText = 'Gun Control';
  String rightAlignText = 'Gun Rights';

  Future checkRatings() async {
    if (alignRating > 0 && valueRating > 0) {
      //TODO: SAVE RATING VALUES
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => nextPage,
        ),
      );
    }
  }
  Future changeNextButtonColor() async {
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
                              builder: (context) => lastPage,
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
                          fontSize: 30,
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
                    initialRating: 0,
                    itemCount: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    ratingWidget: RatingWidget(
                      full:
                        Icon(
                          Icons.square,
                          color: Color(ratingBarColor),
                        ),
                      empty:
                        Icon(
                          Icons.square_outlined,
                          color: Color(ratingBarColor),
                        ),
                      half:
                        Icon(
                          Icons.square_foot,
                          color: Color(ratingBarColor),
                        ),
                    ),
                  onRatingUpdate: (rating) {
                    alignRating = rating;
                    changeNextButtonColor();
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
                  initialRating: 0,
                  itemCount: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  ratingWidget: RatingWidget(
                    full:
                    Icon(
                      Icons.square,
                      color: Color(ratingBarColor),
                    ),
                    empty:
                    Icon(
                      Icons.square_outlined,
                      color: Color(ratingBarColor),
                    ),
                    half:
                    Icon(
                      Icons.square_foot,
                      color: Color(ratingBarColor),
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    valueRating = rating;
                    changeNextButtonColor();
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
                    checkRatings();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(nextButtonColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Next',
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
