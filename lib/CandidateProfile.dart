import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pogo/dynamoModels/CandidateIssueFactorValues.dart';
import 'dynamoModels/CandidateDemographics.dart';

class CandidateProfile extends StatefulWidget {
  final CandidateDemographics candidate;
  final CandidateIssueFactorValues candidateValues;
  const CandidateProfile({Key? key, required this.candidate, required this.candidateValues}) : super(key: key);

  @override
  State<CandidateProfile> createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
bool _isCardVisible = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
 bool _showAllCards = false;

  void _toggleShowAllCards() {
    setState(() {
      _showAllCards = !_showAllCards;
    });
  }
  




   //returns the candidate's experience
  String _candidateExperience(String careerStart) {
    print(careerStart);
    String experience = '';
    DateTime start = DateTime.parse(careerStart);
    DateTime currentDate = DateTime.now();
    int days = currentDate.difference(start).inDays;
    if(days > 364) {
      int years = days ~/ 365;
      //years
      experience = '$years years of experience';
    }
    else if(days > 29) {
      //months
      int months = days ~/ 30;
      experience = '$months months of experience';
    }
    else {
      experience = '$days days of experience';
    }
    return experience;
  }

 Color _candidateColor(String party) {
    switch (party) {
      case 'Democrat':
        return const Color(0xFF3456CF);
      case 'Republican':
        return const Color(0xFFDE0100);
      case 'Libertarian':
        return const Color(0xFFFFD100);
      case 'Green':
        return const Color(0xFF508C1B);
    }
    return const Color(0xFFF9F9F9);
  }
  
  Widget getLogoForAffiliation(String party, {double width = 33, double height = 33}) {
  switch (party) {
    case 'democrat':
      return Image.asset(
        'assets/democratLogo.png',
        width: width,
        height: height,
      );
    case 'republican':
      return Image.asset(
        'assets/republicanLogo.png',
        width: width,
        height: height,
      );
    case 'independent':
      return Image.asset(
        'assets/independentLogo.png',
        width: width,
        height: height,
      );
    
    default:
      return Image.asset(
        'assets/democratLogo.png',
        width: width,
        height: height,
      );
  }}

