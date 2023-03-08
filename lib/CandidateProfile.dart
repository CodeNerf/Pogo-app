import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'dynamoModels/CandidateDemographics.dart';

class CandidateProfile extends StatefulWidget {
  final CandidateDemographics candidate;

  const CandidateProfile({Key? key, required this.candidate}) : super(key: key);

  @override
  _CandidateProfileState createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      experience = '$years years of experience';
    }
    else if(days > 29) {
      //months
      int months = days ~/ 30;
      experience = '$months months of experience';
    }
    else {
      experience = '$days days of experience';
    }
    return experience;
  }

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

Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
         
 Container(
  decoration: BoxDecoration(
    color: candidateColor(widget.candidate.politicalAffiliation),
  ),
  child: Padding(
    padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.26,
      child: CircularProfileAvatar(
        '',
        radius: 85,
        elevation: 1,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image(
            image: NetworkImage(widget.candidate.profileImageURL),
          ),
        ),
      ),
    ),
  ),
),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.candidate.firstName} ${widget.candidate.lastName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            ),
                          ),
                          Text(
                            'Michigan MI ${widget.candidate.zipCode}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
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
                              '${widget.candidate.politicalAffiliation}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             Container(
  padding: const EdgeInsets.all(0),
  decoration: BoxDecoration(
    color: Colors.white,
  ),
  child: TabBar(
    controller: _tabController,
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey,
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
 Center(
  child: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Lorem ipsum dolor sit amet. Eum quia saepe aut sint fugit ut nihil sunt quo placeat voluptatem non sunt veritatis est doloribus mollitia. Ex possimus quam ut perspiciatis reprehenderit est sunt consequuntur in obcaecati voluptas et necessitatibus quos. Et maxime voluptatum et omnis delectus et enim quas et libero animi eum rerum suscipit a perspiciatis velit ut voluptatem officia. Et nulla incidunt ab dolor magni sit quae voluptatem aut omnis enim rem necessitatibus alias non reprehenderit dolor vel laudantium quia.Qui officiis asperiores aut doloribus deleniti sit incidunt enim At accusantium deserunt et vero modi? Est distinctio internos et asperiores explicabo id vitae laborum et dolor error eos pariatur nesciunt et nulla quia aut eius autem. At laboriosam repudiandae ut consequatur reprehenderit aut repellat nisi cum aperiam architecto a molestias fugit. Aut tenetur recusandae a vero enim quo nihil laboriosam. Ut iusto labore qui galisum autem et nisi nesciunt qui voluptatem galisum qui voluptatibus maiores.',
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    ),
  ),
),
    // Second tab content (Experience)
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                    ],
                  ),
                ),
              ],
            ),
        
  ]),
      ),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5),
           
            SizedBox(height: 10),
            Center(
              child: Text(
                      candidateExperience(widget.candidate.careerStartDate),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),)
          ],
        ),
      ),
    ),
  ],
)

),
]))]));}}