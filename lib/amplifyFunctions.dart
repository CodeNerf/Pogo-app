import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import '../amplifyconfiguration.dart';

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

//TODO pass signupinfo class as parameter to enable dynamic fields for sign up
Future<bool> signUpUser(String email, String password) async {
  bool isSignUpComplete =
      false; //Flag used to route away from signup, possibly better as return value
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

bool isPasswordReset = false;
Future<void> resetPassword(String username) async {
  try {
    final result = await Amplify.Auth.resetPassword(username: username);
    isPasswordReset = result.isPasswordReset;
  } on AmplifyException catch (e) {
    safePrint(e);
  }
}

//todo create model to reduce function parameters to 1
Future<void> confirmResetPassword(
    String username, String password, String code) async {
  try {
    await Amplify.Auth.confirmResetPassword(
        username: username, newPassword: password, confirmationCode: code);
  } on AmplifyException catch (e) {
    safePrint(e);
  }
}

Future<void> updatePassword(String oldPassword, String newPassword) async {
  try {
    await Amplify.Auth.updatePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  } on AmplifyException catch (e) {
    safePrint(e);
  }
}
