import 'package:amplify_core/amplify_core.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/Demographics/CandidateDemographics.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/Ballot.dart';

class BallotPage extends StatefulWidget {
  final Ballot userBallot;
  final List<CandidateDemographics> candidateStack;
  final List<CandidateDemographics> ballotStack;
  final Function(String) removeFromBallot;
  final Function(String) loadCustomCandidatesInPodium;
  final Function(String) loadCandidateProfile;
  const BallotPage(
      {Key? key,
        required this.userBallot,
        required this.candidateStack,
        required this.ballotStack,
        required this.removeFromBallot,
        required this.loadCustomCandidatesInPodium,
        required this.loadCandidateProfile})
      : super(key: key);

  @override
  State<BallotPage> createState() => _BallotPageState();
}

class _BallotPageState extends State<BallotPage> {
  bool _expandedLocal = false;
  bool _expandedGlobal = false;
  bool _expandedOther = false;
  int _mayor = 1;
  int _cityClerk = 1;
  int _cityCouncil = 1;
  int _countySheriff = 1;
  int _trialCourtJudge = 1;
  int _countyRegisterOfDeeds = 1;
  int _schoolBoard = 1;
  int _prosecutors = 1;
  int _coroners = 1;
  int _planningZoningCommission = 1;
  int _publicWorksCommission = 1;
  int _commissionerOfRevenue = 1;
  int _countyCommissioners = 1;
  int _governor = 1;
  int _secretaryOfState = 1;
  int _attorneyGeneral = 1;
  int _supremeCourtJustice = 1;
  int _comptroller = 1;
  int _treasurer = 1;
  int _representative = 1;
  int _senator = 1;
  int _legislator = 1;
  int _educationCommissioner = 1;
  int _boardOfEducation = 1;
  int _publicServiceCommissioner = 1;
  int _agricultureCommissioner = 1;
  int _president = 1;

  final List<String> _mayorPics = [];
  final List<String> _cityClerkPics = [];
  final List<String> _cityCouncilPics = [];
  final List<String> _countySheriffPics = [];
  final List<String> _trialCourtJudgePics = [];
  final List<String> _countyRegisterOfDeedsPics = [];
  final List<String> _schoolBoardPics = [];
  final List<String> _prosecutorsPics = [];
  final List<String> _coronersPics = [];
  final List<String> _planningZoningCommissionPics = [];
  final List<String> _publicWorksCommissionPics = [];
  final List<String> _commissionerOfRevenuePics = [];
  final List<String> _countyCommissionersPics = [];
  final List<String> _governorPics = [];
  final List<String> _secretaryOfStatePics = [];
  final List<String> _attorneyGeneralPics = [];
  final List<String> _supremeCourtJusticePics = [];
  final List<String> _comptrollerPics = [];
  final List<String> _treasurerPics = [];
  final List<String> _representativePics = [];
  final List<String> _senatorPics = [];
  final List<String> _legislatorPics = [];
  final List<String> _educationCommissionerPics = [];
  final List<String> _boardOfEducationPics = [];
  final List<String> _publicServiceCommissionerPics = [];
  final List<String> _agricultureCommissionerPics = [];
  final List<String> _presidentPics = [];

  @override
  void initState() {
    super.initState();
    _initializeBallot();
  }

