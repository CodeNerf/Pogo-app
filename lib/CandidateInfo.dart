import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';

class CandidateInfo extends StatefulWidget {
  const CandidateInfo({Key? key}) : super(key: key);

  @override
  _CandidateInfoState createState() => _CandidateInfoState();
}

class _CandidateInfoState extends State<CandidateInfo> {
  bool _expandedLocal = false;
  bool _expandedGlobal = false;
  bool _expandedOther = false;
  List<int> circleCounts = List.filled(13, 1);

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
                height: 500, 
                child: ListView(
                  physics: BouncingScrollPhysics(), 
                  shrinkWrap: true,
                  children: [
                    buildRow('Mayor', circleCounts[0], (count) {
                      setState(() {
                        circleCounts[0] = count;
                      });
                    }, 0), 
                    buildRow('City Clerk', circleCounts[1], (count) {
                      setState(() {
                        circleCounts[1] = count;
                      });
                    }, 1),
                    buildRow('Town/City Council', circleCounts[2], (count) {
                      setState(() {
                        circleCounts[2] = count;
                      });
                    }, 2), 
                    buildRow('County Sheriff', circleCounts[3], (count) {
          setState(() {
            circleCounts[3] = count;
          });
        }, 4),
        buildRow('Trial Court Judges', circleCounts[4], (count) {
          setState(() {
            circleCounts[4] = count;
          });
        }, 4), 
        buildRow('County Register of Deeds', circleCounts[5], (count) {
          setState(() {
            circleCounts[5] = count;
          });
        }, 5), 
        buildRow('School Board', circleCounts[6], (count) {
          setState(() {
            circleCounts[6] = count;
          });
        }, 6),
        buildRow('Prosecuters', circleCounts[7], (count) {
          setState(() {
            circleCounts[7] = count;
          });
        }, 7), 
        buildRow('Coroners', circleCounts[8], (count) {
          setState(() {
            circleCounts[8] = count;
          });
        }, 8), 
        buildRow('Planning/Zoning Commissions', circleCounts[9], (count) {
          setState(() {
            circleCounts[9] = count;
          });
        }, 9), 
        buildRow('Public Works Commissions', circleCounts[10], (count) {
          setState(() {
            circleCounts[10] = count;
          });
        }, 10),
        buildRow('Commissioner of Revenue', circleCounts[11], (count) {
          setState(() {
            circleCounts[11] = count;
          });
        }, 11),  
        buildRow('County Commissioner', circleCounts[1], (count) {
          setState(() {
            circleCounts[12] = count;
          });
        }, 12),  
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

Widget buildRow(String title, int circleCount, Function(int) updateCircleCount, int rowIndex) {
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
                      Spacer(),
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
                          child: buildCircle(() {
                            updateCircleCount(circleCount - 1);
                          }, () {
                            updateCircleCount(circleCount - 1);
                          }),
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




