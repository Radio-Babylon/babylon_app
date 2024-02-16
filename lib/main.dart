import 'package:flutter/material.dart';
import 'register1.dart';
import 'login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Babylon Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Lato'),
        ),
      ),
      home: const LogoScreen(),
    );
  }
}

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60), // Padding top for logo
          SizedBox(
            height: 185,
            width: 185,
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(height: 30), // Space between logo and text
          const Text(
            'Welcome to Babylon Radio',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 12), // Space between Welcome text and catchphrase
          const Text(
            'Celebrating cultures, promoting integration',

            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 48), // Space between catchphrase and buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 80), // Set the button size
                textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'),
              ),
            ),
          ),
          const SizedBox(height: 18), // Space between buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: OutlinedButton(
              onPressed: () {
                // Usa Navigator.push to navigate into RegisterScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountPage()),
                );
              },
              child: const Text('Register'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(350, 80), // Set the button size
                textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'),
                side: const BorderSide(width: 2.0, color: Colors.grey), // Border width and color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
