import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseUserAuthListener {
  // This class will listen to auth changes and errors we get while trying to authenticate
  void authStateChanges(User? user);
  void userAuthFailure(String errorMessage);
}