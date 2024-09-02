import 'package:flutter/material.dart';

import 'package:get/get.dart';

bool _isDialogOpen = false;

void showLoadingDialog() {
  _isDialogOpen = true;
  Get.defaultDialog(
    barrierDismissible: false,
    title: "",
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    content: PopScope(
      canPop: false,
      child: Container(
        height: Get.height * 0.15,
        width: Get.width * 0.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: const Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 5.0,
              color: Colors.deepPurple,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please Wait",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void hideLoadingDialog() {
  if (_isDialogOpen) {
    Get.back();
  }
  _isDialogOpen = false;
}