  void _initializeBallot() {
    //local init
    if (widget.userBallot.localCandidateIds.isNotEmpty) {
      for (int i = 0; i < widget.userBallot.localCandidateIds.length; i++) {
        CandidateDemographics current = widget.ballotStack[i];
        String seatType = current.runningPosition;
        switch (seatType) {
          case 'Mayor':
            _mayor++;
            _mayorPics.add(current.profileImageURL);
            break;
          case 'Clerk':
            _cityClerk++;
            _cityClerkPics.add(current.profileImageURL);
            break;
          case 'City Council':
            _cityCouncil++;
            _cityCouncilPics.add(current.profileImageURL);
            break;
          case 'Commissioner':
            _countyCommissioners++;
            _countyCommissionersPics.add(current.profileImageURL);
            break;
          case 'Sheriff':
            _countySheriff++;
            _countySheriffPics.add(current.profileImageURL);
            break;
          case 'Judge':
            _trialCourtJudge++;
            _trialCourtJudgePics.add(current.profileImageURL);
            break;
          case 'County Register of Deeds':
            _countyRegisterOfDeeds++;
            _countyRegisterOfDeedsPics.add(current.profileImageURL);
            break;
          case 'School Board':
            _schoolBoard++;
            _schoolBoardPics.add(current.profileImageURL);
            break;
          case 'Prosecutor':
            _prosecutors++;
            _prosecutorsPics.add(current.profileImageURL);
            break;
          case 'Coroner':
            _coroners++;
            _coronersPics.add(current.profileImageURL);
            break;
          case 'Planning and Zoning Commission':
            _planningZoningCommission++;
            _planningZoningCommissionPics.add(current.profileImageURL);
            break;
          case 'Public Works Commission':
            _publicWorksCommission++;
            _publicWorksCommissionPics.add(current.profileImageURL);
            break;
          case 'Governor':
            _governor++;
            _governorPics.add(current.profileImageURL);
            break;
          case 'Secretary of State':
            _secretaryOfState++;
            _secretaryOfStatePics.add(current.profileImageURL);
            break;
          case 'Attorney General':
            _attorneyGeneral++;
            _attorneyGeneralPics.add(current.profileImageURL);
            break;
          case 'Supreme Court Justice':
            _supremeCourtJustice++;
            _supremeCourtJusticePics.add(current.profileImageURL);
            break;
          case 'Comptroller':
            _comptroller++;
            _comptrollerPics.add(current.profileImageURL);
            break;
          case 'Treasurer':
            _treasurer++;
            _treasurerPics.add(current.profileImageURL);
            break;
          case 'Representative':
            _representative++;
            _representativePics.add(current.profileImageURL);
            break;
          case 'Senator':
            _senator++;
            _senatorPics.add(current.profileImageURL);
            break;
          case 'Legislator':
            _legislator++;
            _legislatorPics.add(current.profileImageURL);
            break;
          case 'Education Commissioner':
            _educationCommissioner++;
            _educationCommissionerPics.add(current.profileImageURL);
            break;
          case 'Board of Education':
            _boardOfEducation++;
            _boardOfEducationPics.add(current.profileImageURL);
            break;
          case 'Public Service Commissioner':
            _publicServiceCommissioner++;
            _publicServiceCommissionerPics.add(current.profileImageURL);
            break;
          case 'Agriculture Commissioner':
            _agricultureCommissioner++;
            _agricultureCommissionerPics.add(current.profileImageURL);
            break;
          case 'President':
            _president++;
            _presidentPics.add(current.profileImageURL);
            break;
          default:
            break;
        }
      }
    }
    _mayorPics.add('');
    _cityClerkPics.add('');
    _cityCouncilPics.add('');
    _countySheriffPics.add('');
    _trialCourtJudgePics.add('');
    _countyRegisterOfDeedsPics.add('');
    _schoolBoardPics.add('');
    _prosecutorsPics.add('');
    _coronersPics.add('');
    _planningZoningCommissionPics.add('');
    _publicWorksCommissionPics.add('');
    _commissionerOfRevenuePics.add('');
    _countyCommissionersPics.add('');
    _governorPics.add('');
    _secretaryOfStatePics.add('');
    _attorneyGeneralPics.add('');
    _supremeCourtJusticePics.add('');
    _comptrollerPics.add('');
    _treasurerPics.add('');
    _representativePics.add('');
    _senatorPics.add('');
    _legislatorPics.add('');
    _educationCommissionerPics.add('');
    _boardOfEducationPics.add('');
    _publicServiceCommissionerPics.add('');
    _agricultureCommissionerPics.add('');
    _presidentPics.add('');
  }

