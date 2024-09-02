import 'package:assessment/utils/app_routes.dart';
import 'package:flutter/material.dart';

import '../../utils/common_style.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.enterContactNumberScreen);
              },
              child: const Text(
                "Phone Number OTP Demo",
                style: buttonTextStyle,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.enterEmailScreen);
              },
              child: const Text(
                "Local Database Demo",
                style: buttonTextStyle,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.riveAnimationDemoScreen);
              },
              child: const Text(
                "Rive Animation Demo",
                style: buttonTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
