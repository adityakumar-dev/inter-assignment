import 'package:flutter/material.dart';

Future<void> progressIndicator(context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
