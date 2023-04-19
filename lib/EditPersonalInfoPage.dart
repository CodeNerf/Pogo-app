import 'package:flutter/material.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:validators/validators.dart';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';

import 'Onboarding/SurveyLandingPage.dart';

class EditPersonalInfoPage extends StatefulWidget {
  final UserDemographics userDemographics;
  const EditPersonalInfoPage({Key? key, required this.userDemographics})
      : super(key: key);

  @override
  _EditPersonalInfoPageState createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _errorText = '';
  double _errorSizeBoxSize = 0;
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.userDemographics.firstName;
    _lastNameController.text = widget.userDemographics.lastName;
    _emailController.text = widget.userDemographics.id;
    _phoneController.text = widget.userDemographics.phoneNumber;
    _addressController.text = widget.userDemographics.addressLine1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
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
                _errorText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: _errorSizeBoxSize),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 16),
              //save changes button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF3D433),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      if (_firstNameController.text.isEmpty) {
                        setState(() {
                          _errorText = 'Must enter your first name.';
                          _errorSizeBoxSize = 10;
                        });
                      } else if (_lastNameController.text.isEmpty) {
                        setState(() {
                          _errorText = 'Must enter your last name.';
                          _errorSizeBoxSize = 10;
                        });
                      } else if (_phoneController.text.isEmpty) {
                        setState(() {
                          _errorText = 'Must enter your phone number.';
                          _errorSizeBoxSize = 10;
                        });
                      } else if (!isNumeric(_phoneController.text)) {
                        setState(() {
                          _errorText = 'Invalid phone number.';
                          _errorSizeBoxSize = 10;
                        });
                      } else if (_phoneController.text.length != 10) {
                        setState(() {
                          _errorText = 'Invalid phone number length.';
                          _errorSizeBoxSize = 10;
                        });
                      } else if (_addressController.text.isEmpty) {
                        setState(() {
                          _errorText = 'Must enter your address.';
                          _errorSizeBoxSize = 10;
                        });
                      } else {
                        if (_firstNameController.text ==
                            widget.userDemographics.firstName) {
                          if (_lastNameController.text ==
                              widget.userDemographics.lastName) {
                            if (_phoneController.text ==
                                widget.userDemographics.phoneNumber) {
                              if (_addressController.text ==
                                  widget.userDemographics.addressLine1) {
                                //do nothing
                              } else {
                                widget.userDemographics.firstName =
                                    _firstNameController.text;
                                widget.userDemographics.lastName =
                                    _lastNameController.text;
                                widget.userDemographics.phoneNumber =
                                    _phoneController.text;
                                widget.userDemographics.addressLine1 =
                                    _addressController.text;
                                putUserDemographics(widget.userDemographics);
                              }
                            } else {
                              widget.userDemographics.firstName =
                                  _firstNameController.text;
                              widget.userDemographics.lastName =
                                  _lastNameController.text;
                              widget.userDemographics.phoneNumber =
                                  _phoneController.text;
                              widget.userDemographics.addressLine1 =
                                  _addressController.text;
                              putUserDemographics(widget.userDemographics);
                            }
                          } else {
                            widget.userDemographics.firstName =
                                _firstNameController.text;
                            widget.userDemographics.lastName =
                                _lastNameController.text;
                            widget.userDemographics.phoneNumber =
                                _phoneController.text;
                            widget.userDemographics.addressLine1 =
                                _addressController.text;
                            putUserDemographics(widget.userDemographics);
                          }
                        } else {
                          widget.userDemographics.firstName =
                              _firstNameController.text;
                          widget.userDemographics.lastName =
                              _lastNameController.text;
                          widget.userDemographics.phoneNumber =
                              _phoneController.text;
                          widget.userDemographics.addressLine1 =
                              _addressController.text;
                          putUserDemographics(widget.userDemographics);
                        }
                      }
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              //edit survey demographics
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF3D433),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurveyLandingPage(pageSelect: 0,),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Edit Survey Demographics",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              //edit survey demographics
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF3D433),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurveyLandingPage(pageSelect: 1,),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Edit Survey Voter Info",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
