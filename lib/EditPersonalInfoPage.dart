import 'package:flutter/material.dart';
import 'package:pogo/LoginPage.dart';
import 'package:pogo/awsFunctions.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'dynamoModels/UserDemographics.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/UserIssueFactorValues.dart';
import 'user.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'dart:math';
class EditPersonalInfoPage extends StatefulWidget {
  final UserDemographics userDemographics;
  const EditPersonalInfoPage({Key? key, required this.userDemographics}) : super(key: key);

  @override
  _EditPersonalInfoPageState createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.userDemographics.firstName;
    _lastNameController.text = widget.userDemographics.lastName;
    _emailController.text = widget.userDemographics.userId;
    _phoneController.text = widget.userDemographics.phoneNumber;
    _addressController.text = widget.userDemographics.addressLine1;
  }
@override
Widget build(BuildContext context) {
  return Container(
    color: Colors.grey[400],
    child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              
            children: [
            SizedBox(height: 20),

              Text(
                'Edit Personal Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Update user demographics with new info
                    widget.userDemographics.firstName = _firstNameController.text;
                    widget.userDemographics.lastName = _lastNameController.text;
                    //widget.userDemographics.userId = _emailController.text;
                    widget.userDemographics.phoneNumber = _phoneController.text;
                    widget.userDemographics.addressLine1 = _addressController.text;

                    Navigator.pop(context, widget.userDemographics);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFF3D433), 
                    onPrimary: Colors.white,
                    elevation: 0,
                    minimumSize: Size(double.infinity, 48), 
                  ),
                  child: Text('Save Changes' ,style: TextStyle(fontSize:17 ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}