import 'dart:math';
import 'package:amplify_core/amplify_core.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dynamoModels/Ballot.dart';
import 'package:pogo/dynamoModels/CandidateIssueFactorValues.dart';
import 'CandidateProfile.dart';
import 'awsFunctions.dart';
import 'dynamoModels/Ballot.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Podium extends StatefulWidget {
  List<CandidateDemographics> candidateStack;
  final Function(CandidateDemographics, List<CandidateDemographics>) updateBallot;
  Ballot userBallot;
  List<CandidateIssueFactorValues> candidateStackFactors;
  final Function() unFilterPodiumCandidates;
  Podium({Key? key, required this.candidateStack, required this.candidateStackFactors, required this.userBallot, required this.updateBallot, required this.unFilterPodiumCandidates}) : super(key: key);

  @override
  State<Podium> createState() => _PodiumState();
}

class _PodiumState extends State<Podium> {
  //search values
  late final searchController = TextEditingController();

  //card values
  late List<CandidateDemographics> stack;
  late List<CandidateIssueFactorValues> stackFactors;
  late int stackLength;
  String candidateIssueFirst = 'Issue 1';
  String candidateIssueSecond = 'Issue 2';
  final SwipeableCardSectionController _cardController = SwipeableCardSectionController();
  int count = 3;
  int stackIterator = 0;
  int numberOfIssues = 10;

  //local,state,federal bar values
  final List<bool> _selections = List.generate(3, (_)=>false );
  Color full = const Color(0xFFF3D433);
  Color empty = const Color(0xFF808080);
  Color local = const Color(0xFFF3D433);
  Color state = const Color(0xFF808080);
  Color federal = const Color(0xFF808080);

  //list of valid candidates' names
  static List<String> candidateList = <String>[];

  @override
  void initState() {
    setState(() {
      stackFactors = widget.candidateStackFactors;
      stack = widget.candidateStack;
      stackLength = stack.length;
      candidateList = [];
    });
    for(int i = 0; i < stackLength; i++) {
      candidateList.add('${stack[i].firstName} ${stack[i].lastName}');
    }
    super.initState();
  }

