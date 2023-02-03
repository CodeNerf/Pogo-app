import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pogo/Onboarding/Demographics.dart';
import 'LoginPage.dart';
import 'Onboarding/Issues/GunPolicy.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
String signUpPogoLogo = 'assets/Pogo_logo_horizontal.png';
final formKey= GlobalKey<FormState>();
final fnameController = TextEditingController();
final lnameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPassController = TextEditingController();
final phoneController = TextEditingController();
final addressController = TextEditingController();


Future login() async {
    //TODO: implement back-end function to login user after tapping login button
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Demographics(),
      ),
    );
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        title: const Text("Register"),
         centerTitle: true,
                backgroundColor: Colors.grey[300]
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [   Transform.scale(
                  scale: 0.7,
                  child: Image(
                    image: AssetImage(
                      signUpPogoLogo,
                    ),
                  ),
                ),
                //Register form
                  //name textfield
           const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color.fromARGB(255, 178, 169, 169)),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color.fromARGB(255, 178, 169, 169)),
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
                //email textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color.fromARGB(255, 178, 169, 169)),
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
                //password textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color.fromARGB(255, 178, 169, 169)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: (){
                             setState(() {
                               _obscureText= !_obscureText;
                             });
                            },
                            child: Icon(_obscureText ?Icons.visibility :Icons.visibility_off),
                            ),
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                  ),
                ),


              const SizedBox(height: 20),
                //confirm password textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color.fromARGB(255, 178, 169, 169)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: confirmPassController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          suffixIcon: GestureDetector(
                            onTap: (){
                             setState(() {
                               _obscureText= !_obscureText;
                             });
                            },
                            child: Icon(_obscureText ?Icons.visibility :Icons.visibility_off),
                            ),
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                  ),
                ),
                          const SizedBox(height: 20),
                //password textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color.fromARGB(255, 178, 169, 169)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
                        ),
                    
                      ),
                    ),
                  ),
                ),
const SizedBox(height: 20),
                //password textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color.fromARGB(255, 178, 169, 169)),
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
                const SizedBox(height: 10),
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
               onTap: () async {
                      login();
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
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}