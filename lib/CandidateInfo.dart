import 'package:amplify_core/amplify_core.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/CandidateDemographics.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/Ballot.dart';

class CandidateInfo extends StatefulWidget {
  Ballot userBallot;
  List<CandidateDemographics> candidateStack;
  List<CandidateDemographics> ballotStack;
  CandidateInfo({Key? key, required this.userBallot, required this.candidateStack, required this.ballotStack}) : super(key: key);

  @override
  _CandidateInfoState createState() => _CandidateInfoState();
}

class _CandidateInfoState extends State<CandidateInfo> {
  bool _expandedLocal = false;
  bool _expandedGlobal = false;
  bool _expandedOther = false;
  //List<int> circleCounts = List.filled(13, 1);
  int mayor = 0;
  int cityClerk = 0;
  int cityCouncil = 0;
  int countySheriff = 0;
  int trialCourtJudge = 0;
  int countyRegisterOfDeeds = 0;
  int schoolBoard = 0;
  int prosecutors = 0;
  int coroners = 0;
  int planningZoningCommission = 0;
  int publicWorksCommission = 0;
  int commissionerOfRevenue = 0;
  int countyCommissioners = 0;
  List<String> mayorPics = [];
  List<String> cityClerkPics = [];
  List<String> cityCouncilPics = [];
  List<String> countySheriffPics = [];
  List<String> trialCourtJudgePics = [];
  List<String> countyRegisterOfDeedsPics = [];
  List<String> schoolBoardPics = [];
  List<String> prosecutorsPics = [];
  List<String> coronersPics = [];
  List<String> planningZoningCommissionPics = [];
  List<String> publicWorksCommissionPics = [];
  List<String> commissionerOfRevenuePics = [];
  List<String> countyCommissionersPics = [];

  @override
  void initState() {
    super.initState();
    initializeBallot();
  }

  void initializeBallot() {
    if(widget.userBallot.localCandidateIds.isNotEmpty) {
      for(int i = 0; i < widget.userBallot.localCandidateIds.length; i++) {
        CandidateDemographics current = widget.ballotStack[i];
        String seatType = current.seatType;
        switch (seatType) {
          case 'Mayor':
            mayor++;
            mayorPics.add(current.profileImageURL);
            break;
          case 'City Clerk':
            cityClerk++;
            cityClerkPics.add(current.profileImageURL);
            break;
          case 'City Council':
            cityCouncil++;
            cityCouncilPics.add(current.profileImageURL);
            break;
          case 'County Commissioner':
            countyCommissioners++;
            countyCommissionersPics.add(current.profileImageURL);
            break;
          case 'County Sheriff':
            countySheriff++;
            countySheriffPics.add(current.profileImageURL);
            break;
          case 'Trial Court Judge':
            trialCourtJudge++;
            trialCourtJudgePics.add(current.profileImageURL);
            break;
          case 'County Register of Deeds':
            countyRegisterOfDeeds++;
            countyRegisterOfDeedsPics.add(current.profileImageURL);
            break;
          case 'School Board':
            schoolBoard++;
            schoolBoardPics.add(current.profileImageURL);
            break;
          case 'Prosecutor':
            prosecutors++;
            prosecutorsPics.add(current.profileImageURL);
            break;
          case 'Coroner':
            coroners++;
            coronersPics.add(current.profileImageURL);
            break;
          case 'Planning and Zoning Commission':
            planningZoningCommission++;
            planningZoningCommissionPics.add(current.profileImageURL);
            break;
          case 'Public Works Commission':
            publicWorksCommission++;
            publicWorksCommissionPics.add(current.profileImageURL);
            break;
          default:
            break;
        }
      }
    }
  }

  void removeCandidate() async {

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(height: 10),
          buildExpandableButton(
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
                  physics: BouncingScrollPhysics(), 
                  shrinkWrap: true,
                  children: [
                    buildRow(context, 'Mayor', mayor, mayorPics, (count) {
                      setState(() {
                        mayor = count;
                      });
                    }, 0),
                    buildRow(context, 'City Clerk', cityClerk, cityClerkPics, (count) {
                      setState(() {
                        cityClerk = count;
                      });
                    }, 1),
                    buildRow(context, 'City Council', cityCouncil, cityCouncilPics, (count) {
                      setState(() {
                        cityCouncil = count;
                      });
                    }, 2),
                    buildRow(context, 'County Sheriff', countySheriff, countySheriffPics, (count) {
                      setState(() {
                        countySheriff = count;
                      });
                    }, 4),
                    buildRow(context, 'Trial Court Judges', trialCourtJudge, trialCourtJudgePics, (count) {
                      setState(() {
                        trialCourtJudge = count;
                      });
                    }, 5),
                    buildRow(context, 'County Register of Deeds', countyRegisterOfDeeds, countyRegisterOfDeedsPics, (count) {
                      setState(() {
                        countyRegisterOfDeeds = count;
                      });
                    }, 6),
                    buildRow(context, 'School Board', schoolBoard, schoolBoardPics, (count) {
                      setState(() {
                        schoolBoard = count;
                      });
                    }, 7),
                    buildRow(context, 'Prosecutors', prosecutors, prosecutorsPics, (count) {
                      setState(() {
                        prosecutors = count;
                      });
                    }, 8),
                    buildRow(context, 'Coroners', coroners, coronersPics, (count) {
                      setState(() {
                        coroners = count;
                      });
                    }, 9),
                    buildRow(context, 'Planning/Zoning Commission', planningZoningCommission, planningZoningCommissionPics, (count) {
                      setState(() {
                        planningZoningCommission = count;
                      });
                    }, 10),
                    buildRow(context, 'Public Works Commission', publicWorksCommission, publicWorksCommissionPics, (count) {
                      setState(() {
                        publicWorksCommission = count;
                      });
                    }, 11),
                    buildRow(context, 'Commissioner of Revenue', commissionerOfRevenue, commissionerOfRevenuePics, (count) {
                      setState(() {
                        commissionerOfRevenue = count;
                      });
                    }, 12),
                    buildRow(context, 'County Commissioner', countyCommissioners, countyCommissionersPics, (count) {
                      setState(() {
                        countyCommissioners = count;
                      });
                    }, 13),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10), 
          buildExpandableButton(
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
          buildExpandableButton(
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
}

Widget buildRow(context, String title, int circleCount, List<String> candidatePics, Function(int) updateCircleCount, int rowIndex) {
  return SizedBox(
    width: 400,
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
                      Text(
                        title,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          updateCircleCount(circleCount + 1);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        circleCount,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: buildCircleCandidate(() {
                            updateCircleCount(circleCount - 1);
                            },() {
                              updateCircleCount(circleCount - 1);
                            },
                            candidatePics[index],
                            context,
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

Widget buildCircleCandidate(VoidCallback onDelete, Null Function() param1, String candidatePic, context) {
  return GestureDetector(
    onLongPress: () {
      //var context;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete saved Candidate'),
            content: Text('Are you sure you want to delete this saved Candidate?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
    onTap: () {

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
}


Widget buildCircle(VoidCallback onDelete, Null Function() param1) {
  return GestureDetector(
    onLongPress: () {
      var context;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete saved Candidate'),
            content: Text('Are you sure you want to delete this saved Candidate?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
    child: Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Icon(
        Icons.add,
        color: Colors.black,
        size: 20,
      ),
    ),
  );
}

Widget buildExpandableButton({
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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




