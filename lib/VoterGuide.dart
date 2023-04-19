import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import 'package:pogo/googleFunctions/CivicFunctions.dart';
import 'package:pogo/googleFunctions/CivicModels.dart';
import 'package:url_launcher/url_launcher.dart';

class VoterGuide extends StatefulWidget {
  UserDemographics user;
  VoterGuide({Key? key, required this.user}) : super(key: key);
  @override
  State<VoterGuide> createState() => _VoterGuideState();
}

class _VoterGuideState extends State<VoterGuide> {
  List<bool> _isChecked = [false, false, false, false];
  late List<PollingLocation> _pollingLocations;
  late String stateInitial = "MI";

  @override
  void initState() {
    super.initState();
    List<String> addressParts = widget.user.addressLine1.split(',');
    if (addressParts.length > 1) {
      // String stateZip = addressParts[addressParts.length - 1].trim();
      stateInitial = addressParts[addressParts.length - 2].trim();
    }
    _getPollingLocations();
  }

  void _getPollingLocations() async {
    try {
      _pollingLocations = await getPollingLocation(widget.user.addressLine1);
    } catch (e) {
      safePrint("Error occurred in _getPollingLocations(): $e");
    }
  }

  void _toggleChecked(int index) {
    setState(() {
      _isChecked[index] = !_isChecked[index];
    });
  }

//nypepawy@mailo.icu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            const Text(
              'Voter Guide',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            new Stack(children: <Widget>[
              new Column(
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(top: 50),
                    height: MediaQuery.of(context).size.height * .20,
                    color: const Color(0xFFF3D433),
                  ),
                ],
              ),
              Positioned(
                top: 20.0,
                left: 20.0,
                child: Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 320.0,
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.only(top: 80),
                    child: Card(
                      elevation: 3,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'REGISTERED',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                              color: Color(0xFF57636C),
                            ),
                          ),
                          Text(
                            stateInitial,
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              color: Colors.black,
                            ),
                          ),
                          // Text(
                          //   'Since 2015',
                          //   style: TextStyle(
                          //     fontSize: 15.0,
                          //     fontWeight: FontWeight.w600,
                          //     fontFamily: 'Inter',
                          //     color: Colors.black,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 180.0,
                    height: 320.0,
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(
                      child: Card(
                        elevation: 3,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                'POLLING LOCATION',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                  color: Color(0xFF57636C),
                                ),
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'No Location Assigned',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Text(
                                'Check back later',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Text(''),
                              Text(''),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0), // Adds white space below cards
            ]),
            const SizedBox(height: 16.0),
            const Text(
              'CHECKLIST',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                String url = '';
                switch (stateInitial) {
                  case 'AL':
                    launchUrl(Uri.parse(
                        'https://www.sos.alabama.gov/alabama-votes/absentee-ballot-application-by-county'));
                    break;
                  case 'AK':
                    launchUrl(Uri.parse(
                        'https://absenteeballotapplication.alaska.gov/'));
                    break;
                  case 'AZ':
                    launchUrl(Uri.parse(
                        'https://my.arizona.vote/Early/ApplicationLogin.aspx'));
                    break;
                  case 'AR':
                    launchUrl(Uri.parse(
                        'https://www.sos.arkansas.gov/elections/voter-information/absentee-voting'));
                    break;
                  case 'CA':
                    launchUrl(Uri.parse(
                        'https://www.sos.ca.gov/elections/voter-registration/vote-mail'));
                    break;
                  case 'CO':
                    launchUrl(Uri.parse(
                        'https://www.sos.state.co.us/pubs/elections/FAQs/mailBallotsFAQ.html'));
                    break;
                  case 'CT':
                    launchUrl(Uri.parse(
                        'https://portal.ct.gov/SOTS/Election-Services/Voter-Information/Absentee-Voting'));
                    break;
                  case 'DE':
                    launchUrl(Uri.parse(
                        'https://elections.delaware.gov/services/voter/absentee/index.shtml'));
                    break;
                  case 'FL':
                    launchUrl(Uri.parse(
                        'https://www.myfloridaelections.com/Voting-Elections/Ways-to-Vote/Vote-by-Mail-Absentee-Ballots'));
                    break;
                  case 'GA':
                    launchUrl(Uri.parse(
                        'https://securemyabsenteeballot.sos.ga.gov/s/'));
                    break;
                  case 'HI':
                    launchUrl(Uri.parse(
                        'https://elections.hawaii.gov/voting/absentee-voting/'));
                    break;
                  case 'ID':
                    launchUrl(Uri.parse(
                        'https://elections.sos.idaho.gov/ElectionLink/ElectionLink/BeginAbsenteeRequest.aspx'));
                    break;
                  case 'IL':
                    launchUrl(Uri.parse(
                        'https://www.elections.il.gov/ElectionOperations/VotingByMail.aspx'));
                    break;
                  case 'IN':
                    launchUrl(Uri.parse(
                        'https://www.in.gov/sos/elections/voter-information/ways-to-vote/absentee-voting/'));
                    break;
                  case 'IA':
                    launchUrl(Uri.parse(
                        'https://sos.iowa.gov/elections/electioninfo/absenteeinfo.html'));
                    break;
                  case 'KS':
                    launchUrl(Uri.parse(
                        'https://sos.ks.gov/elections/voter-information.html'));
                    break;
                  case 'KY':
                    launchUrl(Uri.parse(
                        'https://elect.ky.gov/Voters/Pages/Absentee-Voting-By-Mail.aspx'));
                    break;
                  case 'LA':
                    launchUrl(Uri.parse(
                        'https://www.sos.la.gov/ElectionsAndVoting/Vote/VoteByMail/Pages/default.aspx'));
                    break;
                  case 'ME':
                    launchUrl(Uri.parse(
                        'https://www.maine.gov/sos/cec/elec/voter-info/absent.html'));
                    break;
                  case 'MD':
                    launchUrl(Uri.parse(
                        'https://elections.maryland.gov/voting/absentee.html'));
                    break;
                  case 'MA':
                    launchUrl(Uri.parse(
                        'https://www.sec.state.ma.us/divisions/elections/voting-information/absentee-voting.htm'));
                    break;
                  case 'MI':
                    launchUrl(Uri.parse(
                        'https://mvic.sos.state.mi.us/avapplication'));
                    break;
                  case 'MN':
                    launchUrl(Uri.parse(
                        'https://www.sos.state.mn.us/elections-voting/other-ways-to-vote/vote-early-by-mail/'));
                    break;
                  case 'MS':
                    launchUrl(Uri.parse(
                        'https://www.sos.ms.gov/absentee-voting-information'));
                    break;
                  case 'MO':
                    launchUrl(Uri.parse(
                        'https://www.sos.mo.gov/elections/goVoteMissouri/howtovote#Absentee'));
                    break;
                  case 'MT':
                    launchUrl(
                        Uri.parse('https://sosmt.gov/elections/absentee/'));
                    break;
                  case 'NE':
                    launchUrl(Uri.parse(
                        'https://sos.nebraska.gov/elections/early-voting'));
                    break;
                  case 'NV':
                    launchUrl(Uri.parse(
                        'https://www.nvsos.gov/sos/elections/voters/voters-with-disabilities/absentee-voting'));
                    break;
                  case 'NH':
                    launchUrl(Uri.parse(
                        'https://www.sos.nh.gov/elections/voters/absentee-ballots/request-absentee-ballot'));
                    break;
                  case 'NJ':
                    launchUrl(Uri.parse(
                        'https://www.state.nj.us/state/elections/vote-by-mail.shtml'));
                    break;
                  case 'NM':
                    launchUrl(Uri.parse(
                        'https://portal.sos.state.nm.us/OVR/WebPages/AbsenteeApplication.aspx'));
                    break;
                  case 'NY':
                    launchUrl(Uri.parse(
                        'https://www.elections.ny.gov/VotingAbsentee.html'));
                    break;
                  case 'NC':
                    launchUrl(Uri.parse(
                        'https://votebymail.ncsbe.gov/app/absentee/lookup'));
                    break;
                  case 'ND':
                    launchUrl(Uri.parse('https://vip.sos.nd.gov/absentee'));
                    break;
                  case 'OH	':
                    launchUrl(Uri.parse(
                        'https://www.ohiosos.gov/elections/voters/absentee-voting/'));
                    break;
                  case 'OK':
                    launchUrl(Uri.parse(
                        'https://oklahoma.gov/elections/voters/absentee-voting.html'));
                    break;
                  case 'OR':
                    launchUrl(Uri.parse(
                        'https://sos.oregon.gov/elections/documents/sel111.pdf'));
                    break;
                  case 'PA':
                    launchUrl(Uri.parse(
                        'https://www.pavoterservices.pa.gov/onlineabsenteeapplication/#/OnlineAbsenteeBegin'));
                    break;
                  case 'RI':
                    launchUrl(Uri.parse(
                        'https://elections.ri.gov/voting/applymail.php'));
                    break;
                  case 'SC':
                    launchUrl(Uri.parse(
                        'https://scvotes.gov/voters/absentee-voting/'));
                    break;
                  case 'SD':
                    launchUrl(Uri.parse(
                        'https://sdsos.gov/elections-voting/voting/absentee-voting.aspx'));
                    break;
                  case 'TN':
                    launchUrl(Uri.parse(
                        'https://sos.tn.gov/elections/services/absentee-voting'));
                    break;
                  case 'TX':
                    launchUrl(Uri.parse(
                        'https://www.sos.texas.gov/elections/voter/reqabbm.shtml'));
                    break;
                  case 'UT':
                    launchUrl(Uri.parse(
                        'https://vote.utah.gov/learn-about-voting-by-mail-and-absentee-voting/'));
                    break;
                  case 'VT':
                    launchUrl(Uri.parse(
                        'https://sos.vermont.gov/elections/voters/early-absentee-voting/'));
                    break;
                  case 'VA':
                    launchUrl(Uri.parse(
                        'https://www.elections.virginia.gov/citizen-portal/'));
                    break;
                  case 'WA':
                    launchUrl(
                        Uri.parse('https://www.sos.wa.gov/elections/voters/'));
                    break;
                  case 'WV':
                    launchUrl(Uri.parse(
                        'https://sos.wv.gov/FormSearch/Elections/Voter/Absentee%20Ballot%20Application.pdf'));
                    break;
                  case 'WI':
                    launchUrl(Uri.parse(
                        'https://myvote.wi.gov/en-us/Vote-Absentee-By-Mail'));
                    break;
                  case 'WY':
                    launchUrl(Uri.parse(
                        'https://sos.wyo.gov/elections/state/absenteevoting.aspx'));
                    break;
                }
                launchUrl(Uri.parse(url));
              },
              child: Text(
                'Request an absentee ballot in $stateInitial?',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(right: 15.0, left: 15),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'Who is on your ballot?',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    value: _isChecked[0],
                    onChanged: (value) => _toggleChecked(0),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('4 Positions',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        Divider(color: Colors.grey),
                        Text('',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(right: 15.0, left: 15),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'Personaize your ballot',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('3 Easy Steps',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        Divider(color: Colors.grey),
                        Text('',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                    value: _isChecked[1],
                    onChanged: (value) => _toggleChecked(1),
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(right: 15.0, left: 15),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'Set a reminder',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2 Quick Steps',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        Divider(color: Colors.grey),
                        Text('',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                    value: _isChecked[2],
                    onChanged: (value) => _toggleChecked(2),
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(right: 15.0, left: 15),
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'Share your Ballot & VOTE!',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vote Informed',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        Divider(color: Colors.grey),
                        Text('',
                            style: TextStyle(
                              fontSize: 12.0,
                            )),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                    value: _isChecked[3],
                    onChanged: (value) => _toggleChecked(3),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