  //suggests candidates when typing in search bar
  Future<List<String>> candidateSearchOptions(String query) async {
    List<String> matches = <String>[];
    matches.addAll(candidateList);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  //card banner color
  Color candidateColor(String party) {
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

  void updateStack(int check) async {
    if(check == 0) {
      setState(() {
        state = empty;
        federal = empty;
        local = full;
      });
      //pull local candidate stack
    }
    else if(check == 1) {
      setState(() {
        local = empty;
        federal = empty;
        state = full;
      });
      //pull state candidate stack
    }
    else {
      setState(() {
        local = empty;
        state = empty;
        federal = full;
      });
      //pull federal candidate stack
    }
  }

  List<Widget> initialCards() {
    List<Widget> initial = [];
    if(stackLength == 1) {
      initial.add(newCard(stack[0]));
    }
    else if(stackLength == 2) {
      initial.add(newCard(stack[0]));
      initial.add(newCard(stack[1]));
    }
    else if(stackLength == 0) {
      return initial;
    }
    else {
      initial.add(newCard(stack[0]));
      initial.add(newCard(stack[1]));
      initial.add(newCard(stack[2]));
    }
    return initial;
  }

  List<Widget> getRatingCircles(String candidateId) {
    CandidateIssueFactorValues current = stackFactors.firstWhere((element) => element.candidateId == candidateId);
    List<num> candidateWeights = [current.climateWeight, current.drugPolicyWeight, current.economyWeight, current.educationWeight, current.gunPolicyWeight, current.healthcareWeight, current.housingWeight, current.immigrationWeight, current.policingWeight, current.reproductiveWeight];
    List<dynamic> topIssues = [];
    num maxWeight = candidateWeights.reduce(max);
    int indexMaxWeight = candidateWeights.indexOf(maxWeight);
    for(int i = 0; i < 3; i++) {
      switch (indexMaxWeight) {
        case 0:
          topIssues.add('CLIMATE\n');
          topIssues.add(current.climateScore.toDouble());
          break;
        case 1:
          topIssues.add('DRUG\nPOLICY');
          topIssues.add(current.drugPolicyScore.toDouble());
          break;
        case 2:
          topIssues.add('ECONOMY\n');
          topIssues.add(current.economyScore.toDouble());
          break;
        case 3:
          topIssues.add('EDUCATION\n');
          topIssues.add(current.educationScore.toDouble());
          break;
        case 4:
          topIssues.add('GUN\nPOLICY');
          topIssues.add(current.gunPolicyScore.toDouble());
          break;
        case 5:
          topIssues.add('HEALTHCARE\n');
          topIssues.add(current.healthcareScore.toDouble());
          break;
        case 6:
          topIssues.add('HOUSING\n');
          topIssues.add(current.housingScore.toDouble());
          break;
        case 7:
          topIssues.add('IMMIGRATION\n');
          topIssues.add(current.immigrationScore.toDouble());
          break;
        case 8:
          topIssues.add('POLICING\n');
          topIssues.add(current.policingScore.toDouble());
          break;
        case 9:
          topIssues.add('REPRODUCTIVE\nRIGHTS');
          topIssues.add(current.reproductiveScore.toDouble());
          break;
      }
      candidateWeights[indexMaxWeight] = 0;
      maxWeight = candidateWeights.reduce(max);
      indexMaxWeight = candidateWeights.indexOf(maxWeight);
    }
    List<Widget> circles = [];
    circles.add(ratingCircles('${topIssues[0]}\n', topIssues[1]));
    circles.add(ratingCircles('${topIssues[2]}\n', topIssues[3]));
    circles.add(ratingCircles('${topIssues[4]}\n', topIssues[5]));
    return circles;
  }

  //returns the candidate's experience
  String candidateExperience(String careerStart) {
    String experience = '';
    DateTime start = DateTime.parse(careerStart);
    DateTime currentDate = DateTime.now();
    int days = currentDate.difference(start).inDays;
    if(days > 364) {
      int years = days ~/ 365;
      //years
      experience = '$years years experience';
    }
    else if(days > 29) {
      //months
      int months = days ~/ 30;
      experience = '$months months experience';
    }
    else {
      experience = '$days days experience';
    }
    return experience;
  }

  void goToCandidateProfile(context, CandidateDemographics candidate) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CandidateProfile(candidate: candidate),
      ),
    );
  }

  void addCandidate(CandidateDemographics candidate) {
    stack.remove(candidate);
    widget.updateBallot(candidate, stack);
  }

  Widget newCard(CandidateDemographics candidate) {
    return Card(
      //card properties
      color: const Color(0xFFF9F9F9),
      margin: const EdgeInsets.fromLTRB(60, 10, 60, 60),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: InkWell(
        onTap: () async {
          goToCandidateProfile(context, candidate);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //candidate picture
            Expanded(
              flex: 40,
              child: Container(
                color: candidateColor(candidate.politicalAffiliation),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProfileAvatar(
                      '',
                      radius: 60,
                      elevation: 5,
                      child: FittedBox(
                        fit: BoxFit.cover,
                          child: Image(
                            image: NetworkImage(candidate.profileImageURL),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //candidate name
            Expanded(
              flex: 7,
              child: Text(
                  "${candidate.firstName} ${candidate.lastName}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),

            //candidate position, state
            //TODO: add state to db, pull state here
            Expanded(
              flex: 7,
              child: Text(
                '${candidate.seatType}  •  Michigan',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Color(0xFF57636C),
                ),
              ),
            ),

            //party, experience
            Expanded(
              flex: 7,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //party
                    Text(
                      candidate.politicalAffiliation,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 10),
                    //party
                    Text(
                      candidateExperience(candidate.careerStartDate),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //candidate top issues
            Expanded(
              flex: 35,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getRatingCircles(candidate.candidateId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //local, state, federal bar
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        updateStack(0);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                          color: local,
                          border: Border.all(color: Colors.black),
                        ),
                        child: const Center(
                            child: Text(
                              'Local',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        updateStack(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                          color: state,
                          border: Border.all(color: Colors.black),
                        ),
                        child: const Center(
                            child: Text(
                              'State',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        updateStack(2);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                          color: federal,
                          border: Border.all(color: Colors.black),
                        ),
                        child: const Center(
                            child: Text(
                              'Federal',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 13,
                //podium background
                //TODO: add x icon to left of page and + icon to right of page
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    image: DecorationImage(
                      image: AssetImage('assets/podiumPageBackgroundImage.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //search bar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: searchController,
                                decoration: const InputDecoration(
                                  labelText: 'Search',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                              suggestionsCallback: (query) async {
                                return candidateSearchOptions(query);
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              noItemsFoundBuilder: (context) =>
                              const Text(
                                'No Candidates Found',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              transitionBuilder: (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (suggestion) {
                                searchController.text = suggestion;
                              },
                            ),
                          ),
                        ),
                      ),
                      //candidate cards
                      SwipeableCardsSection(
                        cardController: _cardController,
                        context: context,
                        items: initialCards(),
                        cardWidthMiddleMul: 0.9,
                        cardHeightMiddleMul: 0.6,
                        cardWidthBottomMul: 0.9,
                        cardHeightBottomMul: 0.6,
                        onCardSwiped: (dir, index, widget) {
                          if(stackLength > 3  && stack.isNotEmpty) {
                            if(count < stackLength) {
                              _cardController.addItem(newCard(stack[count]));
                            }
                            if(dir == Direction.right) {
                              addCandidate(stack[stackIterator]);
                              stackLength--;
                            }
                            else {
                              if (count < stackLength) {
                                if (count == stackLength - 1) {
                                  count = 0;
                                }
                                else {
                                  count++;
                                }
                              }
                              else {
                                count = 0;
                              }
                              if (stackIterator >= stackLength - 1) {
                                stackIterator = 0;
                              }
                              else {
                                stackIterator++;
                              }
                            }
                          }
                          else if(stack.isNotEmpty && stackLength == 3){
                            int temp = stackIterator;
                            if(dir == Direction.right) {
                              stackLength = 2;
                              addCandidate(stack[temp]);
                            }
                            else {
                              if(count == 2) {
                                count = 0;
                                if(stackIterator == 2) {
                                  stackIterator = 0;
                                  _cardController.addItem(newCard(stack[2]));
                                }
                                else {
                                  stackIterator = 2;
                                  _cardController.addItem(newCard(stack[0]));
                                }
                              }
                              else if(count == 1) {
                                count = 2;
                                if(stackIterator == 1) {
                                  stackIterator = 2;
                                  _cardController.addItem(newCard(stack[1]));
                                }
                                else {
                                  stackIterator = 1;
                                  _cardController.addItem(newCard(stack[2]));
                                }
                              }
                              else if(count == 0) {
                                count = 1;
                                if(stackIterator == 0) {
                                  stackIterator = 1;
                                  _cardController.addItem(newCard(stack[0]));
                                }
                                else {
                                  stackIterator = 0;
                                  _cardController.addItem(newCard(stack[1]));
                                }
                              }
                              else {
                                count = 1;
                                stackIterator = 1;
                                _cardController.addItem(newCard(stack[0]));
                              }
                            }
                          }
                          else if(stack.isNotEmpty && stackLength == 2){
                            if(widget != null) {
                              if(dir == Direction.right) {
                                stackLength = 1;
                                addCandidate(stack[stackIterator]);
                              }
                              else {
                                if(stackIterator == 0) {
                                  stackIterator = 1;
                                  _cardController.addItem(newCard(stack[0]));
                                }
                                else {
                                  stackIterator = 0;
                                  _cardController.addItem(newCard(stack[1]));
                                }
                              }
                            }
                          }
                          else if(stack.isNotEmpty && stackLength == 1){
                            if(widget != null) {
                              if(dir == Direction.left) {
                                _cardController.addItem(newCard(stack[0]));
                              }
                              else {
                                stackLength = 0;
                                addCandidate(stack[0]);
                              }
                            }
                          }
                        },
                        enableSwipeUp: false,
                        enableSwipeDown: false,
                      ),
                      //alert
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showAlert(context);
                              },
                              child: const Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                size: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await widget.unFilterPodiumCandidates();
                                setState(() {
                                  stack = widget.candidateStack;
                                  stackLength = stack.length;
                                });
                              },
                              child: const Text(
                                'Remove Filter'
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget ratingCircles(String name, double rating) {
    return CircularPercentIndicator(
      radius: 25,
      lineWidth: 6,
      progressColor: const Color(0xFFF3D433),
      backgroundColor: const Color(0xFF8B9DDE),
      footer: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      percent: rating/5,
      center: Text(
        '$rating',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  showAlert(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      content: Text('Swipe left to skip the current candidate. Swipe right to add the candidate to your ballot.\nEach candidate displays their ratings on the 3 political issues that are most important to them. A low rating means that the candidate leans more to the left on that issue. A high rating means that the candidate leans more to the right on that issue.'),
    );
    showDialog(
      barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }
}
