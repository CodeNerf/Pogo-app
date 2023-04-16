import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pogo/dynamoModels/IssueFactorValues/CandidateIssueFactorValues.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dynamoModels/Demographics/CandidateDemographics.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:share_plus/share_plus.dart';

class CandidateProfile extends StatefulWidget {
  final CandidateDemographics candidate;
  final CandidateIssueFactorValues candidateValues;
  const CandidateProfile(
      {Key? key, required this.candidate, required this.candidateValues})
      : super(key: key);

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
  bool _showAllCardsOtherExperience = false;
  var contactInfo = [];
  var socialMediaList = [];
  @override
  void initState() {
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
        'url': widget.candidate.facebookURL
      },
      {
        'name': 'Twitter',
        'icon': 'assets/twitter.png',
        'url': widget.candidate.twitterURL
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
  String _candidateExperience(String careerStart) {
    print(careerStart);
    String experience = '';
    DateTime start = DateTime.parse(careerStart);
    DateTime currentDate = DateTime.now();
    int days = currentDate.difference(start).inDays;
    if (days > 364) {
      int years = days ~/ 365;
      //years
      experience = '$years years of experience';
    } else if (days > 29) {
      //months
      int months = days ~/ 30;
      experience = '$months months of experience';
    } else {
      experience = '$days days of experience';
    }
    return experience;
  }

  Widget getLogoForAffiliation(String party,
      {double width = 33, double height = 33}) {
    switch (party) {
      case 'Democrat':
        return Image.asset(
          'assets/democratLogo.png',
          width: width,
          height: height,
        );
      case 'Republican':
        return Image.asset(
          'assets/republicanLogo.png',
          width: width,
          height: height,
        );
      case 'Green':
        return Image.asset(
          'assets/greenLogo.png',
          width: width,
          height: height,
        );
      case 'Libertarian':
        return Image.asset(
          'assets/libertarianLogo.png',
          width: width,
          height: height,
        );
      default:
        return Image.asset(
          'assets/independentLogo.png',
          width: width,
          height: height,
        );
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
        height: 115,
        width: 400,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth < 400 ? 10 : 20,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: EdgeInsets.symmetric(vertical: 8.0),
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
                ],
              ),
              Row(
                children: ratingCircles,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createEducationCard(
    String title,
    String subtitle1,
    String subtitle2,
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
          )

          //   // const SizedBox(width: 10),
          //   Expanded(
          //     child: Align(
          //       alignment: Alignment.centerRight,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Text(
          //             widget.candidate.politicalAffiliation,
          //             style: const TextStyle(
          //               color: Color(0xFF2B49B4),
          //               fontFamily: 'Inter',
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16,
          //             ),
          //           ),
          //           const SizedBox(width: 40),
          //           getLogoForAffiliation(widget.candidate.politicalAffiliation),
          //         ],
          ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F4F8),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 16.0), // adjust the horizontal padding as needed
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/candidateImage.png'),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
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
                          '${widget.candidate.runningPosition}  •  Michigan',
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
                          getLogoForAffiliation(
                              widget.candidate.politicalAffiliation),
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
                              padding: EdgeInsets.only(right: 260, top: 20),
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

