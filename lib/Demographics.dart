import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'LandingPage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

class Demographics extends StatefulWidget {
  const Demographics({Key? key}) : super(key: key);

  @override
  State<Demographics> createState() => _DemographicsState();
}
class _DemographicsState extends State<Demographics> {
 String surveyPogoLogo = 'assets/Pogo_logo_horizontal.png';
final items = ['18 - 25 years old', '26 - 35 years old', '36 - 55 years old', '56+ years old'];

String? value;
  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem (String item)=>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle( fontSize: 20),
        ),
        );
          
    return Scaffold(
      appBar: AppBar(
        title: Transform.scale(
                  scale: 0.29,
                  child: Image(
                    image: AssetImage(
                      surveyPogoLogo,
                    ),
                  ),
                ),
         centerTitle: true,
                backgroundColor: Colors.grey[300]
      ),
      body: Center(
        child:Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 121, 121, 121), width: 1),

        ),
      child: Theme(                           
      data: Theme.of(context).copyWith(     
      splashColor: Colors.transparent,   
      highlightColor: Colors.transparent, 
      hoverColor: Colors.transparent,     
    ),
    child:DropdownButtonHideUnderline(
        child: DropdownButton<String>(
           hint: Text(
            'Please select your age',
            style: TextStyle( fontSize: 20, color: Colors.black),),
          value: value,
          iconSize: 36,
          icon: Icon(Icons.arrow_drop_down, color:Colors.black),
          isExpanded: true,
                  focusColor: Colors.transparent,
          items: items.map(buildMenuItem).toList(),
          onChanged: (value) => setState(()=>this.value = value),       
        ),      
      )
    ),)));

  }
}