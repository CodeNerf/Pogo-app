import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import '../amplifyconfiguration.dart';
import './models/SignUpInfo.dart';

Future<void> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

Future<bool> isUserSignedIn() async {
  final result = await Amplify.Auth.fetchAuthSession();
  return result.isSignedIn;
}

Future<AuthUser> getCurrentUser() async {
  final user = await Amplify.Auth.getCurrentUser();
  return user;
}

bool isSignUpComplete =
    false; //flag used to route away from signup, possibly better as return value
//TODO pass signupinfo class as parameter to enable dynamic fields for sign up
Future<void> signUpUser(String email, String password) async {
  try {
    final result = await Amplify.Auth.signUp(
      username: email,
      password: password,
    );
    isSignUpComplete = result.isSignUpComplete;

    debugPrint("isSignUpComplete:  $isSignUpComplete");
  } on AuthException catch (e) {
    safePrint(e.message);
  }
}
