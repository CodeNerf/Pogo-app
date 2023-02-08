
import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';

Future<void> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    safePrint("Amplify Configured");
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

Future<bool> signUpUser(String email, String password) async {
  bool isSignUpComplete =
      false; //Flag used to route away from signup, possibly better as return value
//TODO pass signupinfo class as parameter to enable dynamic fields for sign up
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
  return isSignUpComplete;
}

Future<void> signInUser(String email, String password) async {
  try {
    final result =
        await Amplify.Auth.signIn(username: email, password: password);
    safePrint(isUserSignedIn());
  } on AuthException catch (e) {
    safePrint(e.message);
  }
}

Future<void> logoutUser() async {
  try {
    await Amplify.Auth.signOut();
  } on AuthException catch (e) {
    safePrint(e.message);
  }
}

Future<bool> checkLoggedIn() async {
  try {
    await Amplify.Auth.getCurrentUser();
    return true;
  } on AuthException catch (e) {
    return false;
  }
}

