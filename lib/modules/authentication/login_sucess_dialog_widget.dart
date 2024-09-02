import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dashboard/dashboard_screen.dart';

class LoginSuccessDialogWidget extends StatelessWidget {
  const LoginSuccessDialogWidget({super.key});


  static bool isDialogVisible = false;

  @override
  Widget build(BuildContext context) {
    isDialogVisible = true;
    return PopScope(
      canPop: false,
      child: Container(
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 50.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Success",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "User Logged In Successfully",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Get.back();
                  FirebaseAuth.instance.signOut();
                  isDialogVisible = false;
                  Get.offAll(
                    () =>  DashboardScreen(),
                  );
                  
                },
                child: const Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}