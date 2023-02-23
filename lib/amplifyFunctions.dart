
import 'dart:developer';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'models/ModelProvider.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';
import 'user.dart';

Future<void> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    final dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(dataStorePlugin);
    safePrint("Amplify Configured");
    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

Future<bool> isUserSignedIn() async {
  try {
    await Amplify.Auth.fetchAuthSession();
    return true;
  }
  on AuthException catch (e) {
    safePrint(e.message);
    return false;
  }
  /*
  final result = await Amplify.Auth.fetchAuthSession();
  return result.isSignedIn;
   */
}

Future<AuthUser> getCurrentUser() async {
  final user = await Amplify.Auth.getCurrentUser();
  return user;
}

Future<bool> signUpUser(String email, String password, String fname, String lname, String phoneNumber, String address) async {
  //bool isSignUpComplete = false; //Flag used to route away from signup, possibly better as return value
  try {
    String phone = '+1$phoneNumber';
    final userAttributes = <CognitoUserAttributeKey, String> {
      CognitoUserAttributeKey.givenName: fname,
      CognitoUserAttributeKey.familyName: lname,
      CognitoUserAttributeKey.phoneNumber: phone,
      CognitoUserAttributeKey.address: address,
      const CognitoUserAttributeKey.custom('survey'): '0',
    };
    final result = await Amplify.Auth.signUp(
      username: email,
      password: password,
      options: CognitoSignUpOptions(userAttributes: userAttributes),
    );

    return true;
    //debugPrint("isSignUpComplete:  $isSignUpComplete");
  } on AuthException catch (e) {
    safePrint(e.message);
    return false;
  }
}

Future<bool> signInUser(String email, String password) async {
  try {
    final result =
        await Amplify.Auth.signIn(username: email, password: password);
    return true;
  } on AuthException catch (e) {
    return false;
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
    safePrint("true");
    return true;
  } on AuthException catch (e) {
    safePrint("false");
    return false;
  }
}

Future<bool> confirmUser(String email, String code) async {
  try {
    await Amplify.Auth.confirmSignUp(username: email, confirmationCode: code);
    return true;
  } on AuthException catch (e) {
    return false;
  }
}

Future<bool> resendConfirmationCode(String email) async {
  try {
    await Amplify.Auth.resendSignUpCode(username: email);
    safePrint('Code was resent');
    return true;
  } catch (e) {
    safePrint('Error resending code.');
    return false;
  }
}
    
Future<bool> resetPassword(String username) async {
  try {
    await Amplify.Auth.resetPassword(username: username);
    return true;
  } on AmplifyException catch (e) {
    safePrint(e);
    return false;
  }
}

//todo create model to reduce function parameters to 1
Future<bool> confirmResetPassword(String username, String password, String code) async {
  try {
    await Amplify.Auth.confirmResetPassword(username: username, newPassword: password, confirmationCode: code);
    return true;
  } on AmplifyException catch (e) {
    safePrint(e);
    return false;
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

Future<user> fetchCurrentUserAttributes() async {
  user current = user.all("", "", "", "", "");
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    current.address = result[1].value;
    current.phone = result[4].value;
    current.fname = result[6].value;
    current.lname = result[7].value;
    current.email = result[8].value;
  } on AuthException catch (e) {
    safePrint(e.message);
  }
  return current;
}

Future<String> fetchCurrentUserEmail() async {
  user current = user.all("", "", "", "", "");
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    return result[8].value;
  } on AuthException catch (e) {
    safePrint(e.message);
  }
  return '';
}

Future<bool> isUserConfirmed() async {
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    if(result[2].value == 'true') {
      return true;
    }
    return false;
  } on AuthException catch (e) {
    safePrint(e.message);
  }
  return false;
}

Future<bool> isSurveyCompleted() async {
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    if(result[5].value == "0") {
      safePrint('${result[7].userAttributeKey} + ${result[7].value}');
      //not completed
      return false;
    }
    //completed
    return true;
  } on AuthException catch (e) {
    return false;
    safePrint(e.message);
  }
}

Future<bool> updateSurveyCompletion() async {
  try {
    final result = await Amplify.Auth.updateUserAttribute(
      userAttributeKey: const CognitoUserAttributeKey.custom("survey"),
      value: '1',
    );
    safePrint("Survey Completed");
    return true;
  } on AmplifyException catch (e) {
    safePrint(e.message);
    return false;
  }
}