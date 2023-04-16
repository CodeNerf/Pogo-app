import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pogo/Onboarding/Demographics.dart';
import 'package:pogo/UserConfirmationPage.dart';
import 'package:pogo/dynamoModels/UserDemographics.dart';
import 'package:pogo/dynamoModels/UserIssueFactorValues.dart';
import 'package:validators/validators.dart';
import 'SurveyLandingPage.dart';
import '../amplifyFunctions.dart';
import 'dart:async';
import 'package:validators/validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class AddressAutocomplete extends StatefulWidget {
  final UserDemographics userDemographics;
  final UserIssueFactorValues userIssueFactorValues;
  const AddressAutocomplete(
      {Key? key,
      required this.userDemographics,
      required this.userIssueFactorValues})
      : super(key: key);

  @override
  _AddressAutocompleteState createState() => _AddressAutocompleteState();
}

class _AddressAutocompleteState extends State<AddressAutocomplete> {
  final addressController = TextEditingController();
  String errorText = '';
  double errorSizeBoxSize = 0;
  bool isAddressSelected = false;

  final _placesApiClient =
      GoogleMapsPlaces(apiKey: 'AIzaSyBiXFGuy-dTD2F5Z3f7ow5ts9KG2Xy5bEE');

  // Regular expression for validating US addresses
  final addressRegex = RegExp(
    r'^\d+\s[A-z]+\s[A-z]+(\s[A-z]+)?,\s[A-z]{2}\s\d{5}$',
  );

  Future<List<Prediction>> getAddressPredictions(String query) async {
    final result = await _placesApiClient.autocomplete(
      query,
      language: 'en',
      components: [Component(Component.country, 'us')],
    );

    print(result.errorMessage);

    if (result.isOkay) {
      return result.predictions;
    } else {
      return [];
    }
  }

  List<Prediction> addressPredictions = [];

  Future<void> _onAddressChanged(String value) async {
    setState(() {
      errorText = '';
      errorSizeBoxSize = 0;
      isAddressSelected = false; // reset the flag
    });

    if (value.isNotEmpty) {
      final predictions = await getAddressPredictions(value);

      if (predictions.isNotEmpty) {
        setState(() {
          addressPredictions = predictions;
        });
      } else {
        setState(() {
          errorText = 'No results found for this address.';
          errorSizeBoxSize = 10;
        });
      }
    } else {
      setState(() {
        addressPredictions = [];
      });
    }
  }

  Future<void> _onAddressSelected(Prediction prediction) async {
    final place =
        await _placesApiClient.getDetailsByPlaceId(prediction.placeId!);
    final address = place.result.formattedAddress;

    setState(() {
      addressController.text = address!;
      isAddressSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: SafeArea(
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Welcome to PoGo, ${widget.userDemographics.firstName}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF0E0E0E),
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0,
                              height: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Enter your address personalize your search.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //ADDRESS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color.fromARGB(255, 178, 169, 169),
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.4),
                                blurRadius: 8.0,
                                offset: Offset(3.0, 5.0),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 25.0),
                                  child: TextField(
                                    controller: addressController,
                                    onChanged: _onAddressChanged,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Your Address',
                                      focusColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      prefixIcon: Icon(Icons.search),
                                      prefixIconConstraints: BoxConstraints(
                                        minHeight: 24,
                                        minWidth: 24,
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 23.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50.0,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (!isAddressSelected) {
                                      final prediction =
                                          addressPredictions.first;
                                      await _onAddressSelected(prediction);
                                    }

                                    final address = addressController.text;
                                    setState(() {
                                      widget.userDemographics.addressLine1 =
                                          address;
                                    });

                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Demographics(
                                                  ratings: widget
                                                      .userIssueFactorValues,
                                                  answers:
                                                      widget.userDemographics,
                                                  issuesIndex: 0,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFF3D433),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        if (addressPredictions.isNotEmpty && !isAddressSelected)
                          Center(
                            child: SizedBox(
                              width: 300.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color.fromARGB(255, 178, 169, 169),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    for (var prediction in addressPredictions)
                                      ListTile(
                                        title: Text(prediction.description!),
                                        onTap: () {
                                          addressController.text =
                                              prediction.description!;
                                          setState(() {
                                            addressPredictions = [];
                                            isAddressSelected = true;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
