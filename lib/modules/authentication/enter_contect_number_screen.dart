

import 'package:assessment/services/firebase_phone_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../services/firebase_user_auth_listener.dart';
import '../../services/phone_number_auth_listener.dart';
import '../../utils/loading_dialog_util.dart';
import 'login_sucess_dialog_widget.dart';

class EnterContactNumberScreen extends StatefulWidget {
  const EnterContactNumberScreen({super.key});

  @override
  State<EnterContactNumberScreen> createState() =>
      _EnterContactNumberScreenState();
}

class _EnterContactNumberScreenState extends State<EnterContactNumberScreen>
    implements PhoneNumberAuthListener, FirebaseUserAuthListener {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isOtpSent = false;
  bool isCounterEnd = false;

  String verificationId = "";
  int? forceResendingToken;

  FirebasePhoneAuthService? firebasePhoneAuthService;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      firebasePhoneAuthService = FirebasePhoneAuthService(
        phoneNumberAuthListener: this,
        firebaseUserAuthListener: this,
      );
    });
  }

  @override
  void dispose() {
    firebasePhoneAuthService = null;
    super.dispose();
  }

  void onSendOtpClick() async {
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return;
    }

    FocusScope.of(context).unfocus();
    String contactNumber = contactNumberController.text.toString();
    // log("contactNumber $contactNumber");
    // return;
    showLoadingDialog();
    firebasePhoneAuthService?.sendOtpToContactNumber(
      contactNumber: contactNumber,
    );
  }

  void onVerifyOtpClick() {
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return;
    }

    FocusScope.of(context).unfocus();
    showLoadingDialog();

    firebasePhoneAuthService?.confirmEnteredOtp(
      verificationId: verificationId,
      smsCode: otpController.text.toString(),
    );
  }

  void onResendOtpClick() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Number OTP Demo"),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              elevation: 15.0,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Verify Contact Number",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Phone Number",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color(0xff737373),
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: contactNumberController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          counterText: "",
                          prefixIcon: Icon(Icons.phone),
                          hintText: "Enter Phone Number",
                        ),
                        onChanged: (value) {
                          setState(() {
                            isOtpSent = false;
                          });
                        },
                        validator: (value) {
                          String contactNumberPattern =
                              r"^[6-9]\d{9}$";
                          RegExp contactNumberRegex =
                              RegExp(contactNumberPattern);
                          String? errorMessage = (value?.isEmpty ?? true)
                              ? "Phone Number Required"
                              : !contactNumberRegex.hasMatch(value ?? "")
                                  ? "Invalid Contact Number"
                                  : null;
                          return errorMessage;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      if (isOtpSent)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "OTP",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xff737373),
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              validator: (value) {
                                return isOtpSent
                                    ? value?.isEmpty ?? true
                                        ? "Required"
                                        : value!.length < 6
                                            ? "Enter Valid OTP"
                                            : null
                                    : null;
                              },
                              decoration: const InputDecoration(
                                counterText: "",
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Enter OTP",
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              isOtpSent ? onVerifyOtpClick : onSendOtpClick,
                          child: Text(
                            isOtpSent ? "Verify OTP" : "Send OTP",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onCodeSent(String verificationId, int? forceResendingToken) {
    
    hideLoadingDialog();
    Fluttertoast.showToast(msg: "OTP Sent");
    this.verificationId = verificationId;
    this.forceResendingToken = forceResendingToken;
    setState(() {
      isOtpSent = true;
    });
  }

  @override
  void authStateChanges(User? user) {
    hideLoadingDialog();

    if (user is User) {
      _clearTextFieldsAndResetForm();
      showLoginSuccessDialog();
    }
  }

  @override
  void onVerificationError(String error) {
    hideLoadingDialog();

    Fluttertoast.showToast(msg: "Phone Number Verification Failed");
  }

  void showLoginSuccessDialog() {
    if (LoginSuccessDialogWidget.isDialogVisible) {
      return;
    }
    Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: const LoginSuccessDialogWidget(),
    );
  }

  @override
  void userAuthFailure(String errorMessage) {
    hideLoadingDialog();
    Fluttertoast.showToast(msg: "Phone Number Verification Failed");
  }

  void _clearTextFieldsAndResetForm() {
    contactNumberController.clear();
    otpController.clear();
    isOtpSent = false;
    // setState(() {});
  }
}