  // List<Widget> _getRatingCircles() {
  //   List<Widget> circles = [];
  //   circles.add(Column(children: [_ratingCircles('\n', widget.candidateValues.educationScore), _ratingCircles('Care', widget.candidateValues.educationWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Climate\n', widget.candidateValues.climateScore), _ratingCircles('Care', widget.candidateValues.climateWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Drug Policy\n', widget.candidateValues.drugPolicyScore), _ratingCircles('Care', widget.candidateValues.drugPolicyWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Economy\n', widget.candidateValues.economyScore), _ratingCircles('Care', widget.candidateValues.economyWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Healthcare\n', widget.candidateValues.healthcareScore), _ratingCircles('Care', widget.candidateValues.healthcareWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Immigration\n', widget.candidateValues.immigrationScore), _ratingCircles('Care', widget.candidateValues.immigrationWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Policing\n', widget.candidateValues.policingScore), _ratingCircles('Care', widget.candidateValues.policingWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Reproductive\nHealth', widget.candidateValues.reproductiveScore), _ratingCircles('Care', widget.candidateValues.reproductiveWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Gun Control\n', widget.candidateValues.gunPolicyScore), _ratingCircles('Care', widget.candidateValues.gunPolicyWeight)],));
  //   circles.add(Column(children: [_ratingCircles('Housing\n', widget.candidateValues.housingScore), _ratingCircles('Care', widget.candidateValues.housingWeight)],));
  //   return circles;
  // }


Widget _ratingCircles(num rating) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: CircularPercentIndicator(
        radius: 25,
        lineWidth: 6,
        progressColor: const Color(0xFFF3D433),
        backgroundColor: const Color(0xFF8B9DDE),
           
        // footer: Text(
        //   name,
        //   textAlign: TextAlign.center,
        //   style: const TextStyle(
        //     fontSize: 12,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        percent: rating/5,
        center: Text(
          '$rating/5',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
@override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFF1F4F8),

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   centerTitle: true,
      //   title: Image(
      //     image: AssetImage(_pogoLogo),
      //     width: 150,
      //   ),
      // ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
    Stack(
  children: [
    Container(
      width: 440,
      height: 350,
      child: Image.asset(
        'assets/candidateImage.png',
        fit: BoxFit.fill,
      ),
    ),
    Positioned(
      top: 30,
      left: 30,
      child: Container(
        height:40,
        width: 45,
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ),
    Positioned(
      top: 30,
      right: 30,
      child: Container(
        height:40,
        width: 45,
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: IconButton(
          icon: Icon(Icons.share_outlined),
          iconSize: 20,
          onPressed: () {
            // Add your share button logic here
          },
        ),
      ),
    ),
  ],
),
        Expanded(
          child: Column(
           
            children: [
              Container(
  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),

  decoration: BoxDecoration(
    color:  Color(0xFfF1F4F8),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
  ),
  child: Row(
    
   // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.candidate.firstName} ${widget.candidate.lastName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
                  const SizedBox(height: 10),

            Text(
                '${widget.candidate.seatType}  •  Michigan',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF57636C),
                ),
              ),
          ],
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
  widget.candidate.politicalAffiliation,
  style: const TextStyle(
    color: Color(0xFF2B49B4),
    fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),

              const SizedBox(width: 40),
                      getLogoForAffiliation(widget.candidate.politicalAffiliation),

            ],
          ),
        ),
      ),
    ],
  ),
),
             Container(
  padding: const EdgeInsets.only(right: 20, left: 10),
  decoration: BoxDecoration(
    color:  Color(0xFfF1F4F8),
    borderRadius: BorderRadius.only(
    ),
  ),
  child: TabBar(
  controller: _tabController,
  indicatorSize: TabBarIndicatorSize.label,
  labelColor: Colors.black,
  unselectedLabelColor: Colors.grey,
  indicatorColor: Color(0xFFF3D433),
  tabs: [
    Tab(
      child: Text(
        'Summary',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Views',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19.0,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Experience',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19.0,
        ),
      ),
    ),
  ],
  indicatorPadding: EdgeInsets.zero,
),
),
Expanded(
  child: TabBarView(
  controller: _tabController,
  children: [
    // First tab content
  SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Align(
  alignment: Alignment.topLeft,
  child: Column(
    children: [
    Padding(
  padding: EdgeInsets.only(right: 260, top:20),
  child: Text(
  "Contact Info",
  style: TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: 15,
  ),
  textAlign: TextAlign.left,
),
),

      SizedBox(height: 15),
      Padding(
  padding: EdgeInsets.only(left:20), 
  child: Column(
    children: [
      Row(
        children: [
          Image.asset(
            'assets/phone.png',
            width: 20,
            height: 25,
          ),
          SizedBox(width: 20),
          Text(
  "(517) 373-3400",
  style: TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500, 
    fontSize: 15,
    color: Color(0xFF57636C)
  ),
  textAlign: TextAlign.left,
),
        ],
      ),
      SizedBox(height: 5),
      Row(
        children: [
          Image.asset(
            'assets/phone2.png',
            width: 20,
            height: 20,
          ),
          SizedBox(width: 20),
          Text(
            "(517) 335-7858",
            style: TextStyle(
              fontFamily: 'Inter',
    fontWeight: FontWeight.w500, 
              fontSize: 15,
              color: Color(0xFF57636C)
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      SizedBox(height: 5),
      Row(
        children: [
          Image.asset(
            'assets/email.png',
            width: 20,
            height: 20,
          ),
          SizedBox(width: 20),
          Text(
            "info@gretchenwhitmer.com",
            style: TextStyle(
              fontFamily: 'Inter',
    fontWeight: FontWeight.w500, 
              fontSize: 15,
              color: Color(0xFF57636C)
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      SizedBox(height: 5),
      Row(
        children: [
          Image.asset(
            'assets/website.png',
            width: 20,
            height: 20,
          ),
          SizedBox(width: 20),
          Text(
            "www.michigan.gov/whitmer",
            style: TextStyle(
              fontFamily: 'Inter',
    fontWeight: FontWeight.w500, 
              fontSize: 15,
              color: Color(0xFF57636C)
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      SizedBox(height: 5),
      Row(
        children: [
          Image.asset(
            'assets/office.png',
            width: 20,
            height: 20,
          ),
          SizedBox(width: 20),
          Text(
            
            "Post Office, Lansing MI 48909",
            style: TextStyle(
              fontFamily: 'Inter',
    fontWeight: FontWeight.w500, 
              fontSize: 15,
              color: Color(0xFF57636C)
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ],
  ),
),
      
      SizedBox(height: 15),

        //social media icons
        Padding(
          padding: EdgeInsets.only(right: 130),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
                child: IconButton(
                  icon: Image.asset('assets/linkedin.png', width: 15, height: 15,),
                  onPressed: () {
                    // Add icon onTap functionality
                  },
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
                child: IconButton(
                  icon: Image.asset('assets/facebook.png', width: 15, height: 15,),
                  onPressed: () {
                    // Add icon onTap functionality
                  },
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
                child: IconButton(
                  icon: Image.asset('assets/twitter.png', width: 15, height: 15,),
                  onPressed: () {
                    // Add icon onTap functionality
                  },
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
                child: IconButton(
                  icon: Image.asset('assets/instagram.png', width: 15, height: 15,),
                  onPressed: () {
                    // Add icon onTap functionality
                  },
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
                child: IconButton(
                  icon: Image.asset('assets/tiktok.png', width: 15, height: 15,),
                  onPressed: () {
                    // Add icon onTap functionality
                  },
                ),
              ),
            ],
          ),
        ),
         Padding(
  padding: EdgeInsets.only(right: 260, top: 30),
  child: Text(
    "Biography",
    style: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    textAlign: TextAlign.left,
  ),
),
Row(
  children: [
    Expanded(
      child: Container(
        height: 40,
        margin: EdgeInsets.only(top: 10, left: 30, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFD9D9D9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "61",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "years old",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),

    Expanded(
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.only(top: 10, left: 30, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFD9D9D9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "20",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "years of \nexperience",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
Padding(
 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Text(
        'Lorem ipsum dolor sit amet. Eum quia saepe aut sint fugit ut nihil sunt quo placeat voluptatem non sunt veritatis est doloribus mollitia. Ex possimus quam ut perspiciatis reprehenderit est sunt consequuntur in obcaecati voluptas et necessitatibus quos. Et maxime voluptatum et omnis delectus et enim quas et libero animi eum rerum suscipit a perspiciatis velit ut voluptatem officia. Et nulla incidunt ab dolor magni sit quae voluptatem aut omnis enim rem necessitatibus alias non reprehenderit dolor vel laudantium quia.Qui officiis asperiores aut doloribus deleniti sit incidunt enim At accusantium deserunt et vero modi? Est distinctio internos et asperiores explicabo id vitae laborum et dolor error eos pariatur nesciunt et nulla quia aut eius autem. At laboriosam repudiandae ut consequatur reprehenderit aut repellat nisi cum aperiam architecto a molestias fugit. Aut tenetur recusandae a vero enim quo nihil laboriosam. Ut iusto labore qui galisum autem et nisi nesciunt qui voluptatem galisum qui voluptatibus maiores.',
        style: TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
      ),),
        ]),
),
        ],
        
      ),
    ),
  ),
    // Second tab content (Experience)
    SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal:30),
    child: Column(
      children: [
    Padding(
  padding: EdgeInsets.only(right: 265),
  child: Text(
    "Top 3 Issues",
    style: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    textAlign: TextAlign.left,
  ),
),
 const SizedBox(height: 10),
      const Text(
        "View this candidate’s stance on popular issues below. Ratings are on a 0-5 scale, 0 and 5 representing opposing sides of the issue spectrum. ",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color(0xFF57636C),
        ),
        textAlign: TextAlign.left,
      ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
  Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
  shadowColor: Colors.black.withOpacity(0.95),
      color: Color(0xFFD9D9D9),

  child: SizedBox(
    height: 115,
    width: 400,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: const Text(
        "Public Education",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: const Text(
        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 10,
          color: Color(0xFF57636C),
        ),
        textAlign: TextAlign.left,
      ),
    ),
  ],
),
          _ratingCircles( widget.candidateValues.educationScore),
        ],
      ),
    ),
  ),
),

Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
  shadowColor: Colors.black.withOpacity(0.95),
      color: Color(0xFFD9D9D9),

  child: SizedBox(
    height: 115,
    width: 400,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: const Text(
        "Gun Control",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: const Text(
        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education.",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 10,
          color: Color(0xFF57636C),
        ),
        textAlign: TextAlign.left,
      ),
    ),
  ],
),
          _ratingCircles( widget.candidateValues.educationScore),
        ],
      ),
    ),
  ),
),
Card(
  elevation: 3,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
  shadowColor: Colors.black.withOpacity(0.95),
      color: Color(0xFFD9D9D9),

  child: SizedBox(
    height: 115,
    width: 400,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: const Text(
        "Drug Legalization",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: const Text(
        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 10,
          color: Color(0xFF57636C),
        ),
        textAlign: TextAlign.left,
      ),
    ),
  ],
),
          _ratingCircles( widget.candidateValues.educationScore),
        ],
      ),
    ),
  ),
),

Column(
  children: [
    Center(
      child: TextButton(
        onPressed: () {
          setState(() {
            _isCardVisible = !_isCardVisible;
          });
        },
        child: Text(
          _isCardVisible ? "View less" : "View more",
          style: TextStyle(color: Color(0xFF57636C)),
        ),
      ),
    ),
Visibility(
  visible: _isCardVisible,
  child: Column(
    children: [
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black.withOpacity(0.95),
        color: Color(0xFFD9D9D9),
        child: SizedBox(
          height: 115,
          width: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: const Text(
                        "Public Education",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Color(0xFF57636C),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                _ratingCircles(widget.candidateValues.educationScore),
              ],
            ),
          ),
        ),
      ),
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black.withOpacity(0.95),
        color: Color(0xFFD9D9D9),
        child: SizedBox(
          height: 115,
          width: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: const Text(
                        "Public Education",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Color(0xFF57636C),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                _ratingCircles(widget.candidateValues.educationScore),
              ],
            ),
          ),
        ),
      ),
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black.withOpacity(0.95),
        color: Color(0xFFD9D9D9),
        child: SizedBox(
          height: 115,
          width: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: const Text(
                        "Public Education",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Color(0xFF57636C),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                _ratingCircles(widget.candidateValues.educationScore),
              ],
            ),
          ),
        ),
      ),

      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black.withOpacity(0.95),
        color: Color(0xFFD9D9D9),
        child: SizedBox(
          height: 115,
          width: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: const Text(
                        "Public Education",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Color(0xFF57636C),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                _ratingCircles(widget.candidateValues.educationScore),
              ],
            ),
          ),
        ),
      ),
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black.withOpacity(0.95),
        color: Color(0xFFD9D9D9),
        child: SizedBox(
          height: 115,
          width: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: const Text(
                        "Public Education",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Color(0xFF57636C),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                _ratingCircles(widget.candidateValues.educationScore),
              ],
            ),
          ),
        ),
      ),
      Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black.withOpacity(0.95),
        color: Color(0xFFD9D9D9),
        child: SizedBox(
          height: 115,
          width: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: const Text(
                        "Public Education",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Color(0xFF57636C),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                _ratingCircles(widget.candidateValues.educationScore),
              ],
            ),
          ),
        ),
      ),
     Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.black.withOpacity(0.95),
        color: Color(0xFFD9D9D9),
        child: SizedBox(
          height: 115,
          width: 400,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: const Text(
                        "Public Education",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: const Text(
                        "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education. ",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: Color(0xFF57636C),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                _ratingCircles(widget.candidateValues.educationScore),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
),
  ],
),
              const SizedBox(height: 25),

    Padding(
  padding: EdgeInsets.only(right: 265),
  child: Text(
    "Top Stories",
    style: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    textAlign: TextAlign.left,
  ),
  
),