  void _removeCandidate(String candidatePic, String title) {
    switch (title) {
      case 'Mayor':
        _mayorPics.remove(candidatePic);
        break;
      case 'Clerk':
        _cityClerkPics.remove(candidatePic);
        break;
      case 'City Council':
        _cityCouncilPics.remove(candidatePic);
        break;
      case 'Sheriff':
        _countySheriffPics.remove(candidatePic);
        break;
      case 'Judge':
        _trialCourtJudgePics.remove(candidatePic);
        break;
      case 'County Register of Deeds':
        _countyRegisterOfDeedsPics.remove(candidatePic);
        break;
      case 'School Board':
        _schoolBoardPics.remove(candidatePic);
        break;
      case 'Prosecutor':
        _prosecutorsPics.remove(candidatePic);
        break;
      case 'Coroner':
        _coronersPics.remove(candidatePic);
        break;
      case 'Planning/Zoning Commission':
        _planningZoningCommissionPics.remove(candidatePic);
        break;
      case 'Public Works Commission':
        _publicWorksCommissionPics.remove(candidatePic);
        break;
      case 'Commissioner of Revenue':
        _commissionerOfRevenuePics.remove(candidatePic);
        break;
      case 'Commissioner':
        _countyCommissionersPics.remove(candidatePic);
        break;
      case 'Governor':
        _governorPics.remove(candidatePic);
        break;
      case 'Secretary of State':
        _secretaryOfStatePics.remove(candidatePic);
        break;
      case 'Attorney General':
        _attorneyGeneralPics.remove(candidatePic);
        break;
      case 'Supreme Court Justice':
        _supremeCourtJusticePics.remove(candidatePic);
        break;
      case 'Comptroller':
        _comptrollerPics.remove(candidatePic);
        break;
      case 'Treasurer':
        _treasurerPics.remove(candidatePic);
        break;
      case 'Representative':
        _representativePics.remove(candidatePic);
        break;
      case 'Senator':
        _senatorPics.remove(candidatePic);
        break;
      case 'Legislator':
        _legislatorPics.remove(candidatePic);
        break;
      case 'Education Commissioner':
        _educationCommissionerPics.remove(candidatePic);
        break;
      case 'Board of Education':
        _boardOfEducationPics.remove(candidatePic);
        break;
      case 'Public Service Commissioner':
        _publicServiceCommissionerPics.remove(candidatePic);
        break;
      case 'Agriculture Commissioner':
        _agricultureCommissionerPics.remove(candidatePic);
        break;
      case 'President':
        _presidentPics.remove(candidatePic);
        break;
      default:
        break;
    }
    widget.removeFromBallot(candidatePic);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const SizedBox(height: 10),
          _buildExpandableButton(
            onPressed: () {
              setState(() {
                _expandedLocal = !_expandedLocal;
              });
            },
            expanded: _expandedLocal,
            title: 'LOCAL',
            child: [
              Container(
                height: MediaQuery.of(context).size.height * 0.56,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _buildRow(context, 'Mayor', _mayor, _mayorPics, (count) {
                      setState(() {
                        _mayor = count;
                      });
                    }, 0),
                    _buildRow(context, 'Clerk', _cityClerk, _cityClerkPics,
                        (count) {
                      setState(() {
                        _cityClerk = count;
                      });
                    }, 1),
                    _buildRow(
                        context, 'City Council', _cityCouncil, _cityCouncilPics,
                        (count) {
                      setState(() {
                        _cityCouncil = count;
                      });
                    }, 2),
                    _buildRow(
                        context, 'Sheriff', _countySheriff, _countySheriffPics,
                        (count) {
                      setState(() {
                        _countySheriff = count;
                      });
                    }, 4),
                    _buildRow(context, 'Judge', _trialCourtJudge,
                        _trialCourtJudgePics, (count) {
                      setState(() {
                        _trialCourtJudge = count;
                      });
                    }, 5),
                    _buildRow(
                        context,
                        'County Register of Deeds',
                        _countyRegisterOfDeeds,
                        _countyRegisterOfDeedsPics, (count) {
                      setState(() {
                        _countyRegisterOfDeeds = count;
                      });
                    }, 6),
                    _buildRow(
                        context, 'School Board', _schoolBoard, _schoolBoardPics,
                        (count) {
                      setState(() {
                        _schoolBoard = count;
                      });
                    }, 7),
                    _buildRow(
                        context, 'Prosecutor', _prosecutors, _prosecutorsPics,
                        (count) {
                      setState(() {
                        _prosecutors = count;
                      });
                    }, 8),
                    _buildRow(context, 'Coroner', _coroners, _coronersPics,
                        (count) {
                      setState(() {
                        _coroners = count;
                      });
                    }, 9),
                    _buildRow(
                        context,
                        'Planning/Zoning Commission',
                        _planningZoningCommission,
                        _planningZoningCommissionPics, (count) {
                      setState(() {
                        _planningZoningCommission = count;
                      });
                    }, 10),
                    _buildRow(
                        context,
                        'Public Works Commission',
                        _publicWorksCommission,
                        _publicWorksCommissionPics, (count) {
                      setState(() {
                        _publicWorksCommission = count;
                      });
                    }, 11),
                    _buildRow(
                        context,
                        'Commissioner of Revenue',
                        _commissionerOfRevenue,
                        _commissionerOfRevenuePics, (count) {
                      setState(() {
                        _commissionerOfRevenue = count;
                      });
                    }, 12),
                    _buildRow(context, 'Commissioner', _countyCommissioners,
                        _countyCommissionersPics, (count) {
                      setState(() {
                        _countyCommissioners = count;
                      });
                    }, 13),
                  ],
                ),
              ),
            ],
          ),
          _buildExpandableButton(
            onPressed: () {
              setState(() {
                _expandedGlobal = !_expandedGlobal;
              });
            },
            expanded: _expandedGlobal,
            title: 'STATE',
            child: [
              SizedBox(height: 6),
              Container(
                height: MediaQuery.of(context).size.height * 00.56,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _buildRow(context, 'Governor', _governor, _governorPics, (count) {
                      setState(() {
                        _governor = count;
                      });
                    }, 0),
                    _buildRow(context, 'Secretary of State', _secretaryOfState, _secretaryOfStatePics, (count) {
                      setState(() {
                        _secretaryOfState = count;
                      });
                    }, 1),
                    _buildRow(context, 'Attorney General', _attorneyGeneral, _attorneyGeneralPics, (count) {
                      setState(() {
                        _attorneyGeneral = count;
                      });
                    }, 2),
                    _buildRow(context, 'Supreme Court Justice', _supremeCourtJustice, _supremeCourtJusticePics, (count) {
                      setState(() {
                        _supremeCourtJustice = count;
                      });
                    }, 3),
                    _buildRow(context, 'Comptroller', _comptroller, _comptrollerPics, (count) {
                      setState(() {
                        _comptroller = count;
                      });
                    }, 4),
                    _buildRow(context, 'Treasurer', _treasurer, _treasurerPics, (count) {
                      setState(() {
                        _treasurer = count;
                      });
                    }, 5),
                    _buildRow(context, 'Representative', _representative, _representativePics, (count) {
                      setState(() {
                        _representative = count;
                      });
                    }, 6),
                    _buildRow(context, 'Senator', _senator, _senatorPics, (count) {
                      setState(() {
                        _senator = count;
                      });
                    }, 7),
                    _buildRow(context, 'Legislator', _legislator, _legislatorPics, (count) {
                      setState(() {
                        _legislator = count;
                      });
                    }, 8),
                    _buildRow(context, 'Education Commissioner', _educationCommissioner, _educationCommissionerPics, (count) {
                      setState(() {
                        _educationCommissioner = count;
                      });
                    }, 9),
                    _buildRow(context, 'Board of Education', _boardOfEducation, _boardOfEducationPics, (count) {
                      setState(() {
                        _boardOfEducation = count;
                      });
                    }, 10),
                    _buildRow(context, 'Public Service Commissioner', _publicServiceCommissioner, _publicServiceCommissionerPics, (count) {
                      setState(() {
                        _publicServiceCommissioner = count;
                      });
                    }, 11),
                    _buildRow(context, 'Agriculture Commissioner', _agricultureCommissioner, _agricultureCommissionerPics, (count) {
                      setState(() {
                        _agricultureCommissioner = count;
                      });
                    }, 12),
                  ],
                ),
              ),
            ],
          ),
          _buildExpandableButton(
            onPressed: () {
              setState(() {
                _expandedOther = !_expandedOther;
              });
            },
            expanded: _expandedOther,
            title: 'FEDERAL',
            child: [
              SizedBox(height: 6),
              Container(
                height: MediaQuery.of(context).size.height * 0.56,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _buildRow(context, 'President', _president, _presidentPics, (count) {
                      setState(() {
                        _president = count;
                      });
                    }, 0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
      context,
      String title,
      int circleCount,
      List<String> candidatePics,
      Function(int) updateCircleCount,
      int rowIndex) {
    return Container(
      height: 140, // set a fixed height
      margin: EdgeInsets.only(bottom: 10.0, top: 10, left: 30),
      child: Container(
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD700),
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 2.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 145,
                    padding: EdgeInsets.only(left: 10, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100, // set a fixed height for the text widget
                          child: Center(
                            child: Text(
                              title.replaceAll(" ", "\n"),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        circleCount,
                        (index) => SizedBox(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, top: 30),
                            child: _buildCircleCandidate(
                              () {
                                updateCircleCount(circleCount - 1);
                              },
                              () {
                                updateCircleCount(circleCount - 1);
                              },
                              candidatePics[index],
                              context,
                              title,
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

  Widget _buildCircleCandidate(VoidCallback onDelete, Null Function() param1,
      String candidatePic, context, String title) {
    if (candidatePic != '') {
      CandidateDemographics candidate = widget.ballotStack
          .firstWhere((element) => element.profileImageURL == candidatePic);
      return GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Remove ${candidate.candidateName} from Ballot'),
                content: const Text(
                    'Are you sure you want to remove them from your ballot?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Remove'),
                    onPressed: () {
                      onDelete();
                      Navigator.of(context).pop();
                      _removeCandidate(candidatePic, title);
                    },
                  ),
                ],
              );
            },
          );
        },
        onDoubleTap: () {
          widget.loadCandidateProfile(candidate.candidateName);
        },
        child: CircularProfileAvatar(
          '',
          radius: 35,
          elevation: 5,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image(
              image: NetworkImage(candidatePic),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          widget.loadCustomCandidatesInPodium(title);
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD9D9D9),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 40,
          ),
        ),
      );
    }
  }
}

Widget _buildExpandableButton({
  required VoidCallback onPressed,
  required bool expanded,
  required String title,
  required List<Widget> child,
}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black, // set your desired color here
                width: 2.5, // set the width of the border
              ),
            ),
          ),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              color: Color(0xFFD9D9D9),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (expanded) ...child,
        Container(
          color: Colors.white,
        )
      ],
    ),
  );
}
