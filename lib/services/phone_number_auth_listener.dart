

abstract class PhoneNumberAuthListener {
  // This will listen to OTP sent event and error we get while sending otp to user
  void onCodeSent(String verificationId, int? forceResendingToken);
  void onVerificationError(String error);
}
