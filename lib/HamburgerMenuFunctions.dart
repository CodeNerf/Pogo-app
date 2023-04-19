import 'package:url_launcher/url_launcher.dart';

class HamburgerMenuFunctions {
  static void registerToVote(String stateInitial) {
    String url = '';
    switch (stateInitial) {
      case 'AL':
                          launchUrl(Uri.parse('https://www.alabamainteractive.org/sos/voter_registration/instructions.action;wsuid=FBA8B8BE9DEDA1EFECF00BC8B12A3A45'));
                          break;
                          case 'AK':
                          launchUrl(Uri.parse('https://voterregistration.alaska.gov/Registration/RegistrationDetails?haveValidAKDL=true'));
                          break;
                          case 'AZ':
                          launchUrl(Uri.parse('https://servicearizona.com/VoterRegistration/selectLanguage'));
                          break;
                          case 'AR':
                          launchUrl(Uri.parse('https://www.sos.arkansas.gov/elections/voter-information/voter-registration-information/'));
                          break;
                          case 'CA':
                          launchUrl(Uri.parse('https://registertovote.ca.gov/'));
                          break;
                          case 'CO':
                          launchUrl(Uri.parse('https://www.sos.state.co.us/voter/pages/pub/olvr/verifyNewVoter.xhtml'));
                          break;
                          case 'CT':
                          launchUrl(Uri.parse('https://voterregistration.ct.gov/OLVR/welcome.do'));
                          break;
                          case 'DE':
                          launchUrl(Uri.parse('https://ivote.de.gov/VoterView'));
                          break;
                          case 'FL':
                          launchUrl(Uri.parse('https://registertovoteflorida.gov/home'));
                          break;
                          case 'GA':
                          launchUrl(Uri.parse('https://mvp.sos.ga.gov/s/voter-registration?IsRegisterNow=true#no-back-button'));
                          break;
                          case 'HI':
                          launchUrl(Uri.parse('https://olvr.hawaii.gov/register.aspx'));
                          break;
                          case 'ID':
                          launchUrl(Uri.parse('https://elections.sos.idaho.gov/ElectionLink/ElectionLink/ApplicationInstructions.aspx'));
                          break;
                          case 'IL':
                          launchUrl(Uri.parse('https://ova.elections.il.gov/Step0.aspx'));
                          break;
                          case 'IN':
                          launchUrl(Uri.parse('https://indianavoters.in.gov/'));
                          break;
                          case 'IA':
                          launchUrl(Uri.parse('https://sos.iowa.gov/elections/voterinformation/voterregistration.html'));
                          break;
                          case 'KS':
                          launchUrl(Uri.parse('https://www.kdor.ks.gov/Apps/VoterReg/Default.aspx'));
                          break;
                          case 'KY':
                          launchUrl(Uri.parse('https://vrsws.sos.ky.gov/ovrweb/'));
                          break;
                          case 'LA':
                          launchUrl(Uri.parse('https://www.sos.la.gov/ElectionsAndVoting/RegisterToVote/Pages/default.aspx'));
                          break;
                          case 'ME':
                          launchUrl(Uri.parse('https://www1.maine.gov/portal/government/edemocracy/voter_lookup.php'));
                          break;
                          case 'MD':
                          launchUrl(Uri.parse('https://voterservices.elections.maryland.gov/OnlineVoterRegistration/VoterType'));
                          break;
                          case 'MA':
                          launchUrl(Uri.parse(' https://www.sec.state.ma.us/ovr/'));
                          break;
                          case 'MI':
                          launchUrl(Uri.parse('https://mvic.sos.state.mi.us/RegisterVoter'));
                          break;
                          case 'MN':
                          launchUrl(Uri.parse('https://mnvotes.sos.state.mn.us/VoterRegistration/VoterRegistrationMain.aspx'));
                          break;
                          case 'MS':
                          launchUrl(Uri.parse('https://www.sos.ms.gov/Vote/Pages/default.aspx'));
                          break;
                          case 'MO':
                          launchUrl(Uri.parse('https://s1.sos.mo.gov/elections/goVoteMissouri/register.aspx'));
                          break;
                          case 'MT':
                          launchUrl(Uri.parse('https://sosmt.gov/elections/vote/'));
                          break;
                          case 'NE':
                          launchUrl(Uri.parse('https://www.nebraska.gov/apps-sos-voter-registration/'));
                          break;
                          case 'NV':
                          launchUrl(Uri.parse('https://www.nvsos.gov/sosvoterservices/Registration/step1.aspx'));
                          break;
                          case 'NH':
                          launchUrl(Uri.parse('https://www.sos.nh.gov/elections/voters/register-to-vote/'));
                          break;
                          case 'NJ':
                          launchUrl(Uri.parse('https://voter.svrs.nj.gov/register'));
                          break;
                          case 'NM':
                          launchUrl(Uri.parse('https://portal.sos.state.nm.us/OVR/WebPages/InstructionsStep1.aspx'));
                          break;
                          case 'NY':
                          launchUrl(Uri.parse('https://dmv.ny.gov/more-info/electronic-voter-registration-application'));
                          break;
                          case 'NC':
                          launchUrl(Uri.parse('https://www.ncdot.gov/dmv/offices-services/online/Pages/voter-registration-application.aspx'));
                          break;
                          case 'ND':
                          launchUrl(Uri.parse('https://vip.sos.nd.gov/PortalList.aspx'));
                          break;
                          case 'OH	':
                          launchUrl(Uri.parse('https://olvr.ohiosos.gov/'));
                          break;
                          case 'OK':
                          launchUrl(Uri.parse('https://www.ok.gov/elections/OVP.html'));
                          break;
                          case 'OR':
                          launchUrl(Uri.parse('https://sos.oregon.gov/voting/Pages/registration.aspx'));
                          break;
                          case 'PA':
                          launchUrl(Uri.parse('https://www.pavoterservices.pa.gov/Pages/VoterRegistrationApplication.aspx'));
                          break;
                          case 'RI':
                          launchUrl(Uri.parse('https://vote.sos.ri.gov/Home/RegistertoVote'));
                          break;
                          case 'SC':
                          launchUrl(Uri.parse('https://info.scvotes.sc.gov/eng/ovr/start.aspx'));
                          break;
                          case 'SD':
                          launchUrl(Uri.parse('https://sdsos.gov/elections-voting/voting/register-to-vote/default.aspx'));
                          break;
                          case 'TN':
                          launchUrl(Uri.parse('https://sos.tn.gov/products/elections/absentee-voting'));
                          break;
                          case 'TX':
                          launchUrl(Uri.parse('https://ovr.govote.tn.gov/'));
                          break;
                          case 'UT':
                          launchUrl(Uri.parse('https://vote.utah.gov/register-to-vote/'));
                          break;
                          case 'VT':
                          launchUrl(Uri.parse('https://www.sec.state.vt.us/elections/voters/registration.aspx'));
                          break;
                          case 'VA':
                          launchUrl(Uri.parse('https://www.elections.virginia.gov/registration/how-to-register/'));
                          break;
                          case 'WA':
                          launchUrl(Uri.parse('https://www.sos.wa.gov/elections/register.aspx'));
                          break;
                          case 'WV':
                          launchUrl(Uri.parse('https://ovr.sos.wv.gov/Register/Landing'));
                          break;
                          case 'WI':
                          launchUrl(Uri.parse('https://myvote.wi.gov/en-US/RegisterToVote'));
                          break;
                          case 'WY':
                          launchUrl(Uri.parse('https://sos.wyo.gov/Elections/RegisteringtoVote.aspx'));
                          break;
      // Add more cases for other states as needed
    }
    launchUrl(Uri.parse(url));
  }

