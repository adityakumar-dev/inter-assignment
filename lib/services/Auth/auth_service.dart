import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_assignment/widgets/progress_indecator.dart';

class Authservice {
  final Stream<User?> authStream = FirebaseAuth.instance.authStateChanges();
  Future<void> anoymouseLogin(context) async {
    progressIndicator(context);
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> logoutUser(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }
}
