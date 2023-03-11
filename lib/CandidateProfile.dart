import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pogo/dynamoModels/CandidateIssueFactorValues.dart';
import 'dynamoModels/CandidateDemographics.dart';

class CandidateProfile extends StatefulWidget {
  final CandidateDemographics candidate;
  final CandidateIssueFactorValues candidateValues;
  const CandidateProfile({Key? key, required this.candidate, required this.candidateValues}) : super(key: key);

  @override
  State<CandidateProfile> createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';

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
  String _candidateExperience(String careerStart) {
    print(careerStart);
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

 Color _candidateColor(String party) {
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

  List<Widget> _getRatingCircles() {
    List<Widget> circles = [];
    circles.add(Column(children: [_ratingCircles('Education\n', widget.candidateValues.educationScore), _ratingCircles('Care', widget.candidateValues.educationWeight)],));
    circles.add(Column(children: [_ratingCircles('Climate\n', widget.candidateValues.climateScore), _ratingCircles('Care', widget.candidateValues.climateWeight)],));
    circles.add(Column(children: [_ratingCircles('Drug Policy\n', widget.candidateValues.drugPolicyScore), _ratingCircles('Care', widget.candidateValues.drugPolicyWeight)],));
    circles.add(Column(children: [_ratingCircles('Economy\n', widget.candidateValues.economyScore), _ratingCircles('Care', widget.candidateValues.economyWeight)],));
    circles.add(Column(children: [_ratingCircles('Healthcare\n', widget.candidateValues.healthcareScore), _ratingCircles('Care', widget.candidateValues.healthcareWeight)],));
    circles.add(Column(children: [_ratingCircles('Immigration\n', widget.candidateValues.immigrationScore), _ratingCircles('Care', widget.candidateValues.immigrationWeight)],));
    circles.add(Column(children: [_ratingCircles('Policing\n', widget.candidateValues.policingScore), _ratingCircles('Care', widget.candidateValues.policingWeight)],));
    circles.add(Column(children: [_ratingCircles('Reproductive\nHealth', widget.candidateValues.reproductiveScore), _ratingCircles('Care', widget.candidateValues.reproductiveWeight)],));
    circles.add(Column(children: [_ratingCircles('Gun Control\n', widget.candidateValues.gunPolicyScore), _ratingCircles('Care', widget.candidateValues.gunPolicyWeight)],));
    circles.add(Column(children: [_ratingCircles('Housing\n', widget.candidateValues.housingScore), _ratingCircles('Care', widget.candidateValues.housingWeight)],));
    return circles;
  }

  Widget _ratingCircles(String name, num rating) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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

@override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image(
          image: AssetImage(_pogoLogo),
          width: 150,
        ),
      ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: _candidateColor(widget.candidate.politicalAffiliation),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProfileAvatar(
                '',
                radius: 85,
                elevation: 5,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image(
                    image: NetworkImage(widget.candidate.profileImageURL),
                  ),
                ),
              ),
            ],
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
                            'Michigan ${widget.candidate.zipCode}',
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
                              widget.candidate.politicalAffiliation,
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
    const Center(
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Views on Political Issues',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _getRatingCircles(),
                        ),
                      ),
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
            const SizedBox(height: 15),
            Center(
              child: Text(
                      _candidateExperience(widget.candidate.careerStartDate),
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