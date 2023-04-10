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
  const BallotPage(
      {Key? key,
      required this.userBallot,
      required this.candidateStack,
      required this.ballotStack,
      required this.removeFromBallot,
      required this.loadCustomCandidatesInPodium})
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

  @override
  void initState() {
    super.initState();
    _initializeBallot();
  }

  void _initializeBallot() {
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
              SizedBox(height: 6),
              Container(
                height: 330,
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
          SizedBox(height: 10),
          _buildExpandableButton(
            onPressed: () {
              setState(() {
                _expandedGlobal = !_expandedGlobal;
              });
            },
            expanded: _expandedGlobal,
            title: 'STATE',
            child: [
              SizedBox(height: 10),
            ],
          ),
          SizedBox(height: 10),
          _buildExpandableButton(
            onPressed: () {
              setState(() {
                _expandedOther = !_expandedOther;
              });
            },
            expanded: _expandedOther,
            title: 'FEDERAL',
            child: [
              SizedBox(height: 10),
            ],
          ),
          SizedBox(height: 10),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.only(bottom: 6.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF3D433),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          circleCount,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 10.0),
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
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
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
        child: CircularProfileAvatar(
          '',
          radius: 40,
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
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 20,
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
    margin: EdgeInsets.symmetric(horizontal: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
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
                    Icon(
                      expanded ? Icons.expand_less : Icons.expand_more,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (expanded) ...child,
      ],
    ),
  );
}
