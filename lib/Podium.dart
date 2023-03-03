
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CandidateUserMatching extends StatefulWidget {
  const CandidateUserMatching({Key? key}) : super(key: key);

  @override
  State<CandidateUserMatching> createState() => _CandidateUserMatchingState();
}

class _CandidateUserMatchingState extends State<CandidateUserMatching> {
  //search values
  late final searchController = TextEditingController();

  //card values
  String candidateLogo = 'assets/placeholderCandidatePic.png';
  String candidateName = 'ERIC ADAMS';
  String candidateCurrentPosition = 'Mayor of NYC';
  String candidateRunningForPosition = 'Mayor of NYC';
  String partyLogo = 'assets/democratLogo.png';
  String candidateNumber = '20';
  String candidateState = 'NY';
  String candidateIssueFirst = 'Issue 1';
  String candidateIssueSecond = 'Issue 2';
  SwipeableCardSectionController _cardController = SwipeableCardSectionController();

  //local,state,federal bar values
  final List<bool> _selections = List.generate(3, (_)=>false );
  Color full = const Color(0xFFF3D433);
  Color empty = const Color(0xFF808080);
  Color local = const Color(0xFFF3D433);
  Color state = const Color(0xFF808080);
  Color federal = const Color(0xFF808080);

  //list of valid candidates
  static const List<String> candidateList = <String>[
    'Eric Adams',
  "Oliver Hernandez",
  "Natalie Lowe",
  "Lucas Patterson",
  "Eva Watkins",
  "Gavin Spencer",
  "Leah Webster",
  "Anthony Ortiz",
  "Isabella Dunn",
  "Seth Foster",
  "Sadie Caldwell",
  "Maxwell Perry",
  "Charlotte Nguyen",
  "Jacob Bishop",
  "Ava Ramsey",
  "Ethan Barrett",
  "Madelyn Vega",
  "Nicholas Baldwin",
  "Penelope Wallace",
  "William Guzman",
  "Avery Doyle",
  "Carter Ramirez",
  "Harper Davis",
  "Alexander Cohen",
  "Lila Richardson",
  "Benjamin Berry",
  ];

  //suggests candidates when typing in search bar
  Future<List<String>> candidateSearchOptions(String query) async {
    List<String> matches = <String>[];
    matches.addAll(candidateList);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
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

  void loadCandidate() async {

  }

  Widget newCard() {
    return Card(
      //card properties
      color: const Color(0xFFD9D9D9),
      margin: const EdgeInsets.fromLTRB(60, 10, 60, 50),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color(0xFF2B49B4),
          width: 4,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //candidate picture
          Expanded(
            flex: 26,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: CircularProfileAvatar(
                '',
                radius: 40,
                borderWidth: 3,
                borderColor: const Color(0xFF5F5D5D),
                child: FittedBox(
                  fit: BoxFit.cover,
                    child: Image(image: AssetImage(candidateLogo),)
                ),
              ),
            ),
          ),

          //candidate name
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                  candidateName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Helvetica',
                  fontSize: 20,
                ),
              ),
            ),
          ),

          //candidate position
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                candidateCurrentPosition,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Helvetica',
                  fontSize: 15,
                ),
              ),
            ),
          ),

          //party logo, number, state
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //party logo
                  Container(
                    width: 30,
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image(
                        image: AssetImage(
                          partyLogo,
                        ),
                      ),
                    ),
                  ),

                  //number
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        candidateNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Helvetica',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  //state
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        candidateState,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Helvetica',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //position running for text
          const Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                'Position running for:',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Helvetica',
                  fontSize: 14,
                ),
              ),
            ),
          ),

          //position candidate is running for
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                candidateRunningForPosition,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Helvetica',
                  fontSize: 15,
                ),
              ),
            ),
          ),

          //candidate top issues
          Expanded(
            flex: 25,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        candidateIssueFirst,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Helvetica',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        candidateIssueSecond,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Helvetica',
                          fontSize: 15,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  image: DecorationImage(
                    image: AssetImage('assets/podiumPageBackgroundImage.png'),
                    fit: BoxFit.fill,
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
                                labelText: 'Search Candidates',
                                labelStyle: TextStyle(
                                  fontFamily: 'Helvetica',
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
                      items: [
                        newCard(),
                        newCard(),
                        newCard(),
                      ],
                      onCardSwiped: (dir, index, widget) {
                        _cardController.addItem(newCard());
                        if(dir == Direction.left) {
                          //skip candidate
                        }
                        else {
                          //add candidate to ballot
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
    );
  }
}
