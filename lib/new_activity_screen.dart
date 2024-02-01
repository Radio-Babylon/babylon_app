import 'package:flutter/material.dart';

class NewActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Activity"),
      ),
      body: Center(
        child: Text("Welcome to the new activity!"),
      ),
    );
  }
}