  static void requestAbsenteeBallot(String stateInitial) {
    String url = '';
    switch (stateInitial) {
      case 'AL':
                          launchUrl(Uri.parse('https://www.sos.alabama.gov/alabama-votes/absentee-ballot-application-by-county'));
                          break;
                          case 'AK':
                          launchUrl(Uri.parse('https://absenteeballotapplication.alaska.gov/'));
                          break;
                          case 'AZ':
                          launchUrl(Uri.parse('https://my.arizona.vote/Early/ApplicationLogin.aspx'));
                          break;
                          case 'AR':
                          launchUrl(Uri.parse('https://www.sos.arkansas.gov/elections/voter-information/absentee-voting'));
                          break;
                          case 'CA':
                          launchUrl(Uri.parse('https://www.sos.ca.gov/elections/voter-registration/vote-mail'));
                          break;
                          case 'CO':
                          launchUrl(Uri.parse('https://www.sos.state.co.us/pubs/elections/FAQs/mailBallotsFAQ.html'));
                          break;
                          case 'CT':
                          launchUrl(Uri.parse('https://portal.ct.gov/SOTS/Election-Services/Voter-Information/Absentee-Voting'));
                          break;
                          case 'DE':
                          launchUrl(Uri.parse('https://elections.delaware.gov/services/voter/absentee/index.shtml'));
                          break;
                          case 'FL':
                          launchUrl(Uri.parse('https://www.myfloridaelections.com/Voting-Elections/Ways-to-Vote/Vote-by-Mail-Absentee-Ballots'));
                          break;
                          case 'GA':
                          launchUrl(Uri.parse('https://securemyabsenteeballot.sos.ga.gov/s/'));
                          break;
                          case 'HI':
                          launchUrl(Uri.parse('https://elections.hawaii.gov/voting/absentee-voting/'));
                          break;
                          case 'ID':
                          launchUrl(Uri.parse('https://elections.sos.idaho.gov/ElectionLink/ElectionLink/BeginAbsenteeRequest.aspx'));
                          break;
                          case 'IL':
                          launchUrl(Uri.parse('https://www.elections.il.gov/ElectionOperations/VotingByMail.aspx'));
                          break;
                          case 'IN':
                          launchUrl(Uri.parse('https://www.in.gov/sos/elections/voter-information/ways-to-vote/absentee-voting/'));
                          break;
                          case 'IA':
                          launchUrl(Uri.parse('https://sos.iowa.gov/elections/electioninfo/absenteeinfo.html'));
                          break;
                          case 'KS':
                          launchUrl(Uri.parse('https://sos.ks.gov/elections/voter-information.html'));
                          break;
                          case 'KY':
                          launchUrl(Uri.parse('https://elect.ky.gov/Voters/Pages/Absentee-Voting-By-Mail.aspx'));
                          break;
                          case 'LA':
                          launchUrl(Uri.parse('https://www.sos.la.gov/ElectionsAndVoting/Vote/VoteByMail/Pages/default.aspx'));
                          break;
                          case 'ME':
                          launchUrl(Uri.parse('https://www.maine.gov/sos/cec/elec/voter-info/absent.html'));
                          break;
                          case 'MD':
                          launchUrl(Uri.parse('https://elections.maryland.gov/voting/absentee.html'));
                          break;
                          case 'MA':
                          launchUrl(Uri.parse('https://www.sec.state.ma.us/divisions/elections/voting-information/absentee-voting.htm'));
                          break;
                          case 'MI':
                          launchUrl(Uri.parse('https://mvic.sos.state.mi.us/avapplication'));
                          break;
                          case 'MN':
                          launchUrl(Uri.parse('https://www.sos.state.mn.us/elections-voting/other-ways-to-vote/vote-early-by-mail/'));
                          break;
                          case 'MS':
                          launchUrl(Uri.parse('https://www.sos.ms.gov/absentee-voting-information'));
                          break;
                          case 'MO':
                          launchUrl(Uri.parse('https://www.sos.mo.gov/elections/goVoteMissouri/howtovote#Absentee'));
                          break;
                          case 'MT':
                          launchUrl(Uri.parse('https://sosmt.gov/elections/absentee/'));
                          break;
                          case 'NE':
                          launchUrl(Uri.parse('https://sos.nebraska.gov/elections/early-voting'));
                          break;
                          case 'NV':
                          launchUrl(Uri.parse('https://www.nvsos.gov/votersearch/index.aspx'));
                          break;
                          case 'NH':
                          launchUrl(Uri.parse('https://www.sos.nh.gov/elections/voters/absentee-ballots/request-absentee-ballot'));
                          break;
                          case 'NJ':
                          launchUrl(Uri.parse('https://www.state.nj.us/state/elections/vote-by-mail.shtml'));
                          break;
                          case 'NM':
                          launchUrl(Uri.parse('https://portal.sos.state.nm.us/OVR/WebPages/AbsenteeApplication.aspx'));
                          break;
                          case 'NY':
                          launchUrl(Uri.parse('https://www.elections.ny.gov/VotingAbsentee.html'));
                          break;
                          case 'NC':
                          launchUrl(Uri.parse('https://votebymail.ncsbe.gov/app/absentee/lookup'));
                          break;
                          case 'ND':
                          launchUrl(Uri.parse('https://vip.sos.nd.gov/absentee'));
                          break;
                          case 'OH	':
                          launchUrl(Uri.parse('https://www.ohiosos.gov/elections/voters/absentee-voting/'));
                          break;
                          case 'OK':
                          launchUrl(Uri.parse('https://oklahoma.gov/elections/voters/absentee-voting.html'));
                          break;
                          case 'OR':
                          launchUrl(Uri.parse('https://sos.oregon.gov/elections/documents/sel111.pdf'));
                          break;
                          case 'PA':
                          launchUrl(Uri.parse('https://www.pavoterservices.pa.gov/onlineabsenteeapplication/#/OnlineAbsenteeBegin'));
                          break;
                          case 'RI':
                          launchUrl(Uri.parse('https://elections.ri.gov/voting/applymail.php'));
                          break;
                          case 'SC':
                          launchUrl(Uri.parse('https://scvotes.gov/voters/absentee-voting/'));
                          break;
                          case 'SD':
                          launchUrl(Uri.parse('https://sdsos.gov/elections-voting/voting/absentee-voting.aspx'));
                          break;
                          case 'TN':
                          launchUrl(Uri.parse('https://sos.tn.gov/elections/services/absentee-voting'));
                          break;
                          case 'TX':
                          launchUrl(Uri.parse('https://www.sos.texas.gov/elections/voter/reqabbm.shtml'));
                          break;
                          case 'UT':
                          launchUrl(Uri.parse('https://vote.utah.gov/learn-about-voting-by-mail-and-absentee-voting/'));
                          break;
                          case 'VT':
                          launchUrl(Uri.parse('https://sos.vermont.gov/elections/voters/early-absentee-voting/'));
                          break;
                          case 'VA':
                          launchUrl(Uri.parse('https://www.elections.virginia.gov/citizen-portal/'));
                          break;
                          case 'WA':
                          launchUrl(Uri.parse('https://www.sos.wa.gov/elections/voters/'));
                          break;
                          case 'WV':
                          launchUrl(Uri.parse('https://sos.wv.gov/FormSearch/Elections/Voter/Absentee%20Ballot%20Application.pdf'));
                          break;
                          case 'WI':
                          launchUrl(Uri.parse('https://myvote.wi.gov/en-us/Vote-Absentee-By-Mail'));
                          break;
                          case 'WY':
                          launchUrl(Uri.parse('https://sos.wyo.gov/elections/state/absenteevoting.aspx'));
                          break;
      // Add more cases for other states as needed
    }
    launchUrl(Uri.parse(url));
  }

