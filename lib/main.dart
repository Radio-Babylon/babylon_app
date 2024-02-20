import 'package:babylon_app/firebase_options.dart';
import 'package:babylon_app/service/auth/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register1.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Babylon Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF006400),
        ),
        scaffoldBackgroundColor: Colors.white,
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
            child: Image.asset('assets/images/logoSquare.png'),
          ),
          const SizedBox(height: 45), // Space between logo and text
          const Text(
            'Welcome to Babylon Radio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(
              height: 60), // Space between Welcome text and catchphrase
          const Text(
            'Celebrating cultures,\n' //\n breaks the line
            ' promoting integration',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 90), // Space between catchphrase and buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: ElevatedButton(
              onPressed: () async {
                // AuthService.registerUsingEmailPassword(name: "oui", email: "oui@oui.com", password:"ouioui");
                // print(FirebaseAuth.instance.currentUser);
                // var data = FirebaseFirestore.instance.collection('test');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006400), // Background color of the button
                minimumSize: const Size(350, 80), // Set the button size
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lato',
                  color: Colors.white, // Text color of the button
                ),
              ),
            ),
          ),
          const SizedBox(height: 25), // Space between buttons
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
                side: const BorderSide(
                    width: 2.0, color: Colors.grey), // Border width and color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
