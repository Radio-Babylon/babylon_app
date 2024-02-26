import 'package:babylon_app/service/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart'; // Asegúrate de que home.dart esté en el directorio correcto y tenga una clase HomePage

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'), // Title of the AppBar.
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Padding around the form.
        child: LoginForm(), // The form widget for account creation.
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Key for identifying the form.

  late final TextEditingController _email;
  late final TextEditingController _password;

  late final Map<String, TextEditingController> userInfoController = {
    'Email': _email,
    'Pasword': _password,
  };

  late final Map<String, String> userInfo = {
    'Email': _email.text,
    'Pasword': _password.text,
  };

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // Usar SingleChildScrollView to avoid overflow when the keyboard comes up
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo
            Image.asset('assets/images/logoRectangle.png',
                height: 90, width: 365),
            SizedBox(height: 50), // Space after logo
            // Title
            Text(
              'Login into your account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50), // Space after title
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20), // Space between text fields
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: _password,
              obscureText: true,
            ),

            SizedBox(height: 25), // Space after text fields
            // Login button that navigates to HomePage on press
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006400),
                minimumSize: Size(365, 60), // Size of the button.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      60.0), // Rounded edges for the button.
                ),
              ),
              onPressed: () async{
                User? loginUser = await AuthService.signInUsingEmailPassword(email: _email.text, password: _password.text);
                if(loginUser != null)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            SizedBox(height: 35), // Space after Login button
            // Social media buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Facebook login button
                _buildSocialButton('assets/images/facebook.png', () {
                  // onPressed function
                }, 55),
                // Google login button
                _buildSocialButton(
                    'assets/images/google.png', // Replace with your asset
                    () {
                  // TODO: Implement Google login functionality
                }, 55),
                // Twitter login button
                _buildSocialButton(
                    'assets/images/linkln.png', // Replace with your asset
                    () {
                  // TODO: Implement Twitter login functionality
                }, 55),
              ],
            ),
          ],
        ),
    );
  }

  Widget _buildSocialButton(
      String iconPath, VoidCallback onPressed, double size) {
    return Container(
      width: size,
      height: 85,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Image.asset(iconPath), // The social icon
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
      ),
    );
  }
}