  static void voteByMail(String stateInitial) {
    String url = '';
    switch (stateInitial) {
      case 'AL':
                          launchUrl(Uri.parse('https://www.sos.alabama.gov/alabama-votes/absentee-ballot-application-by-county'));
                          break;
                          case 'AK':
                          launchUrl(Uri.parse('https://absenteeballotapplication.alaska.gov/'));
                          break;
                          case 'AZ':
                          launchUrl(Uri.parse('https://my.arizona.vote/Early/ApplicationLogin.aspx'));
                          break;
                          case 'AR':
                          launchUrl(Uri.parse('https://www.sos.arkansas.gov/elections/voter-information/absentee-voting'));
                          break;
                          case 'CA':
                          launchUrl(Uri.parse('https://www.sos.ca.gov/elections/voter-registration/vote-mail'));
                          break;
                          case 'CO':
                          launchUrl(Uri.parse('https://www.sos.state.co.us/pubs/elections/FAQs/mailBallotsFAQ.html'));
                          break;
                          case 'CT':
                          launchUrl(Uri.parse('https://portal.ct.gov/SOTS/Election-Services/Voter-Information/Absentee-Voting'));
                          break;
                          case 'DE':
                          launchUrl(Uri.parse('https://elections.delaware.gov/services/voter/absentee/index.shtml'));
                          break;
                          case 'FL':
                          launchUrl(Uri.parse('https://www.myfloridaelections.com/Voting-Elections/Ways-to-Vote/Vote-by-Mail-Absentee-Ballots'));
                          break;
                          case 'GA':
                          launchUrl(Uri.parse('https://ballotrequest.sos.ga.gov/'));
                          break;
                          case 'HI':
                          launchUrl(Uri.parse('https://elections.hawaii.gov/voting/absentee-voting/'));
                          break;
                          case 'ID':
                          launchUrl(Uri.parse('https://elections.sos.idaho.gov/ElectionLink/ElectionLink/BeginAbsenteeRequest.aspx'));
                          break;
                          case 'IL':
                          launchUrl(Uri.parse('https://www.elections.il.gov/ElectionOperations/VotingByMail.aspx'));
                          break;
                          case 'IN':
                          launchUrl(Uri.parse('https://www.in.gov/sos/elections/voter-information/ways-to-vote/absentee-voting/'));
                          break;
                          case 'IA':
                          launchUrl(Uri.parse('https://sos.iowa.gov/elections/electioninfo/absenteeinfo.html'));
                          break;
                          case 'KS':
                          launchUrl(Uri.parse('https://sos.ks.gov/elections/voter-information.html'));
                          break;
                          case 'KY':
                          launchUrl(Uri.parse('https://elect.ky.gov/Voters/Pages/Absentee-Voting-By-Mail.aspx'));
                          break;
                          case 'LA':
                          launchUrl(Uri.parse('https://www.sos.la.gov/ElectionsAndVoting/Vote/VoteByMail/Pages/default.aspx'));
                          break;
                          case 'ME':
                          launchUrl(Uri.parse('https://www.maine.gov/sos/cec/elec/voter-info/absent.html'));
                          break;
                          case 'MD':
                          launchUrl(Uri.parse('https://elections.maryland.gov/voting/absentee.html'));
                          break;
                          case 'MA':
                          launchUrl(Uri.parse('https://www.sec.state.ma.us/ele/eleabsentee/absidx.htm'));
                          break;
                          case 'MI':
                          launchUrl(Uri.parse('https://mvic.sos.state.mi.us/avapplication'));
                          break;
                          case 'MN':
                          launchUrl(Uri.parse('https://www.sos.state.mn.us/elections-voting/other-ways-to-vote/vote-early-by-mail/'));
                          break;
                          case 'MS':
                          launchUrl(Uri.parse('https://www.sos.ms.gov/Vote/Pages/default.aspx'));
                          break;
                          case 'MO':
                          launchUrl(Uri.parse('https://www.sos.mo.gov/elections/goVoteMissouri/howtovote#Absentee'));
                          break;
                          case 'MT':
                          launchUrl(Uri.parse('https://sosmt.gov/elections/absentee/'));
                          break;
                          case 'NE':
                          launchUrl(Uri.parse('https://sos.nebraska.gov/elections/early-voting'));
                          break;
                          case 'NV':
                          launchUrl(Uri.parse('https://www.nvsos.gov/votersearch/index.aspx'));
                          break;
                          case 'NH':
                          launchUrl(Uri.parse('https://www.sos.nh.gov/elections/voters/absentee-ballots/request-absentee-ballot'));
                          break;
                          case 'NJ':
                          launchUrl(Uri.parse('https://www.nj.gov/state/elections/vote-by-mail.shtml'));
                          break;
                          case 'NM':
                          launchUrl(Uri.parse('https://portal.sos.state.nm.us/OVR/WebPages/AbsenteeApplication.aspx'));
                          break;
                          case 'NY':
                          launchUrl(Uri.parse('https://www.elections.ny.gov/VotingAbsentee.html'));
                          break;
                          case 'NC':
                          launchUrl(Uri.parse('https://www.ncsbe.gov/voting/vote-mail'));
                          break;
                          case 'ND':
                          launchUrl(Uri.parse('https://vip.sos.nd.gov/absentee'));
                          break;
                          case 'OH	':
                          launchUrl(Uri.parse('https://www.ohiosos.gov/elections/voters/absentee-voting/'));
                          break;
                          case 'OK':
                          launchUrl(Uri.parse('https://www.ok.gov/elections/Voter_Info/Absentee_Voting/'));
                          break;
                          case 'OR':
                          launchUrl(Uri.parse('https://sos.oregon.gov/voting/Pages/Mail-in-Voting.aspx'));
                          break;
                          case 'PA':
                          launchUrl(Uri.parse('https://www.votespa.com/Voting-in-PA/Pages/Mail-and-Absentee-Ballot.aspx'));
                          break;
                          case 'RI':
                          launchUrl(Uri.parse('https://vote.sos.ri.gov/Home/UpdateVoterRecord?ActiveFlag=2'));
                          break;
                          case 'SC':
                          launchUrl(Uri.parse('https://www.scvotes.gov/absentee-voting'));
                          break;
                          case 'SD':
                          launchUrl(Uri.parse('https://sdsos.gov/elections-voting/voting/absentee-voting.aspx'));
                          break;
                          case 'TN':
                          launchUrl(Uri.parse('https://sos.tn.gov/elections/services/absentee-voting'));
                          break;
                          case 'TX':
                          launchUrl(Uri.parse('https://www.sos.texas.gov/elections/voter/reqabbm.shtml'));
                          break;
                          case 'UT':
                          launchUrl(Uri.parse('https://vote.utah.gov/vote-by-mail/'));
                          break;
                          case 'VT':
                          launchUrl(Uri.parse('https://sos.vermont.gov/elections/voters/early-absentee-voting/'));
                          break;
                          case 'VA':
                          launchUrl(Uri.parse('https://www.elections.virginia.gov/casting-a-ballot/absentee-voting/'));
                          break;
                          case 'WA':
                          launchUrl(Uri.parse('https://www.sos.wa.gov/elections/voters/mail-ballot-voting.aspx'));
                          break;
                          case 'WV':
                          launchUrl(Uri.parse('https://sos.wv.gov/elections/Pages/AbsenteeVotingInformation.aspx'));
                          break;
                          case 'WI':
                          launchUrl(Uri.parse('https://elections.wi.gov/voters/absentee'));
                          break;
                          case 'WY':
                          launchUrl(Uri.parse('https://sos.wyo.gov/elections/state/absenteevoting.aspx'));
                          break;
      // Add more cases for other states as needed
    }
    launchUrl(Uri.parse(url));
  }

