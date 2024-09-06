import 'package:flutter/material.dart';

class DynamicLinkScreen extends StatefulWidget {
  const DynamicLinkScreen({super.key});

  @override
  State<DynamicLinkScreen> createState() => _DynamicLinkScreenState();
}

class _DynamicLinkScreenState extends State<DynamicLinkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Link Text Posts"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("Text posts will show here")],
        ),
      ),
    );
  }
}
