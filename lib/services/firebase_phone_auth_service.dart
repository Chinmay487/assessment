

import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_user_auth_listener.dart';
import 'phone_number_auth_listener.dart';

class FirebasePhoneAuthService {
final PhoneNumberAuthListener phoneNumberAuthListener;
final FirebaseUserAuthListener firebaseUserAuthListener;

FirebasePhoneAuthService({
  required this.phoneNumberAuthListener,
  required this.firebaseUserAuthListener,
});

   Future<void> sendOtpToContactNumber({
    required String contactNumber,
  }) async {
    String countryCode = "+91";
    String finalContactNumber = "$countryCode $contactNumber";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: finalContactNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException error) {
            phoneNumberAuthListener.onVerificationError(error?.message ?? "");
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            phoneNumberAuthListener.onCodeSent(
                verificationId, forceResendingToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      phoneNumberAuthListener.onVerificationError("Error Sending Code");
    }  

  }

   Future<void> confirmEnteredOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      await _auth.signInWithCredential(credential).then((UserCredential userCredential){
        firebaseUserAuthListener.authStateChanges(userCredential.user);
      });
    } catch (e) {
      firebaseUserAuthListener.userAuthFailure("Error Validating OTP");
    }
  }

}
