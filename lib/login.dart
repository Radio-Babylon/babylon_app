import 'package:flutter/material.dart';
import 'home.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
      // Usa Navigator.push para navegar a RegisterScreen
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => homePage()),
    );
  },
        child: const Text('Login'),
    style: OutlinedButton.styleFrom(
    minimumSize: const Size(350, 80), // Set the button size
    textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'),
    side: const BorderSide(width: 2.0, color: Colors.grey), // Border width and color
    ),
    )
      ),
    );
  }
}