import 'package:babylon_app/services/auth/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home.dart'; // Asegúrate de que home.dart esté en el directorio correcto y tenga una clase HomePage

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
  String? _error;

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
    _error = "";
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _error = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Logo
        Image.asset('assets/images/logoRectangle.png', height: 90, width: 365),
        SizedBox(height: 50), // Space after logo
        // Title
        Text(
          'Login into your account',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              _error!,
              style: TextStyle(color: Colors.red),
            )),
        SizedBox(height: 50), // Space after title
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Email',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          controller: _email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20), // Space between text fields
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
              borderRadius:
                  BorderRadius.circular(60.0), // Rounded edges for the button.
            ),
          ),
          onPressed: () async {
            try {
              User? loginUser = await AuthService.signInUsingEmailPassword(
                  email: _email.text, password: _password.text);
              if (loginUser is User)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
            } catch (e) {
              setState(() {
                _error = (e as FirebaseAuthException).message;
              });
            }
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
      ],
    );
  }
}
