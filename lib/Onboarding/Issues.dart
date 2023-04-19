import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  //TODO: fix text align/size in card

  FixedExtentScrollController _extentScrollController =
      FixedExtentScrollController();

  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  late int _issueIndex;
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
  int _nextButtonColor = 0xFFF3D433;
  final int _backgroundColor = 0xFFE1E1E1;
  double _alignRating = 0;
  double _valueRating = 0;
  late bool _backVisibility;
  late bool _forwardVisibility;
  final Color _ratingBarColor = Colors.black;
  bool _submitVisibility = false;
  late String _submitButtonText;
  late double _submitButtonTextSize;

  final List<String> _leftAlignText = [
    'Gun Control',
    'Acceptance',
    'Public',
    'Legalization',
    'Government Funded',
    'Affordable Housing',
    'Market Regulation',
    'Inclusive',
    'Divestment & Reallocation',
    'Abortion & Contraceptive Rights'
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
    'Abortion & Contraceptive Restrictions'
  ];
  final List<String> _issuesGeneralDefinitions = [
    'Gun policy refers to the laws and protections in place around firearms. Concerning the possession, transfer, or sale of firearms or the expansion of background checks for firearm purchases.',
    'Climate policy refers to rules to regulate innovation that affects the environment and the greater human race.',
    'Education policy refers to the plan and underlying principles for educating students. The goals of educational policy have evolved in the United States as society and culture have changed, and are continually being debated and revised.',
    'Drug policy refers to rules around the consumption, selling/and or purchasing of drugs or alcohol.',
    'Healthcare policy refers to the concerns people have when it comes to “health freedom” / the freedom to choose. Some people believe that health and medical systems are heavily influenced by big government or pharmaceutical money therefore they want the space to self-determine and choose for oneself one’s course of treatment and approach to health overall.',
    'Housing policy refers to the actions of the government, including legislation and program delivery, which have a direct or indirect impact on housing supply and availability, housing standards and urban planning.',
    'Economic Policy refers to the systems for managing taxation, government budgets, the money supply and interest rates as well as the labor market, national ownership, and many other areas of government interventions into the economy.',
    'Immigration policy refers to laws that control, protect, and manage the influx of people seeking to establish residence in the USA. It is rules regarding rights of access to the territory (entry and residence), permission to participate in the labor market (work permits), the rights of asylum seekers and refugees, the rights of immigrants to bring family members (family reunification), and rules for the acquisition of citizenship by immigrants and their family members (naturalization).',
    'Policing policies refer to the foundation for all operations in law enforcement. Including training, budget management, consequences for excessive use of force, etc.',
    '',
  ];
  final List<String> _issuesLeftDefinitions = [
    'People in favor of gun control desire laws to be put in place such as background checks, wait times before buying a gun, banning automatic weapons, and disallowing concealed weapons',
    'People in favor of climate policy are generally conservative in this area, preferring to ban economic activity that may create jobs but harm the environment.',
    'People in favor of public education believe every child in America, regardless of family income or place of residence, deserves access to a quality education. Including: expanded, free, public education including free college; student-loan forgiveness, teacher-pay raises, and universal pre-kindergarten.',
    'People who favor legalization believe that drug policy should be less strict including decreasing the penalties or punishments associated with the drug. Many people believe in the decriminalization of marijuana.',
    'People in favor of government-funded healthcare believe that access to healthcare is a fundamental right for all people. They support “Universal Healthcare”, “The Affordable Care Act”, and the expansion of Medicare and Medicaid.',
    'People in favor of Affordable housing believe that the government should support the creation of affordable housing and how it affects urban planning.',
    'People in favor of market regulation desire for the economy to be run by a cooperative collective agency, which can mean the state but also a network of communes.',
    'People in favor of inclusive immigration believe there should be pathways to citizenship for undocumented immigrants. Delay in deportations or prosecutions of undocumented immigrants who are young adults and have no criminal record.',
    'People in favor of Divestment and Reallocation advocate for investments made in supportive services and divestment from policing institutions. They believe that money is invested into minority communities to criminalize them instead of supporting them systematically.',
    'People in favor of “Pro-choice” generally believe in un-penalized access to abortion and both adult and embryonic stem cell research. They believe in “my body, my choice”.',
  ];
  final List<String> _issuesRightDefinitions = [
    'People in favor of gun rights are strongly opposed to gun laws. Many are strong advocates of the second amendment [the right to bear arms], including “freedom to carry” for self-protection and relying on the state at little as possible.',
    'People who doubt climate policy don’t believe the climate is a threat to our environment. They are more permissive when weighing the economic impact of environmental regulation. People who doubt climate change believe the free market will find its own solution to environmental issues.',
    'People in favor of school choice believe academic performance, free speech, and federal and state separation are essential to a good education. They believe “keeping Washington out of education” to ensure parents are in control of what their kids are learning in their districts.',
    'People who favor the criminalization of drugs believe that drug policy should be stricter including increasing the penalties or punishments associated with the drug.',
    'People in favor of private healthcare believe there should be competition with Medicare from private insurance companies. They oppose “Universal Healthcare”, “The Affordable Care Act”, and Medicare expansion.',
    'People in favor of Market rate housing believe that people should live where they can afford to and the government shouldn’t give tax breaks to support affordable housing.',
    'People in favor of market deregulation desire for the economy to be left to the devices of competing individuals and organizations.',
    'No “amnesty” for undocumented immigrants; stronger border patrol, etc. There’s a strong belief that illegal immigration is lowering the wages for citizens and documented immigrants.',
    'People in favor of Investment advocate for more funding for training, weaponry, and local policing infrastructure.',
    'People in favor of abortion and contraceptive criminalization believe that people shouldn’t get abortions or use contraceptives no matter what. They believe that a baby is alive at the moment of conception. Abortions/abortion relation surgeries and contraceptives should be criminalized.',
  ];
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
                                      _issuesLogo[_issueIndex],
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
                                                      _issuesText[_issueIndex],
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
                                                                  _issuesLogo[_issueIndex],
                                                                ),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                          //issue definition
                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                                            child: Text(
                                                              _issuesGeneralDefinitions[_issueIndex],
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
                                                                '• ${_leftAlignText[_issueIndex]}',
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
                                                              '▪ ${_issuesLeftDefinitions[_issueIndex]}',
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
                                                                '• ${_rightAlignText[_issueIndex]}',
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
                                                              '▪ ${_issuesRightDefinitions[_issueIndex]}',
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
                            _issuesText[_issueIndex],
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
                                    _leftAlignText[_issueIndex],
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
                                    _rightAlignText[_issueIndex],
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
