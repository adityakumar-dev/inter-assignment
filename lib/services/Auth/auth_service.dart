import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intern_assignment/widgets/progress_indecator.dart';

class Authservice {
  final Stream<User?> authStream = FirebaseAuth.instance.authStateChanges();

  Future<void> anonymousLogin(BuildContext context) async {
    progressIndicator(context);

    try {
      await FirebaseAuth.instance.signInAnonymously();

      // Delay navigation until after the widget is still mounted
      if (context.mounted) {
        context.pop();
        context.go('/home');
      }
    } catch (e) {
      print("Error signing in anonymously: $e");
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        context.go('/');
      }
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
