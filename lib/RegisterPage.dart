import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pogo/UserConfirmationPage.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:validators/validators.dart';
import 'LoginPage.dart';
import 'Onboarding/Issues/GunPolicy.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/UserDemographics.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String signUpPogoLogo = 'assets/Pogo_logo_horizontal.png';
  final formKey = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  bool obscure = true;
  bool obscureConfirm = true;
  Icon eye = Icon(Icons.remove_red_eye);
  Icon eyeConfirm = Icon(Icons.remove_red_eye);
  String errorText = '';
  double errorSizeBoxSize = 0;

  // Regular expression for validating US addresses
  final addressRegex = RegExp(
    r'^\d+\s[A-z]+\s[A-z]+(\s[A-z]+)?,\s[A-z]{2}\s\d{5}$',
  );
  // Regular expression for validating email address
  final emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  Future signUp(context) async {
    if (fnameController.text.isEmpty) {
      setState(() {
        errorText = 'Must enter your first name.';
        errorSizeBoxSize = 10;
      });
    } else if (lnameController.text.isEmpty) {
      setState(() {
        errorText = 'Must enter your last name.';
        errorSizeBoxSize = 10;
      });
    } else if (emailController.text.isEmpty) {
      setState(() {
        errorText = 'Must enter your email.';
        errorSizeBoxSize = 10;
      });
    } else if (!emailRegex.hasMatch(emailController.text)) {
      setState(() {
        errorText = 'Invalid email address.';
        errorSizeBoxSize = 10;
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        errorText = 'Must enter a password.';
        errorSizeBoxSize = 10;
      });
    } else if (confirmPasswordController.text.isEmpty) {
      setState(() {
        errorText = 'Must confirm your password.';
        errorSizeBoxSize = 10;
      });
    } else if (passwordController.text
            .compareTo(confirmPasswordController.text) !=
        0) {
      setState(() {
        errorText = 'Passwords do not match.';
        errorSizeBoxSize = 10;
      });
    } else if (phoneController.text.isEmpty) {
      setState(() {
        errorText = 'Must enter your phone number.';
        errorSizeBoxSize = 10;
      });
    } else if (!isNumeric(phoneController.text)) {
      //print(passwordController.text.length);
      setState(() {
        errorText = 'Invalid phone number.';
        errorSizeBoxSize = 10;
      });
    } else if (phoneController.text.length != 10) {
      setState(() {
        errorText = 'Invalid phone number length.';
        errorSizeBoxSize = 10;
      });
    } else if (addressController.text.isEmpty) {
      setState(() {
        errorText = 'Must enter your address.';
        errorSizeBoxSize = 10;
      });
    } else if (await signUpUser(
        emailController.text,
        passwordController.text,
        fnameController.text,
        lnameController.text,
        phoneController.text,
        addressController.text)) {
      UserDemographics userDemographics = UserDemographics(userId: emailController.text, phoneNumber: phoneController.text, registrationState: '', addressLine1: addressController.text, pollingLocation: '', voterRegistrationStatus: false, firstName: fnameController.text, lastName: lnameController.text, dateOfBirth: '', zipCode: '', profileImageURL: '', gender: '', racialIdentity: '', politicalAffiliation: '');
      putUserDemographics(userDemographics);
      //TODO: create blank ballot then push to db
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserConfirmationPage(
                  email: emailController.text,
                  password: passwordController.text)));
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree.
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  //@override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E1E1),
      body: SafeArea(
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //LOGO
                  Transform.scale(
                    scale: 0.5,
                    child: Image(
                      image: AssetImage(
                        signUpPogoLogo,
                      ),
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

                  //FIRST NAME
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(255, 178, 169, 169)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: fnameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'First Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //LAST NAME
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(255, 178, 169, 169)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: lnameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Last Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //EMAIL
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(255, 178, 169, 169)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //PASSWORD
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Password must be at least 8 characters and contain at least 1 symbol and uppercase letter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(255, 178, 169, 169)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: obscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (obscure) {
                                  setState(() {
                                    obscure = false;
                                    eye = const Icon(
                                        Icons.remove_red_eye_outlined);
                                  });
                                } else {
                                  setState(() {
                                    obscure = true;
                                    eye = const Icon(Icons.remove_red_eye);
                                  });
                                }
                              },
                              child: eye,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //CONFIRM PASSWORD
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(255, 178, 169, 169)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: obscureConfirm,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (obscureConfirm) {
                                  setState(() {
                                    obscureConfirm = false;
                                    eyeConfirm = const Icon(
                                        Icons.remove_red_eye_outlined);
                                  });
                                } else {
                                  setState(() {
                                    obscureConfirm = true;
                                    eyeConfirm =
                                        const Icon(Icons.remove_red_eye);
                                  });
                                }
                              },
                              child: eyeConfirm,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //PHONE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(255, 178, 169, 169)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number e.g 1234567890',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //ADDRESS
                  //TODO: separate fields for address: street, zipcode, city, etc
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                            color: Color.fromARGB(255, 178, 169, 169)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Address',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //REGISTER BUTTON
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: InkWell(
                      onTap: () async {
                        signUp(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3D433),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                            child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //back to login
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Already have an account? Login here!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
