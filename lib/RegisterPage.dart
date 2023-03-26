import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pogo/UserConfirmationPage.dart';
import 'package:pogo/awsFunctions.dart';
import 'package:validators/validators.dart';
import 'HomeLoadingPage.dart';
import 'LoginPage.dart';
import 'Onboarding/SurveyLandingPage.dart';
import 'amplifyFunctions.dart';
import 'dynamoModels/UserDemographics.dart';
//import 'SignUpAddress.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final String _pogoLogo = 'assets/Pogo_logo_horizontal.png';
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailSignInController = TextEditingController();
  final _passwordSignInController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;
  Icon _eye = const Icon(Icons.remove_red_eye);
  Icon _eyeConfirm = const Icon(Icons.remove_red_eye);
  String _errorText = '';
  double _errorSizeBoxSize = 0;

  late List<Widget> _widgetOptions;
  int _selectedIndex = 0;

  void switchSection(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _widgetOptions = <Widget>[
        signup(),
        signin(),
      ];
    });
  }

  // Regular expression for validating US addresses
  final _addressRegex = RegExp(
    r'^\d+\s[A-z]+\s[A-z]+(\s[A-z]+)?,\s[A-z]{2}\s\d{5}$',
  );
  // Regular expression for validating email address
  final _emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );


  
  Future _signUp(context) async {
    if (_fnameController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your first name.';
        _errorSizeBoxSize = 10;
      });
    } else if (_lnameController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your last name.';
        _errorSizeBoxSize = 10;
      });
    } else if (_emailController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your email.';
        _errorSizeBoxSize = 10;
      });
    } else if (!_emailRegex.hasMatch(_emailController.text)) {
      setState(() {
        _errorText = 'Invalid email address.';
        _errorSizeBoxSize = 10;
      });
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter a password.';
        _errorSizeBoxSize = 10;
      });
    } else if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorText = 'Must confirm your password.';
        _errorSizeBoxSize = 10;
      });
    } else if (_passwordController.text
            .compareTo(_confirmPasswordController.text) !=
        0) {
      setState(() {
        _errorText = 'Passwords do not match.';
        _errorSizeBoxSize = 10;
      });
    } else if (_phoneController.text.isEmpty) {
      setState(() {
        _errorText = 'Must enter your phone number.';
        _errorSizeBoxSize = 10;
      });
    } else if (!isNumeric(_phoneController.text)) {
      //print(passwordController.text.length);
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
    } else if (await signUpUser(
        _emailController.text,
        _passwordController.text,
        _fnameController.text,
        _lnameController.text,
        _phoneController.text,
        _addressController.text)) {
      UserDemographics userDemographics = UserDemographics(userId: _emailController.text, phoneNumber: _phoneController.text, registrationState: '', addressLine1: _addressController.text, pollingLocation: '', voterRegistrationStatus: false, firstName: _fnameController.text, lastName: _lnameController.text, dateOfBirth: '', zipCode: '', profileImageURL: '', gender: '', racialIdentity: '', politicalAffiliation: '', surveyCompletion: false);
      putUserDemographics(userDemographics);
      putUserBallot(_emailController.text, [], [], []);
      //TODO: create blank ballot then push to db
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserConfirmationPage(
                  email: _emailController.text,
                  password: _passwordController.text)));
    }
  }

  Future _signIn(context) async {
    if (await signInUser(_emailSignInController.text, _passwordSignInController.text)) {
      safePrint("checking isUserSignedIn()");
      if (await isUserSignedIn()) {
        //check if survey is completed
        UserDemographics user = await getUserDemographics(_emailSignInController.text);
        if(user.surveyCompletion == true) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeLoadingPage(user: user),
            ),
          );
        }
        else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurveyLandingPage(),
            ),
          );
        }
        //TODO: make account confirmation not necessary for logging in (maybe)
        /* this checks if user is confirmed, not currently possible due to cognito settings
        safePrint("checking isUserConfirmed()");
        //check if user is confirmed
        if(await isUserConfirmed()) {
          safePrint("checking isSurveyCompleted()");
          //check if survey is completed
          if(await isSurveyCompleted()) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLoadingPage(),
              ),
            );
          }
          else {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurveyLandingPage(),
              ),
            );
          }
        }
        else {
          if (await resendConfirmationCode(emailController.text)) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserConfirmationPage(email: emailController.text, password: passwordController.text),
              ),
            );
          }
        }
        */
      } else {
        setState(() {
          _errorText = 'Could not log in.';
        });
      }
    } else {
      setState(() {
        _errorText = 'Could not log in.';
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree.
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  //@override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(_pogoLogo),
              width: 150,
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget signin() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  switchSection(0);
                },
                child: const Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Color(0xFF0E0E0E),
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              const Opacity(
                opacity: 1.0,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Color(0xFF0E0E0E),
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:30.0),
            child: Text(
              "Sign in to continue your search",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF57636C),
                fontSize: 18,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        //EMAIL
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _emailSignInController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'example@email.com',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        //password
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                obscureText: _obscure,
                controller: _passwordSignInController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_obscure) {
                        setState(() {
                          _obscure = false;
                          _eye = const Icon(Icons.remove_red_eye_outlined, color: Colors.grey);
                        });
                      } else {
                        setState(() {
                          _obscure = true;
                          _eye = const Icon(Icons.remove_red_eye, color: Colors.grey);
                        });
                      }
                    },
                    child: _eye,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        //login button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: InkWell(
            onTap: () async {
              _signIn(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3D433),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Login",
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
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 40),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:30.0),
            child: Text(
              "Or Continue with:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF57636C),
                fontSize: 18,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/google.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/facebook.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/twitter.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/instagram.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/tiktok.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget signup() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Opacity(
                opacity: 1.0,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Color(0xFF0E0E0E),
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                    height: 1.2,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  switchSection(1);
                },
                child: const Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Color(0xFF0E0E0E),
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:30.0),
            child: Text(
              "Get started. Make an account today!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF57636C),
                fontSize: 18,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        //FIRST NAME
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(
                  color: Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _fnameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'your name',
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
              color: Colors.grey[90],
              border: Border.all(
                  color: Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'example@email.com',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[90],
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: TextField(
                obscureText: _obscure,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_obscure) {
                        setState(() {
                          _obscure = false;
                          _eye = const Icon(Icons.remove_red_eye_outlined, color: Colors.grey);
                        });
                      } else {
                        setState(() {
                          _obscure = true;
                          _eye = const Icon(Icons.remove_red_eye, color: Colors.grey);
                        });
                      }
                    },
                    child: _eye,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        //REGISTER BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: InkWell(
            onTap: () async {
              _signUp(context);
            },
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "FREE Sign Up",
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
        ),
        const SizedBox(height: 15),
        SizedBox(height: 40),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:30.0),
            child: Text(
              "Or Continue with:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF57636C),
                fontSize: 18,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/google.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/facebook.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/twitter.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/instagram.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD9D9D9),
              ),
              child: IconButton(
                icon: Image.asset('assets/tiktok.png', width: 35, height: 35,),
                onPressed: () {
                  // Add icon onTap functionality
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
