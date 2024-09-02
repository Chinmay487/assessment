import 'package:assessment/modules/authentication/enter_contect_number_screen.dart';
import 'package:assessment/modules/dashboard/dashboard_screen.dart';
import 'package:assessment/modules/rive_demo/rive_demo_screen.dart';
import 'package:assessment/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/database_demo/enter_email_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Assessment App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
          titleSmall: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(5.0),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade600,
            shape: const StadiumBorder(),
          ),
        ),
      ),
      initialRoute: AppRoutes.dashboardScreen,
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.enterContactNumberScreen: (_) =>
            const EnterContactNumberScreen(),
        AppRoutes.enterEmailScreen: (_) => const EnterEmailScreen(),
        AppRoutes.dashboardScreen: (_) => const DashboardScreen(),
        AppRoutes.riveAnimationDemoScreen : (_)=>const RiveDemoScreen(),
      },
    );
  }
}
