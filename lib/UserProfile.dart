import 'package:flutter/material.dart';
import 'package:pogo/LoginPage.dart';
import 'amplifyFunctions.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  Future logout(BuildContext context) async {
    logoutUser();
    if(await checkLoggedIn()) {
      //successfully logged out, send to login
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
    else {
      //logout not working (this shouldn't ever happen)
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: InkWell(
            onTap: () async {
              logout(context);
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3D433),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
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
