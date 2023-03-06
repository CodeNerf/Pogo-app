
import 'package:amplify_core/amplify_core.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'Onboarding/CandidateProfile.dart';
import 'dynamoModels/CandidateDemographics.dart';
import 'amplifyFunctions.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Podium extends StatefulWidget {
  List<CandidateDemographics> candidateStack;
  final Function(List<CandidateDemographics>) updateStack;
  Podium({Key? key, required this.candidateStack, required this.updateStack}) : super(key: key);

  @override
  State<Podium> createState() => _PodiumState();
}

class _PodiumState extends State<Podium> {
  //search values
  late final searchController = TextEditingController();

  //card values
  late List<CandidateDemographics> stack;
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
      initial.add(newCard(candidate: stack[0]));
    }
    else if(stackLength == 2) {
      initial.add(newCard(candidate: stack[0]));
      initial.add(newCard(candidate: stack[1]));
    }
    else if(stackLength == 0) {
      return initial;
    }
    else {
      initial.add(newCard(candidate: stack[0]));
      initial.add(newCard(candidate: stack[1]));
      initial.add(newCard(candidate: stack[2]));
    }
    return initial;
  }

  List<Widget> getRatingCircles() {
    List<Widget> circles = [];
    circles.add(ratingCircles('Education\n', 5));
    circles.add(ratingCircles('Climate\n', 3));
    circles.add(ratingCircles('Drug Policy\n', 4));
    circles.add(ratingCircles('Economy\n', 1));
    circles.add(ratingCircles('Healthcare\n', 2));
    circles.add(ratingCircles('Immigration\n', 4));
    circles.add(ratingCircles('Policing\n', 3));
    circles.add(ratingCircles('Reproductive \nHealth', 5));
    circles.add(ratingCircles('Gun Control\n', 1));
    circles.add(ratingCircles('Housing\n', 2));
    return circles;
  }

  //returns the candidate's experience
  String candidateExperience(String careerStart) {
    //TODO: careerStart must be stored in database in the format yyyy-mm-dd
    String experience = '';
    String newCareerStart = careerStart.replaceAll('/', '');
    newCareerStart = newCareerStart.substring(newCareerStart.length - 4) + newCareerStart.substring(0, newCareerStart.length - 4);
    DateTime start = DateTime.parse(newCareerStart);
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

  Widget newCard({required CandidateDemographics candidate}) {
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
              child: Row(
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

            //candidate top issues
            Expanded(
              flex: 35,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: getRatingCircles(),
                      ),
                    ),
                    const Text(
                      'Left: 0 | Right: 5',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.updateStack;
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
                        onCardSwiped: (dir, index, widget) {
                          safePrint("count = $count | stackIterable = $stackIterator | ${stack[stackIterator].firstName}");
                          if(count < stackLength) {
                            _cardController.addItem(newCard(candidate: stack[count]));
                            if(count == stackLength-1) {
                              count = 0;
                            }
                            else {
                              count++;
                            }
                          }
                          if(dir == Direction.right) {
                            //TODO: add candidate to local ballot
                            stack.removeAt(stackIterator);
                            stackLength--;
                          }
                          else {
                            //skip candidate, move to end of stack
                          }
                          if(stackIterator == stackLength-1) {
                            stackIterator = 0;
                          }
                          else {
                            stackIterator++;
                          }
                        },
                        //
                        enableSwipeUp: false,
                        enableSwipeDown: false,
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: CircularPercentIndicator(
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
      ),
    );
  }
}
