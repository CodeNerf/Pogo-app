import 'package:flutter/material.dart';
import 'amplifyFunctions.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class VoterGuide extends StatefulWidget {
  const VoterGuide({Key? key}) : super(key: key);
  @override
  _VoterGuideState createState() => _VoterGuideState();
}

class _VoterGuideState extends State<VoterGuide> {
List<bool> _isChecked = [false, false, false, false];



  void _toggleChecked(int index) {
    setState(() {
      _isChecked[index] = !_isChecked[index];
    });
  }
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
              style: TextStyle(fontSize: 30.0,
              fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
      
           new Stack(
      children: <Widget>[

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
          child: Text("[DIsplay Name]",style: TextStyle(fontSize: 22.0,
              fontWeight: FontWeight.bold, color: Colors.white),),
        ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 190,
                    height: 300.0,
                    margin: const EdgeInsets.only(left: 8.0),
                 padding: const EdgeInsets.only(top: 60),
                    child: Card(
                                elevation: 3,

                       shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'REGISTERED',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey
                            ),
                          ),
                          Text(
                            'NY',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Since 2015',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                                                            color: Colors.grey

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

        Container(

          width: 190.0,
          height: 300.0,
                    margin: const EdgeInsets.only(right: 8.0),
                  padding: const EdgeInsets.only(top: 60),
                    child: Card(
                                elevation: 3,

                        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                         Text(
                            'POLLING LOCATION',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey
                            ),
                          ),
                          Text(
                            'PS. 59',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '159 Throop ave',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                                                            color: Colors.black

                            ),
                          ),
                           Text(
                            'Brooklyn, NY 11206',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                                                            color: Colors.black

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                
              ],

            ),
          const SizedBox(height: 50.0), // Adds white space below cards
          
        ]   

    ),
            const SizedBox(height: 16.0),
            
      
  const Text(
              'CHECKLIST',
                textAlign: TextAlign.left,
              style: TextStyle(fontSize: 30.0,
              fontWeight: FontWeight.bold
     ),
            ),

                    const SizedBox(height: 10.0),

    InkWell(
      onTap: () => launchUrl(Uri.parse('https://mvic.sos.state.mi.us/AVApplication/Index')),
      child: Text(
        'Request an absentee ballot?',
        style: TextStyle(decoration: TextDecoration.underline, color: Colors.grey),
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
            title: const Text('Who is on your ballot?', style: TextStyle(fontSize: 18.0,
              fontWeight: FontWeight.bold
     ),),
            value: _isChecked[0],
            onChanged: (value) => _toggleChecked(0),
                      subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('4 Positions', style: TextStyle(fontSize: 12.0,)),
                    Divider(
              color: Colors.grey
            ),
                    Text('Latest Activity [yMMMd]', style: TextStyle(fontSize: 12.0,)),
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

            title: const Text('Personaize your ballot', style: TextStyle(fontSize: 18.0,
              fontWeight: FontWeight.bold
     ), ),
           subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('3 Easy Steps', style: TextStyle(fontSize: 12.0,)),
                        Divider(
              color: Colors.grey
            ),
                    Text('Latest Activity Mon, 24 4:00 pm', style: TextStyle(fontSize: 12.0,)),
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

            title: const Text('Set a reminder', style: TextStyle(fontSize: 18.0,
              fontWeight: FontWeight.bold
     ),),
             subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('2 Quick Steps', style: TextStyle(fontSize: 12.0,)),
                       Divider(
              color: Colors.grey
            ),
                    Text('Latest Activity Mon, 24 4:00 pm', style: TextStyle(fontSize: 12.0,)),
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
            title: const Text('Share your Ballot & VOTE!', style: TextStyle(fontSize: 18.0,
              fontWeight: FontWeight.bold
     ),),
            subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vote Informed', style: TextStyle(fontSize: 12.0,)),
                        Divider(
              color: Colors.grey
            ),
                    Text('Latest Activity Mon, 24 4:00 pm', style: TextStyle(fontSize: 12.0,)),
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

