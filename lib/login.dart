import 'package:flutter/material.dart';
import 'home.dart'; // Asegúrate de que home.dart esté en el directorio correcto y tenga una clase HomePage

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView( // Usar SingleChildScrollView para evitar overflow cuando el teclado aparezca
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo
            Image.asset('assets/images/logoRectangle.png',
            height: 90,
            width: 365),
            SizedBox(height: 48), // Space after logo
            // Title
            Text(
              'Login into your account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24), // Space after title
            // Email text field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16), // Space between text fields
            // Password text field
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24), // Space after text fields
            // Login button that navigates to HomePage on press
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF006400),
                minimumSize: Size(365, 60), // Size of the button.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0), // Rounded edges for the button.
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => homePage()),
                );
              },
              child: const Text('Login',
                style: TextStyle(color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Lato',),
              ),
            ),
            SizedBox(height: 32), // Space after Login button
            // Social media buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Facebook login button
                _buildSocialButton(
                  'assets/images/facebook.png', // Replace with your asset
                      () {
                    // TODO: Implement Facebook login functionality
                  },
                ),
                // Google login button
                _buildSocialButton(
                  'assets/images/google.png', // Replace with your asset
                      () {
                    // TODO: Implement Google login functionality
                  },
                ),
                // Twitter login button
                _buildSocialButton(
                  'assets/images/twitter.jpeg', // Replace with your asset
                      () {
                    // TODO: Implement Twitter login functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath, VoidCallback onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Image.asset(iconPath), // The social icon
      backgroundColor: Colors.white,
      elevation: 0, // Remove shadow
    );
  }
}

class HomePage extends StatelessWidget {
  // TODO: Implement your HomePage widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Welcome to the Home Page!"),
      ),
    );
  }
}
