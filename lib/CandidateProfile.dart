import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pogo/dynamoModels/Demographics/Education.dart';
import 'package:pogo/dynamoModels/Demographics/Position.dart';
import 'package:pogo/dynamoModels/IssueFactorValues/CandidateIssueFactorValues.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dynamoModels/Demographics/CandidateDemographics.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:share_plus/share_plus.dart';

class CandidateProfile extends StatefulWidget {
  final CandidateDemographics candidate;
  final CandidateIssueFactorValues candidateValues;
  final List<CandidateIssueFactorValues> candidateStackFactors;

  const CandidateProfile({
    Key? key,
    required this.candidate,
    required this.candidateValues,
    required this.candidateStackFactors,
  }) : super(key: key);

  @override
  State<CandidateProfile> createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  bool _isCardVisible = false;
  bool _showAllCardsEducation = false;
  bool _showAllCardsPreviousPositions = false;
   late List<CandidateIssueFactorValues> _stackFactors;
  bool _showAllCardsOtherExperience = false;
  var contactInfo = [];
  var socialMediaList = [];
  
  @override
  void initState() {
    setState(() {
      _stackFactors = widget.candidateStackFactors;
    });
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    mapData();
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

  void mapData() {
    contactInfo = [
      {
        'icon': 'assets/phone.png',
        'text': widget.candidate.phoneNumber,
      },
      {
        'icon': 'assets/phone2.png',
        'text': widget.candidate.homePhoneNumber,
      },
      {
        'icon': 'assets/email.png',
        'text': widget.candidate.email,
      },
      {
        'icon': 'assets/website.png',
        'text': widget.candidate.officialWebsiteURL,
      },
      {
        'icon': 'assets/office.png',
        'text': widget.candidate.addressLine1,
      },
    ];

    socialMediaList = [
      {
        'name': 'LinkedIn',
        'icon': 'assets/linkedin.png',
        'url': widget.candidate.linkedInURL
      },
      {
        'name': 'Facebook',
        'icon': 'assets/facebook.png',
        'url': 'https://www.facebook.com/GretchenWhitmer/'
      },
      {
        'name': 'Twitter',
        'icon': 'assets/twitter.png',
        'url': 'https://twitter.com/GovWhitmer'
      },
      {
        'name': 'Instagram',
        'icon': 'assets/instagram.png',
        'url': widget.candidate.instagramURL
      },
      {
        'name': 'TikTok',
        'icon': 'assets/tiktok.png',
        'url': widget.candidate.tiktokURL
      },
    ];
  }

  //returns the candidate's experience
 String _candidateExperience(String careerStartYear) {
    String experience = '';
    DateTime start = DateTime.parse(careerStartYear);
    DateTime currentDate = DateTime.now();
    int days = currentDate.difference(start).inDays;
    if (days > 364) {
      int years = days ~/ 365;
      //years
      experience = '$years';
    } else if (days > 29) {
      //months
      int months = days ~/ 30;
      experience = '$months';
    } else {
      experience = "$days";
    }
    return experience;
}
  //returns the candidate's current age 
String calculateAge(String dateOfBirth) {
  DateTime birthDate = DateTime.parse(dateOfBirth);
  DateTime currentDate = DateTime.now();
  int days = currentDate.difference(birthDate).inDays;
  if (days > 364) {
    int years = days ~/ 365;
    return '$years';
  } else if (days > 29) {
    int months = days ~/ 30;
    return '$months';
  } else {
    return "$days";
  }
}


String getBudgetString(String campaignBudgetString) {
  int campaignBudget = int.tryParse(campaignBudgetString) ?? 0;
  if (campaignBudget < 1000) {
    return '$campaignBudget';
  } else if (campaignBudget < 1000000) {
    return '${(campaignBudget / 1000).toStringAsFixed(1).replaceAll('.0', '')} Thousand';
  } else if (campaignBudget < 1000000000) {
    return '${(campaignBudget / 1000000).toStringAsFixed(1).replaceAll('.0', '')} Million';
  } else {
    return '${(campaignBudget / 1000000000).toStringAsFixed(1).replaceAll('.0', '')} Billion';
  }
}

String getDonorsString(String countOfDonorsString) {
  int countOfDonors = int.tryParse(countOfDonorsString) ?? 0;
  if (countOfDonors < 1000) {
    return '$countOfDonors';
  } else if (countOfDonors < 1000000) {
    return '${(countOfDonors / 1000).toStringAsFixed(1).replaceAll('.0', '')} Thousand';
  } else if (countOfDonors < 1000000000) {
    return '${(countOfDonors / 1000000).toStringAsFixed(1).replaceAll('.0', '')} Million';
  } else {
    return '${(countOfDonors / 1000000000).toStringAsFixed(1).replaceAll('.0', '')} Billion';
  }
}

  Widget _ratingCircles(num rating) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircularPercentIndicator(
          radius: 25,
          lineWidth: 6,
          progressColor: const Color(0xFFF3D433),
          backgroundColor: const Color(0xFF8B9DDE),
          percent: rating / 5,
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


Widget createIsssueCard(
  String titleText,
  String descriptionText,
  List<Widget> ratingCircles,
) {
  final double screenWidth = MediaQuery.of(context).size.width;

  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    shadowColor: Colors.black.withOpacity(0.95),
    color: Color(0xFFD9D9D9),
    child: SizedBox(
      height: 170,
      width: 400,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 400 ? 10 : 15,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    titleText,
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
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 240,
                    child: Text(
                      descriptionText,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Color(0xFF57636C),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 170 - 40, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ratingCircles,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
List<Widget> displayIssues() {
  // Retrieve the ratings for each issue and create a map with them
  Map<String, double> issueRatings = {
    'Climate': _stackFactors.first.climateScore.toDouble(),
    'Drug Policy': _stackFactors.first.drugPolicyScore.toDouble(),
    'Economy': _stackFactors.first.economyScore.toDouble(),
    'Education': _stackFactors.first.educationScore.toDouble(),
    'Gun Policy': _stackFactors.first.gunPolicyScore.toDouble(),
    'Healthcare': _stackFactors.first.healthcareScore.toDouble(),
    'Housing': _stackFactors.first.housingScore.toDouble(),
    'Immigration': _stackFactors.first.immigrationScore.toDouble(),
    'Policing': _stackFactors.first.policingScore.toDouble(),
    'Reproductive Rights': _stackFactors.first.reproductiveScore.toDouble(),
  };
   // Define the sides of the spectrum for each issue
  Map<String, List<String>> ratingSides = {
    'Climate': ['People in favor of climate policy are generally conservative in this area, preferring to ban economic activity that may create jobs but harm the environment. ',
     'Peoplee in the middle may support some degree of climate policy, recognizing the importance of protecting the environment while also considering the economic impact of environmental regulation. They may support measures to reduce carbon emissions but may not support a complete ban on economic activity that may harm the environment.', 
     'People who doubt climate policy don’t believe the climate is a threat to our environment. They are more permissive when weighing the economic impact of environmental regulation. People who doubt climate change believe the free market will find its own solution to environmental issues. '],
    'Drug Policy': ['People who favor legalization believe that drug policy should be less strict including decreasing the penalties or punishments associated with the drug. Many people believe in the decriminalization of marijuana ', 
    'People in the middle may support some degree of drug legalization, particularly for marijuana, while also recognizing the potential risks associated with drug use. They may believe that drug policy should balance individual liberty with public safety.', 
    'People who favor the criminalization of drugs believe that drug policy should be stricter including increasing the penalties or punishments associated with the drug. '],
    'Economy': ['People in favor of market regulation desire for the economy to be run by a cooperative collective agency, which can mean the state but also a network of communes',
     'People in the middle may support some level of market regulation while also recognizing the importance of individual entrepreneurship and the free market. They may believe that government intervention in the economy should be balanced with the need to promote economic growth and job creation.',
      'People in favor of market deregulation desire for the economy to be left to the devices of competing individuals and organizations. '],
    'Education': ['People in favor of public education believe every child in America, regardless of family income or place of residence, deserves access to a quality education. Including: expanded, free, public education including free college; student-loan forgiveness, teacher-pay raises, and universal pre-kindergarten', 
    'People in the middle may support public education and believe in expanding access to free, quality education for all children in America. They may also support some degree of school choice while also recognizing the importance of academic performance, free speech, and federal and state separation in education.', 
    'People in favor of school choice believe academic performance, free speech, and federal and state separation are essential to a good education. They believe “keeping Washington out of education” to ensure parents are in control of what their kids are learning in their districts. '],
    'Gun Policy': ['People in favor of gun control desire laws to be put in place such as background checks, wait times before buying a gun, banning automatic weapons, and disallowing concealed weapons ',
     ' People in the middle may support some level of gun control while also recognizing the importance of the Second Amendment and the right to bear arms. They may support background checks and waiting periods before purchasing guns but may not support a ban on all firearms.', 
     'People in favor of gun rights are strongly opposed to gun laws. Many are strong advocates of the second amendment [the right to bear arms], including “freedom to carry” for self-protection and relying on the state at little as possible. '],
    'Healthcare': ['People in favor of government-funded healthcare believe that access to healthcare is a fundamental right for all people. They support “Universal Healthcare”, “The Affordable Care Act”, and the expansion of Medicare and Medicaid. ', 
    'People in middle may support a mix of government-funded and private healthcare. They may believe that access to healthcare is a fundamental right for all people but may also recognize the benefits of competition and choice in the healthcare market.', 
    'People in favor of private healthcare believe there should be competition with Medicare from private insurance companies. They oppose “Universal Healthcare”, “The Affordable Care Act”, and Medicare expansion. '],
    'Housing': ['People in favor of Affordable housing believe that the government should support the creation of affordable housing and how it affects urban planning.',
     'People in the middle might believe in inding ways to promote affordable housing options while also respecting property rights and encouraging economic growth. This could also involve programs to assist low-income individuals and families in accessing safe and stable housing, while also encouraging the creation of new jobs and economic opportunities in underserved areas.', 
     'People in favor of Market rate housing believe that people should live where they can afford to and the government shouldn’t give tax breaks to support affordable housing. '],
    'Immigration': ['People in favor of inclusive immigration believe there should be pathways to citizenship for undocumented immigrants. Delay in deportations or prosecutions of undocumented immigrants who are young adults and have no criminal record. ', 
    'People in the middle may support some form of inclusive immigration policy while also recognizing the need for border security and a fair immigration process. They may support pathways to citizenship for undocumented immigrants while also acknowledging the impact that illegal immigration may have on wages and job opportunities for American citizens.', 
    'No “amnesty” for undocumented immigrants; stronger border patrol, etc. There’s a strong belief that illegal immigration is lowering the wages for citizens and documented immigrants. '],
    'Policing': ['People in favor of abolishing the police desire to reform the entire policing policy. They demand an entirely new public safety system based on social and economic equity, supported by a network of nonviolent emergency responders. They have a different view of what causes crime. In the world they imagine, America would spend much more on education, health care, and infrastructure, and nothing on police departments as we currently know them.', 
    'People in favor of Divestment and Reallocation advocate for investments made in supportive services and divestment from policing institutions. They believe that money is invested into minority communities to criminalize them instead of supporting them systematically. ',
     'People in favor of Investment advocate for more funding for training, weaponry, and local policing infrastructure. '],
    'Reproductive Rights': ['People in favor of “Pro-choice” generally believe in unpenalized access to abortion and both adult and embryonic stem cell research. They believe in “my body, my choice”. ', 
    'People in the middle might believe in finding a way to balance the right to access safe and legal abortion services with concerns about the potential harm to fetuses and the ethical implications of terminating a pregnancy. This could involve policies that promote education and access to contraception to reduce unintended pregnancies, while also providing support and resources for individuals who do choose to carry a pregnancy to term.', 
    'People in favor of abortion and contraceptive criminalization believe that people shouldn’t get abortions or use contraceptives no matter what. They believe that a baby is alive at the moment of conception. Abortions/abortion relation surgeries and contraceptives should be criminalized'],
  };
  // Sort the issues by rating in descending order
  List<MapEntry<String, double>> sortedIssues = issueRatings.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
  
  // Create a list of issue cards
  List<Widget> issueCards = [];
  
  // Add the first three issues without hiding them
  for (int i = 0; i < 3; i++) {
    String title = sortedIssues[i].key;
    double rating = sortedIssues[i].value;
    String ratingSideList = rating < 3 ? ratingSides[title]![0] : 
                            (rating == 3 ? ratingSides[title]![1] : ratingSides[title]![2]);
    List<Widget> ratingCircles = [_ratingCircles(rating.toInt())];
    issueCards.add(createIsssueCard(title, ratingSideList, ratingCircles));
  }
  
  // Add the rest of the issues with a visibility toggle
  List<Widget> hiddenCards = [];
  for (int i = 3; i < sortedIssues.length; i++) {
    String title = sortedIssues[i].key;
    double rating = sortedIssues[i].value;
    String ratingSideList = rating < 3 ? ratingSides[title]![0] : 
                            (rating == 3 ? ratingSides[title]![1] : ratingSides[title]![2]);
    List<Widget> ratingCircles = [_ratingCircles(rating.toInt())];
    hiddenCards.add(createIsssueCard(title, ratingSideList as String, ratingCircles));
  }
  
  // Add the "View More" or "View Less" button
  if (hiddenCards.isNotEmpty) {
  issueCards.add(TextButton(
    onPressed: () => setState(() => _isCardVisible = !_isCardVisible),
    child: Text(
      _isCardVisible ? 'View Less' : 'View More',
      style: TextStyle(
        color: Color(0xFF57636C),
      ),
    ),
  ));
}
  
  // Add the hidden cards if they're visible
  if (_isCardVisible && hiddenCards.isNotEmpty) {
    issueCards.addAll(hiddenCards);
  }
  
  // Return the list of issue cards
  return issueCards;
}


  Widget createEducationCard(
    String placeOfEducation,
    String degreeInformation,
    String yearOfGraduation,
  ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth <= 330 ? screenWidth * 0.8 : 180.0;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      shadowColor: Colors.black.withOpacity(0.95),
      color: Color(0xFFD9D9D9),
      child: SizedBox(
        height: 90,
        width: cardWidth,
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
                        placeOfEducation,
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
                            degreeInformation,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Color(0xFF57636C),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            yearOfGraduation,
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
    );
  }
List<Widget> createEducationCards(List<Education> educationList) {
  List<Widget> cards = [];
  for (int i = 0; i < educationList.length; i++) {
    Education education = educationList[i];
    String title = education.placeOfEducation;
    String subtitle1 = education.degreeInformation;
    String subtitle2 = education.yearOfGraduation;

    Widget card = createEducationCard(title, subtitle1, subtitle2);
    cards.add(card);
  }
  return cards;
}

  Widget createExperienceCard(
    String title,
    String subtitle1,
    String subtitle2,
  ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth <= 600 ? screenWidth * 0.7 : 150.0;
    return Card(
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
                        title,
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
                            subtitle1,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Color(0xFF57636C),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            subtitle2,
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
    );
  }


List<Widget> createPositionCards(List<Position> positionList) {
  List<Widget> cards = [];
  for (int i = 0; i < positionList.length; i++) {
    Position prevPositions = positionList[i];
    String title = prevPositions.title;
    String subtitle1 = prevPositions.organization;
    String subtitle2 = prevPositions.years;

    Widget card = createExperienceCard(title, subtitle1, subtitle2);
    cards.add(card);
  }
  return cards;
}

List<Widget> createPrePositionCards(List<Position> prevpositionList) {
  List<Widget> cards = [];
  for (int i = 0; i < prevpositionList.length; i++) {
    Position otherExperience = prevpositionList[i];
    String title = otherExperience.title;
    String subtitle1 = otherExperience.organization;
    String subtitle2 = otherExperience.years;

    Widget card = createExperienceCard(title, subtitle1, subtitle2);
    cards.add(card);
  }
  return cards;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F4F8),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0.0), 
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.candidate.profileImageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: Container(
                    height: 40,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 25,
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
                    height: 40,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await Share.share(
                          'Check out ${widget.candidate.candidateName}\'s profile on the PoGo app! Visit ${'https://www.politicsonthego.info/'} for more information.',
                          subject: 'Share Profile',
                          sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0),
                        );
                      },
                      child: Image.asset(
                        'assets/candidateProfileShare.png',
                        height: 8,
                        width: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(children: [
                SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFfF1F4F8),
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
                          '${widget.candidate.candidateName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${widget.candidate.runningPosition}  •  ${widget.candidate.city}',
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
                         
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: MediaQuery.of(context).size.width > 600 ? 20 : 10,
              ),
              decoration: BoxDecoration(
                color: Color(0xFfF1F4F8),
                borderRadius: BorderRadius.only(),
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
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.only(right: 250),
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
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                children: contactInfo
                                    .map((info) => Row(
                                          children: [
                                            Image.asset(
                                              info['icon'],
                                              width: 20,
                                              height: 25,
                                            ),
                                            SizedBox(width: 20),
                                            Text(
                                              info['text'],
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Color(0xFF57636C),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ),

                            SizedBox(height: 15),

Padding(
  padding: EdgeInsets.only(
    right: Platform.isIOS ? 130 : 0,
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (var socialMedia in socialMediaList)
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
            ),
            child: IconButton(
              icon: Image.asset(
                socialMedia['icon'] ?? 'assets/default.png',
                width: 25,
                height: 25,
              ),
              onPressed: () async {
                final url = socialMedia['url'];
                if (url != null) {
                  await launch(url, forceWebView: false);
                } else {
                  // Handle unsupported social media platforms
                }
              },
            ),
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
                                    height: 50,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 30, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                       Text(
  calculateAge(widget.candidate.dateOfBirth), // pass the date of birth as a string
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
                                    height: 50,
                                    width: 40,
                                    margin: EdgeInsets.only(
                                        top: 10, left: 30, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFD9D9D9),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                       Text(
  _candidateExperience(widget.candidate.careerStartYear),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Text(
                                widget.candidate.bodySummary,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ),
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
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 260),
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
                                  
                                  Column(
  children: displayIssues(),
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
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              Text(
                                                '~ Detroit Free Press',
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter',
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.underline,
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
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              Text(
                                                '~ Detroit Free Press',
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter',
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 85),
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 20, top: 20, bottom: 10),
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
  onTap: () {
    setState(() {
      _showAllCardsEducation = !_showAllCardsEducation;
    });
  },
  child: Padding(
    padding: EdgeInsets.only(left: 220, top: 20, bottom: 10),
    child: Text(
      _showAllCardsEducation ? "Hide" : "View all",
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
  child: Row(
    children: _showAllCardsEducation
      ? createEducationCards(widget.candidate.education)
      : createEducationCards(widget.candidate.education.take(3).toList()),
  ),
),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 0, top: 20, bottom: 10),
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
  onTap: () {
    setState(() {
      _showAllCardsPreviousPositions = !_showAllCardsPreviousPositions;
    });
  },
  child: Padding(
    padding: EdgeInsets.only(left: 183, top: 20, bottom: 10),
    child: Text(
      _showAllCardsPreviousPositions ? "Hide" : "View all",
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
  child: Row(
    children: _showAllCardsPreviousPositions
      ? createPositionCards(widget.candidate.prevPositions)
      : createPositionCards(widget.candidate.prevPositions.take(3).toList()),
  ),
),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 0, top: 20, bottom: 10),
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
  onTap: () {
    setState(() {
      _showAllCardsOtherExperience = !_showAllCardsOtherExperience;
    });
  },
  child: Padding(
    padding: EdgeInsets.only(left: 190, top: 20, bottom: 10),
    child: Text(
      _showAllCardsOtherExperience ? "Hide" : "View all",
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
  child: Row(
    children: _showAllCardsOtherExperience
      ? createPositionCards(widget.candidate.prevPositions)
      : createPositionCards(widget.candidate.prevPositions.take(3).toList()),
  ),
),
                       Padding(
  padding: EdgeInsets.symmetric(vertical: 20.0, ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Their campaign",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        textAlign: TextAlign.left,
      ),
      SizedBox(height: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image(
                image: AssetImage('assets/budget.png'),
                width: 35,
                height: 35,
              ),
              SizedBox(height: 5.0),
              Text(
                '\$' + getDonorsString(widget.candidate.countOfDonors),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5.0),
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
          Column(
            children: [
              Image(
                image: AssetImage('assets/contributers.png'),
                width: 35,
                height: 35,
              ),
              SizedBox(height: 5.0),
              Text(
                widget.candidate.countOfStaff,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 5.0),
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
          Column(
            children: [
              Image(
                image: AssetImage('assets/marketing.png'),
                width: 35,
                height: 35,
              ),
              SizedBox(height: 5.0),
              Text(
                '\$' + getBudgetString(widget.candidate.campaignBudget),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
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
    ],
  ),
),Padding(
  padding: EdgeInsets.only(bottom: 20, right: 155),
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
        "${widget.candidate.donors.join(', ')}",
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 12,
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
            )),
          ]))
        ]));
  }
}