                            //social media icons
                            Padding(
                              padding: EdgeInsets.only(
                                right: Platform.isIOS
                                    ? 130
                                    : 0, // add padding only for iOS devices
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var socialMedia in socialMediaList)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFD9D9D9),
                                        ),
                                        child: IconButton(
                                          icon: Image.asset(
                                            socialMedia['icon'] ??
                                                'assets/default.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                          onPressed: () {
                                            switch (socialMedia['name']) {
                                              case 'LinkedIn':
                                                LaunchApp.openApp(
                                                  androidPackageName:
                                                      'com.linkedin.android',
                                                  iosUrlScheme:
                                                      'https://www.linkedin.com/',
                                                );
                                                break;
                                              case 'Facebook':
                                                LaunchApp.openApp(
                                                  androidPackageName:
                                                      'com.facebook.katana',
                                                  iosUrlScheme:
                                                      'https://www.facebook.com/GovGretchenWhitmer',
                                                );
                                                break;
                                              case 'Twitter':
                                                LaunchApp.openApp(
                                                  androidPackageName:
                                                      'com.twitter.android',
                                                  iosUrlScheme:
                                                      'https://twitter.com/GovWhitmer?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor',
                                                );
                                                break;
                                              case 'Instagram':
                                                LaunchApp.openApp(
                                                  androidPackageName:
                                                      'com.instagram.android',
                                                  iosUrlScheme:
                                                      'https://www.instagram.com/whitmermi/channel/',
                                                );
                                                break;
                                              case 'TikTok':
                                                LaunchApp.openApp(
                                                  androidPackageName:
                                                      'com.zhiliaoapp.musically',
                                                  iosUrlScheme:
                                                      'https://www.tiktok.com/@biggretchwhitmer?lang=en',
                                                );
                                                break;
                                              default:
                                                // Handle unsupported social media platforms
                                                break;
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
                                    height: 40,
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
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
                                  createIsssueCard(
                                    "Gun Control",
                                    "Proponents of public education believe every child in \nAmerica, regardless of family income or place of \nresidence, deserves access to a quality education.",
                                    [
                                      _ratingCircles(widget
                                          .candidateValues.educationScore),
                                    ],
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
                                            _isCardVisible
                                                ? "View less"
                                                : "View more",
                                            style: TextStyle(
                                                color: Color(0xFF57636C)),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _isCardVisible,
                                        child: Column(
                                          children: [],
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
                                  _showAllCardsEducation =
                                      !_showAllCardsEducation;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 220, top: 20, bottom: 10),
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
                            children: [
                              createEducationCard(
                                "Michigan State University College of Law",
                                "Doctor of Law - JD, Law",
                                "1998",
                              ),
                              SizedBox(width: 15),
                              createEducationCard(
                                "Michigan State University",
                                "Bachelors of Art, Marketing/Communications",
                                "1989-93",
                              ),
                              SizedBox(width: 15),
                              if (_showAllCardsEducation)
                                Row(
                                  children: [
                                    createEducationCard(
                                      "More",
                                      "More",
                                      "More",
                                    ),
                                  ],
                                ),
                            ],
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
                                  _showAllCardsPreviousPositions =
                                      !_showAllCardsPreviousPositions;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 180, top: 20, bottom: 10),
                                child: Text(
                                  _showAllCardsPreviousPositions
                                      ? "Hide"
                                      : "View all",
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
                            children: [
                              createExperienceCard(
                                "Governor",
                                "State of Michigan",
                                "2019 - Present",
                              ),
                              SizedBox(width: 5),
                              createExperienceCard(
                                "Senate Democratic Leader",
                                "Michigan State Senate",
                                "2010 - 2014",
                              ),
                              SizedBox(width: 5),
                              createExperienceCard(
                                "Senator",
                                "Michigan State Senate",
                                "2006 - 2014",
                              ),
                              SizedBox(width: 5),
                              if (_showAllCardsPreviousPositions)
                                createExperienceCard(
                                  "More",
                                  "More",
                                  "More",
                                ),
                            ],
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
                                  _showAllCardsOtherExperience =
                                      !_showAllCardsOtherExperience;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 190, top: 20, bottom: 10),
                                child: Text(
                                  _showAllCardsOtherExperience
                                      ? "Hide"
                                      : "View all",
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
                            children: [
                              createExperienceCard(
                                "Ingham County Prosecutor",
                                "Ingham County",
                                "2016",
                              ),
                              SizedBox(width: 5),
                              createExperienceCard(
                                "Towsley Policy Maker in Residence",
                                "University of Michigan",
                                "2015 - 2016",
                              ),
                              SizedBox(width: 5),
                              createExperienceCard(
                                "Of Counsel",
                                "Dickinson Wright PLLC",
                                "2015 - 2016",
                              ),
                              SizedBox(width: 5),
                              if (_showAllCardsOtherExperience)
                                createExperienceCard(
                                  "More",
                                  "More",
                                  "More",
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: 255, top: 20, bottom: 10),
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
                                    image:
                                        AssetImage('assets/contributers.png'),
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
                          padding:
                              EdgeInsets.only(left: 20, top: 40, bottom: 40),
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
            )),
          ]))
        ]));
  }
}
