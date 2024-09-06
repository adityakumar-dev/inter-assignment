import 'package:flutter/material.dart';
import 'package:intern_assignment/Screens/Home/home_screen.dart';
import 'package:intern_assignment/services/Auth/auth_service.dart';
import 'package:intern_assignment/Screens/Login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Authservice().authStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const LoginScreen();
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
