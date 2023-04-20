import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:pogo/awsFunctions.dart';
import 'amplifyconfiguration.dart';

// Configures Amplify and returns true if successful
Future<bool> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    await Amplify.configure(amplifyconfig);
    safePrint("Amplify Configured");
    return true;
  } catch (e) {
    safePrint('An error occurred configureAmplify(): $e');
    return false;
  }
}

// Checks if user is signed in and returns true if so
Future<bool> isUserSignedIn() async {
  try {
    final result = await Amplify.Auth.fetchAuthSession();
    if (result.isSignedIn) {
      safePrint('USER IS SIGNED IN');
      return true;
    } else {
      safePrint('USER IS SIGNED OUT');
      return false;
    }
  } catch (e) {
    safePrint('An error occurred isUserSignedIn() $e');
    return false;
  }
}

// Returns the current user from cognito
Future<AuthUser> getCurrentUser() async {
  try {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  } catch (e) {
    safePrint('An error ocurred getCurrentUser() $e');
    return AuthUser(userId: '', username: '');
  }
}

// Registers the current user to cognito
Future<bool> signUpUser(String email, String password, String fname) async {
  //bool isSignUpComplete = false; //Flag used to route away from signup, possibly better as return value
  try {
    final userAttributes = <CognitoUserAttributeKey, String>{
      CognitoUserAttributeKey.givenName: fname,
    };
    final result = await Amplify.Auth.signUp(
      username: email,
      password: password,
      options: CognitoSignUpOptions(userAttributes: userAttributes),
    );

    return true;
    //debugPrint("isSignUpComplete:  $isSignUpComplete");
  } catch (e) {
    safePrint('An error occurred in signUpUser() $e');
    return false;
  }
}

// Signs in the current user to cognito
Future<bool> signInUser(String email, String password) async {
  try {
    final result =
        await Amplify.Auth.signIn(username: email, password: password);
    return true;
  } catch (e) {
    safePrint('An error occurred in signInUser() $e');
    return false;
  }
}

// Signs out the current user from cognito
Future<void> logoutUser() async {
  try {
    await Amplify.Auth.signOut();
  } catch (e) {
    safePrint('An error occurred in logoutUser() $e');
  }
}

// Checks if the user is logged in and returns true if so
Future<bool> checkLoggedIn() async {
  try {
    await Amplify.Auth.getCurrentUser();
    safePrint("true");
    return true;
  } on AuthException catch (e) {
    safePrint('An error occurred in checkLoggedIn() $e');
    return false;
  }
}

// Confirms the user with the code sent to their email
Future<bool> confirmUser(String email, String code) async {
  try {
    await Amplify.Auth.confirmSignUp(username: email, confirmationCode: code);
    return true;
  } catch (e) {
    safePrint('An error occurred in confirmUser() $e');
    return false;
  }
}

// Resends the confirmation code to the user's email
Future<bool> resendConfirmationCode(String email) async {
  try {
    await Amplify.Auth.resendSignUpCode(username: email);
    safePrint('Code was resent');
    return true;
  } catch (e) {
    safePrint('An error occurred in resendConfirmationCode() $e');
    return false;
  }
}

// Sends a password reset email to the user
Future<bool> resetPassword(String username) async {
  try {
    await Amplify.Auth.resetPassword(username: username);
    return true;
  } catch (e) {
    safePrint('An error occurred in resetPassword() $e');
    return false;
  }
}

// Confirms the password reset with the code sent to the user's email
Future<bool> confirmResetPassword(
    String username, String password, String code) async {
  try {
    await Amplify.Auth.confirmResetPassword(
        username: username, newPassword: password, confirmationCode: code);
    return true;
  } catch (e) {
    safePrint('An error occurred in confirmResetPassword() $e');
    return false;
  }
}

// Updates the user's password
Future<void> updatePassword(String oldPassword, String newPassword) async {
  try {
    await Amplify.Auth.updatePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  } catch (e) {
    safePrint('An error occurred in updatePassword() $e');
  }
}

// Gets the current user's email
Future<String> fetchCurrentUserEmail() async {
  try {
    final result = await fetchUserAttributes();
    String email = result['email']!;
    return email;
  } catch (e) {
    safePrint('An error occurred in fetchCurrentUserEmail() $e');
  }
  return '';
}

// Maps user attributes from Cognito to a map data structure to be used in user demographics
Future<Map<String, String>> fetchUserAttributes() async {
  Map<String, String> userAttributes = {};
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    for (var i = 0; i < result.length; i++) {
      userAttributes[result[i].userAttributeKey.key] = result[i].value;
    }
    return userAttributes;
  } catch (e) {
    safePrint('An error occurred in fetchUserAttributes() $e');
  }
  return userAttributes;
}

// Checks if user confirmed their email
Future<bool> isUserConfirmed() async {
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    if (result[2].value == 'true') {
      return true;
    }
    return false;
  } catch (e) {
    safePrint('An error occurred in isUserConfirmed() $e');
  }
  return false;
}

// Checks if user has completed the survey
Future<bool> isSurveyCompleted() async {
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    if (result[5].value == "0") {
      safePrint('${result[7].userAttributeKey} + ${result[7].value}');
      //not completed
      return false;
    }
    //completed
    return true;
  } catch (e) {
    safePrint('An error occurred in isSurveyCompleted() $e');
    return false;
  }
}

// Updates the users survey completion status
Future<bool> updateSurveyCompletion() async {
  try {
    final result = await Amplify.Auth.updateUserAttribute(
      userAttributeKey: const CognitoUserAttributeKey.custom("survey"),
      value: '1',
    );
    safePrint("Survey Completed");
    return true;
  } catch (e) {
    safePrint('An error occurred in updateSurveyCompletion() $e');
    return false;
  }
}
