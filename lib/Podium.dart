import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class CandidateUserMatching extends StatefulWidget {
  const CandidateUserMatching({Key? key}) : super(key: key);

  @override
  State<CandidateUserMatching> createState() => _CandidateUserMatchingState();
}

class _CandidateUserMatchingState extends State<CandidateUserMatching> {
  String card1Image = 'assets/candidateplaceholder.png';
  String card2Image = 'assets/candidateplaceholder.png';
  String card3Image = 'assets/candidateplaceholder.png';
  int cardNum = 4;
  final List<bool> _selections = List.generate(3, (_)=>false );
  Color full = const Color(0xFFF3D433);
  Color empty = const Color(0xFF808080);
  Color local = const Color(0xFF808080);
  Color state = const Color(0xFF808080);
  Color federal = const Color(0xFF808080);

  SwipeableCardSectionController _cardController = SwipeableCardSectionController();

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
  Widget newCard(int card) {
    return Card(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 210,
            width: 300,
            child: Image(
              image: AssetImage(
                card1Image,
              ),
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "CANDIDATE ${card}",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
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
          Row(
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
          SwipeableCardsSection(
            cardController: _cardController,
            context: context,
            items: [
              newCard(1),
              newCard(2),
              newCard(3),
            ],
            onCardSwiped: (dir, index, widget) {
              _cardController.addItem(newCard(cardNum));
              setState(() {
                cardNum++;
              });
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
    );
  }
}