  static void updateRegistration(String stateInitial) {
    String url = '';
    switch (stateInitial) {
                         case 'AL':
                      launchUrl(Uri.parse('https://www.alabamavotes.gov/olvr/default.aspx'));
                      break;
                      case 'AK':
                      launchUrl(Uri.parse('https://voterregistration.alaska.gov/'));
                      break;
                      case 'AZ':
                      launchUrl(Uri.parse('https://servicearizona.com/voterRegistration?popularclick'));
                      break;
                      case 'AR':
                      launchUrl(Uri.parse('https://www.sos.arkansas.gov/elections/voter-information/voter-registration-information'));
                      break;
                      case 'CA':
                      launchUrl(Uri.parse('https://registertovote.ca.gov/'));
                      break;
                      case 'CO':
                      launchUrl(Uri.parse('https://www.sos.state.co.us/voter/pages/pub/home.xhtml'));
                      break;
                      case 'CT':
                      launchUrl(Uri.parse('https://voterregistration.ct.gov/OLVR/welcome.do'));
                      break;
                      case 'DE':
                      launchUrl(Uri.parse('https://elections.delaware.gov/voter/voteabsentee.shtml'));
                      break;
                      case 'FL':
                      launchUrl(Uri.parse('https://registertovoteflorida.gov/home'));
                      break;
                      case 'GA':
                      launchUrl(Uri.parse('https://registertovote.sos.ga.gov/GAOLVR/welcome.do#no-back-button'));
                      break;
                      case 'HI':
                      launchUrl(Uri.parse('https://olvr.hawaii.gov/'));
                      break;
                      case 'ID':
                      launchUrl(Uri.parse('https://idahovotes.gov/online-voter-registration/'));
                      break;
                      case 'IL':
                      launchUrl(Uri.parse('https://ova.elections.il.gov/'));
                      break;
                      case 'IN':
                      launchUrl(Uri.parse('https://indianavoters.in.gov/'));
                      break;
                      case 'IA':
                      launchUrl(Uri.parse('https://sos.iowa.gov/elections/voterinformation/voterregistration.html'));
                      break;
                      case 'KS':
                      launchUrl(Uri.parse('https://www.kdor.ks.gov/Apps/VoterReg/Default.aspx'));
                      break;
                      case 'KY':
                      launchUrl(Uri.parse('https://vrsws.sos.ky.gov/ovrweb/default'));
                      break;
                      case 'LA':
                      launchUrl(Uri.parse('https://voterportal.sos.la.gov/'));
                      break;
                      case 'ME':
                      launchUrl(Uri.parse('https://www1.maine.gov/portal/government/edemocracy/voter_lookup.php'));
                      break;
                      case 'MD':
                      launchUrl(Uri.parse('https://voterservices.elections.maryland.gov/OnlineVoterRegistration/VoterType'));
                      break;
                      case 'MA':
                      launchUrl(Uri.parse('https://www.sec.state.ma.us/ovr/'));
                      break;
                      case 'MI':
                      launchUrl(Uri.parse('https://mvic.sos.state.mi.us/RegisterVoter'));
                      break;
                      case 'MN':
                      launchUrl(Uri.parse('https://mnvotes.sos.state.mn.us/VoterRegistration/VoterRegistrationMain.aspx'));
                      break;
                      case 'MS':
                      launchUrl(Uri.parse('https://www.sos.ms.gov/Vote/Pages/default.aspx'));
                      break;
                      case 'MO':
                      launchUrl(Uri.parse('https://www.sos.mo.gov/elections/goVoteMissouri/register'));
                      break;
                      case 'MT':
                      launchUrl(Uri.parse('https://sosmt.gov/elections/vote'));
                      break;
      
                          case 'NE':
                          launchUrl(Uri.parse('https://www.nebraska.gov/apps-sos-voter-registration/'));
                          break;
                          case 'NV':
                          launchUrl(Uri.parse('https://www.nvsos.gov/sosvoterservices/Registration/Step0.aspx'));
                          break;
                          case 'NH':
                          launchUrl(Uri.parse('https://www.sos.nh.gov/elections/voters/register-to-vote/'));
                          break;
                          case 'NJ':
                          launchUrl(Uri.parse('https://www.state.nj.us/state/elections/voter-registration.shtml'));
                          break;
                          case 'NM':
                          launchUrl(Uri.parse('https://portal.sos.state.nm.us/OVR/WebPages/InstructionsStep1.aspx'));
                          break;
                          case 'NY':
                          launchUrl(Uri.parse('https://www.ny.gov/services/register-vote'));
                          break;
                          case 'NC':
                          launchUrl(Uri.parse('https://www.ncsbe.gov/registering/how-register/register-person-same-day-registration'));
                          break;
                          case 'ND':
                          launchUrl(Uri.parse('https://vip.sos.nd.gov/PortalList.aspx'));
                          break;
                          case 'OH	':
                          launchUrl(Uri.parse('https://olvr.ohiosos.gov/'));
                          break;
                          case 'OK':
                          launchUrl(Uri.parse('https://www.ok.gov/elections/Voter_Info/Register_to_Vote/index.html'));
                          break;
                          case 'OR':
                          launchUrl(Uri.parse('https://sos.oregon.gov/voting/Pages/registration.aspx'));
                          break;
                          case 'PA':
                          launchUrl(Uri.parse('https://www.pavoterservices.pa.gov/Pages/VoterRegistrationApplication.aspx'));
                          break;
                          case 'RI':
                          launchUrl(Uri.parse('https://vote.sos.ri.gov/Home/RegistertoVote'));
                          break;
                          case 'SC':
                          launchUrl(Uri.parse('https://info.scvotes.sc.gov/eng/ovr/start.aspx'));
                          break;
                          case 'SD':
                          launchUrl(Uri.parse('https://sdsos.gov/elections-voting/voting/register-to-vote/default.aspx'));
                          break;
                          case 'TN':
                          launchUrl(Uri.parse('https://sos.tn.gov/products/elections/absentee-voting'));
                          break;
                          case 'TX':
                          launchUrl(Uri.parse('https://www.votetexas.gov/register-to-vote/'));
                          break;
                          case 'UT':
                          launchUrl(Uri.parse('https://secure.utah.gov/voterreg/index.html'));
                          break;
                          case 'VT':
                          launchUrl(Uri.parse('https://olvr.vermont.gov/'));
                          break;
                          case 'VA':
                          launchUrl(Uri.parse('https://www.elections.virginia.gov/registration/how-to-register/'));
                          break;
                          case 'WA':
                          launchUrl(Uri.parse('https://www.sos.wa.gov/elections/register.aspx'));
                          break;
                          case 'WV':
                          launchUrl(Uri.parse('https://ovr.sos.wv.gov/Register/Landing'));
                          break;
                          case 'WI':
                          launchUrl(Uri.parse('https://myvote.wi.gov/en-US/RegisterToVote'));
                          break;
                          case 'WY':
                          launchUrl(Uri.parse('https://sos.wyo.gov/Elections/RegisteringtoVote.aspx'));
                          break;
      // Add more cases for other states as needed
    }
    launchUrl(Uri.parse(url));
  }
}