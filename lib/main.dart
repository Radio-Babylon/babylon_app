import 'package:babylon_app/firebase_options.dart';
import 'package:babylon_app/home.dart';
import 'package:babylon_app/service/auth/auth_service.dart';
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
    User? currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);

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
      home: currentUser != null ? HomePage() : LogoScreen(),
      routes: {
        '/logo/': (context) => const LogoScreen(),
        '/register/': (context) => CreateAccountPage()
      },
    );
  }
}

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 45),
            child: Image.asset('assets/images/logoSquare.png', width: 185, height: 185),
          ),
          const Text(
            'Welcome to Babylon Radio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 50),
            child: const Text(
              'Celebrating cultures,\n' //\n breaks the line
              ' promoting integration',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(21),
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF006400), // Background color of the button
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
          Container(
            margin: const EdgeInsets.only(left: 21, right: 21, bottom: 21),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Text("Continue with", style: TextStyle(fontSize: 24, fontFamily: 'Lato')),
                ),
                Flexible(
                  flex: 1,
                  child:
                    _buildSocialButton(
                    'assets/images/google.png', // Replace with your asset
                    () async {
                      try {
                        UserCredential? loginUser = await AuthService.signInWithGoogle();
                        if(loginUser is UserCredential)
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } catch (e) {
                          print(e.toString()); 
                        }; 
                      }, 55)
                ),
                Flexible(
                  flex: 1,
                  child:
                    _buildSocialButton(
                      'assets/images/facebook.png', // Replace with your asset
                      () async {
                        try {
                          
                        } catch (e) {
                          print(e.toString()); 
                        }; 
                      }, 55)
                )
              ] 
            )
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    String iconPath, VoidCallback onPressed, double height) {
    return Container(
      height: height,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Image.asset(iconPath), // The social icon
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
      ),
    );
  }
}
