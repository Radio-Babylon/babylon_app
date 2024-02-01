import 'package:flutter/material.dart';

class NewActivityScreen extends StatelessWidget {
  final int counterValue;
  NewActivityScreen({required this.counterValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Activity"),
      ),
      body: Center(
        child: Text("Welcome to the new activity!   Your number was: $counterValue"),
      ),
    );
  }
}