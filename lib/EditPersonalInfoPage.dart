import 'package:flutter/material.dart';
import 'package:pogo/LoginPage.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:pogo/googleFunctions/CivicModels.dart';
import 'package:validators/validators.dart';
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String errorText = '';
  double errorSizeBoxSize = 0;
  String PogoLogo = 'assets/Pogo_logo_horizontal.png';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image(
          image: AssetImage(PogoLogo),
          width: 150,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              
            children: [
            SizedBox(height: 20),

              const Text(
                'Edit Personal Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //ERROR TEXT
              Text(
                errorText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: errorSizeBoxSize),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: widget.userDemographics.firstName),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: widget.userDemographics.lastName),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: widget.userDemographics.phoneNumber),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: widget.userDemographics.addressLine1),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_firstNameController.text.isEmpty) {
                      setState(() {
                        errorText = 'Must enter your first name.';
                        errorSizeBoxSize = 10;
                      });
                    } else if (_lastNameController.text.isEmpty) {
                      setState(() {
                        errorText = 'Must enter your last name.';
                        errorSizeBoxSize = 10;
                      });
                    } else if (_phoneController.text.isEmpty) {
                      setState(() {
                        errorText = 'Must enter your phone number.';
                        errorSizeBoxSize = 10;
                      });
                    } else if (!isNumeric(_phoneController.text)) {
                      setState(() {
                        errorText = 'Invalid phone number.';
                        errorSizeBoxSize = 10;
                      });
                    } else if (_phoneController.text.length != 10) {
                      setState(() {
                        errorText = 'Invalid phone number length.';
                        errorSizeBoxSize = 10;
                      });
                    } else if (_addressController.text.isEmpty) {
                      setState(() {
                        errorText = 'Must enter your address.';
                        errorSizeBoxSize = 10;
                      });
                    }
                    else {
                      if(_firstNameController.text == widget.userDemographics.firstName) {
                        if(_lastNameController.text == widget.userDemographics.lastName) {
                          if(_phoneController.text == widget.userDemographics.phoneNumber) {
                            if(_firstNameController.text == widget.userDemographics.firstName) {
                              //do nothing
                            }
                            else {
                              widget.userDemographics.firstName = _firstNameController.text;
                              widget.userDemographics.lastName = _lastNameController.text;
                              widget.userDemographics.phoneNumber = _phoneController.text;
                              widget.userDemographics.addressLine1 = _addressController.text;
                              putUserDemographics(widget.userDemographics);
                            }
                          }
                          else {
                            widget.userDemographics.firstName = _firstNameController.text;
                            widget.userDemographics.lastName = _lastNameController.text;
                            widget.userDemographics.phoneNumber = _phoneController.text;
                            widget.userDemographics.addressLine1 = _addressController.text;
                            putUserDemographics(widget.userDemographics);
                          }
                        }
                        else {
                          widget.userDemographics.firstName = _firstNameController.text;
                          widget.userDemographics.lastName = _lastNameController.text;
                          widget.userDemographics.phoneNumber = _phoneController.text;
                          widget.userDemographics.addressLine1 = _addressController.text;
                          putUserDemographics(widget.userDemographics);
                        }
                      }
                      else {
                        widget.userDemographics.firstName = _firstNameController.text;
                        widget.userDemographics.lastName = _lastNameController.text;
                        widget.userDemographics.phoneNumber = _phoneController.text;
                        widget.userDemographics.addressLine1 = _addressController.text;
                        putUserDemographics(widget.userDemographics);
                      }
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFF3D433),
                    elevation: 0,
                    minimumSize: Size(double.infinity, 48), 
                  ),
                  child: const Text('Save Changes' ,style: TextStyle(fontSize:17, color: Colors.black ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}