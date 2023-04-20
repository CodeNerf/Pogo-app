import 'package:flutter/material.dart';
import 'package:pogo/UserConfirmationPage.dart';
import 'package:pogo/awsFunctions.dart';
import '../googleFunctions/APIKey.dart';
import 'SurveyLandingPage.dart';
import 'dart:async';
import 'package:pogo/dynamoModels/Demographics/UserDemographics.dart';
import 'package:pogo/dynamoModels/IssueFactorValues/UserIssueFactorValues.dart';
import 'package:google_maps_webservice/places.dart';

class AddressAutocomplete extends StatefulWidget {
  final UserDemographics userDemographics;
  final String email;
  final String password;
  const AddressAutocomplete(
      {Key? key,
      required this.userDemographics,
      required this.email,
      required this.password})
      : super(key: key);

  @override
  State<AddressAutocomplete> createState() => _AddressAutocompleteState();
}

class _AddressAutocompleteState extends State<AddressAutocomplete> {
  final addressController = TextEditingController();
  String errorText = '';
  double errorSizeBoxSize = 0;
  bool isAddressSelected = false;

  final _placesApiClient = GoogleMapsPlaces(apiKey: googlePlacesApiKey);

  // Regular expression for validating US addresses
  final addressRegex = RegExp(
    r'^\d+\s[A-z]+\s[A-z]+(\s[A-z]+)?,\s[A-z]{2}\s\d{5}$',
  );

  Future<List<Prediction>> getAddressPredictions(String query) async {
    // Call Google Places API to get suggestions for the provided query
    final result = await _placesApiClient.autocomplete(
      query,
      language: 'en',
      components: [Component(Component.country, 'us')],
    );

    if (result.isOkay) {
      // If the API call was successful, return the list of predictions
      return result.predictions;
    } else {
      // If the API call failed, return an empty list
      return [];
    }
  }

  List<Prediction> addressPredictions = [];

  Future<void> _onAddressChanged(String value) async {
    setState(() {
      // Reset the error text and size box
      errorText = '';
      errorSizeBoxSize = 0;
      isAddressSelected = false; // reset the flag
    });

    if (value.isNotEmpty) {
      // Get address predictions for the entered value
      final predictions = await getAddressPredictions(value);

      if (predictions.isNotEmpty) {
        setState(() {
          // Update the list of address predictions
          addressPredictions = predictions;
        });
      } else {
        setState(() {
          // Show an error message if there are no predictions
          errorText = 'No results found for this address.';
          errorSizeBoxSize = 10;
        });
      }
    } else {
      setState(() {
        // Clear the list of address predictions if the value is empty
        addressPredictions = [];
      });
    }
  }

  Future<void> _onAddressSelected(Prediction prediction) async {
    // Get the details of the selected prediction from the Google Places API
    final place =
        await _placesApiClient.getDetailsByPlaceId(prediction.placeId!);
    final address = place.result.formattedAddress;

    setState(() {
      // Update the address text field with the selected address
      addressController.text = address!;
      isAddressSelected = true;
    });
  }

  Future _nextPage() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserConfirmationPage(
                  email: widget.email,
                  password: widget.password,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            // Display a welcome message with the user's first name
                            "Welcome to PoGo, ${widget.userDemographics.firstName}",
                            style: const TextStyle(
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            // Display a message asking the user to enter their address
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
                  const SizedBox(
                    height: 10,
                  ),
                  // ADDRESS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display a text input for the user to enter their address
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 178, 169, 169),
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
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
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 25.0),
                                  child: TextField(
                                    // Use a TextEditingController to get the user's input
                                    controller: addressController,
                                    // Call the _onAddressChanged method whenever the user types in the TextField
                                    onChanged: _onAddressChanged,
                                    decoration: const InputDecoration(
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
                                    // If no address has been selected from the address predictions yet
                                    if (!isAddressSelected) {
                                      // Get the first prediction from the list of predictions
                                      final prediction =
                                          addressPredictions.first;
                                      // Call the _onAddressSelected method with the prediction as a parameter
                                      await _onAddressSelected(prediction);
                                    }

                                    // Get the address from the address controller
                                    final address = addressController.text;
                                    // Update the address line 1 value in the user demographics object
                                    setState(() {
                                      widget.userDemographics.addressLine1 =
                                          address;
                                    });
                                    await putUserDemographics(
                                        widget.userDemographics);
                                    _nextPage();
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFF3D433),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                    color: const Color.fromARGB(
                                        255, 178, 169, 169),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    // For each prediction in the list of address predictions display the description of the prediction
                                    for (var prediction in addressPredictions)
                                      ListTile(
                                        title: Text(prediction.description!),
                                        onTap: () {
                                          // Set the text of the address controller to the prediction's description
                                          addressController.text =
                                              prediction.description!;
                                          // Update the address predictions list and set the address selection flag to true
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