const SizedBox(height: 15),
Row(
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '“Gov. Whitmer signs bill expanding Michigan civil rights law to include LGBTQ protections”',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600, 
                fontFamily: 'Inter', 
                color: Color(0xFF57636C),
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              '~ Detroit Free Press',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w600, 
                fontFamily: 'Inter', 
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    ),
     Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '“How the repeal of Michigans right-to-work laws could impact Michiganders”',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600, 
                fontFamily: 'Inter', 
                               color: Color(0xFF57636C),
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              '~ Detroit Free Press',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w600, 
                fontFamily: 'Inter', 
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
const SizedBox(height: 25),
 Padding(
  padding: EdgeInsets.only(right: 235),
  child: Text(
    "Voting History",
    style: TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    textAlign: TextAlign.left,
  ),
  
),
   const SizedBox(height: 25),
             ],
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child:  Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20, top: 20, bottom: 10),
              child: Text(
                "Education",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            GestureDetector(
              onTap: _toggleShowAllCards,
              child: Padding(
                padding: EdgeInsets.only(left: 220, top: 20, bottom: 10),
                child: Text(
                  _showAllCards ? "Hide" : "View all",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
SingleChildScrollView(
          scrollDirection: Axis.horizontal,
  physics: BouncingScrollPhysics(),
  child:Row(
          children:[
          Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 170,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Michigan State University College of Law",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Doctor of Law - JD, Law",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "1998",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 170,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Michigan State University",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bachelors of Art, Marketing/Communications",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "1998",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showAllCards)
          Row(
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 170,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Michigan State University College of Law",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Doctor of Law - JD, Law",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "1998",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             
            ],)]),
  
        ),
         Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20, top: 20, bottom: 10),
              child: Text(
                "Previous Positions",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            GestureDetector(
              onTap: _toggleShowAllCards,
              child: Padding(
                padding: EdgeInsets.only(left: 160, top: 20, bottom: 10),
                child: Text(
                  _showAllCards ? "Hide" : "View all",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        
SingleChildScrollView(
          scrollDirection: Axis.horizontal,
  physics: BouncingScrollPhysics(),
  child:Row(
          children:[
          Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 140,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Governor",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "State of Michigan",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "2019 - Present",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 150,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Senate Democratic  Leader",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Michigan State Senate",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "2010 - 2014",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showAllCards)
          Row(
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 150,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Senator",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Michigan State Senate",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "2006 - 2014",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             
            ],)]),
  
        ),

        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20, top: 20, bottom: 10),
              child: Text(
                "Other Experience",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            GestureDetector(
              onTap: _toggleShowAllCards,
              child: Padding(
                padding: EdgeInsets.only(left: 170, top: 20, bottom: 10),
                child: Text(
                  _showAllCards ? "Hide" : "View all",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),

SingleChildScrollView(
          scrollDirection: Axis.horizontal,
  physics: BouncingScrollPhysics(),
  child:Row(
          children:[
          Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 150,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Ingham County Prosecutor",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ingham County",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "2016",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 150,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Towsley Policy Maker in Residence",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "University of Michigan",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "2015 - 2016",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_showAllCards)
          Row(
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black.withOpacity(0.95),
                color: Color(0xFFD9D9D9),
                child: SizedBox(
                  height: 90,
                  width: 150,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0),
                                child: Text(
                                  "Of Counsel",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dickinson Wright PLLC",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "2015 - 2016",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Color(0xFF57636C),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             
            ],)]),
  
        ),
Padding(
              padding: EdgeInsets.only(right: 255, top: 20, bottom: 10),
              child: Text(
                "Their campaign",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25.0),
  child: Row(
    children: [
      Column(
        children: [
          Image(
            image: AssetImage('assets/budget.png'),
            width: 35,
            height: 35,
          ),
          const SizedBox(height: 5.0),
          Text(
            '\$14 Million',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            'Contributors',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: "Inter",
            ),
          ),
        ],
      ),
      const SizedBox(width: 20.0),
      Column(
        children: [
          Image(
            image: AssetImage('assets/contributers.png'),
            width: 35,
            height: 35,
          ),
          const SizedBox(height: 5.0),
          Text(
            '32',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            'Staff members',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: "Inter",
            ),
          ),
        ],
      ),
      const SizedBox(width: 20.0),
      Column(
        children: [
          Image(
            image: AssetImage('assets/marketing.png'),
            width: 35,
            height: 35,
          ),
          const SizedBox(height: 5.0),
          Text(
            '\$14 Million',
            style: TextStyle(
              fontSize: 15,
              fontFamily: "Inter",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            'Campaign Budget',
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Inter",
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  ),
),
Padding(
  padding: EdgeInsets.only(left: 20, top: 40, bottom: 40),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Additional donations include:",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        textAlign: TextAlign.left,
      ),
      Text(
        "Service Employees International Union, Iron Workers Local 25 PAC, and General Motors PAC",
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 10,
        ),
        textAlign: TextAlign.left,
      ),
    ],
  ),
),
        ],
        
    ),
    
      ),
    ),
  ],
)

),
]
)
)
]
)
);
}
}