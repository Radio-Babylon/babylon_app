import 'package:flutter/material.dart';
import 'register1.dart'; // Importing the register screen

void main() {
  runApp(const MyApp()); // Entry point of the application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor with optional key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Babylon Radio', // Application title
      theme: ThemeData( // Defines the custom theme of the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Base color for the theme
        useMaterial3: true, // Opting in for Material 3 design
        textTheme: const TextTheme( // Custom text theme
          bodyMedium: TextStyle(fontFamily: 'Lato'), // Specifying default font family
        ),
      ),
      home: const LogoScreen(), // Sets the home screen of the app
    );
  }
}

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key}); // Constructor with optional key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60), // Adds top padding for the logo
          SizedBox(
            height: 185,
            width: 185,
            child: Image.asset('assets/images/logo.png'), // Loads the logo image from assets
          ),
          const SizedBox(height: 30), // Adds space between the logo and the welcome text
          const Text(
            'Welcome to Babylon Radio', // Welcome text
            textAlign: TextAlign.center, // Centers the text
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato', // Custom font family
            ),
          ),
          const SizedBox(height: 12), // Adds space between the welcome text and the catchphrase
          const Text(
            'A nice catch phrase', // Catchphrase text
            textAlign: TextAlign.center, // Centers the text
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato', // Custom font family
            ),
          ),
          const SizedBox(height: 48), // Adds space before the buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: ElevatedButton(
              onPressed: () {}, // Placeholder for login functionality
              child: const Text('Login'), // Login button text
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 80), // Sets the button size
                textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'), // Custom text style
              ),
            ),
          ),
          const SizedBox(height: 18), // Adds space between the buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: OutlinedButton(
              onPressed: () {
                // Uses Navigator.push to navigate to the Register screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountPage()),
                );
              },
              child: const Text('Register'), // Register button text
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(350, 80), // Sets the button size
                textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'), // Custom text style
                side: const BorderSide(width: 2.0, color: Colors.grey), // Sets border width and color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
