import 'package:flutter/material.dart';

Widget getDataFun(
  String txt,
  Function() onPress,
) {
  return ElevatedButton(
      onPressed: () async {
        await onPress();
      },
      child: Text(txt));
}
