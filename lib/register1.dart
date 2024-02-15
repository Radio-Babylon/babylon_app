import 'package:flutter/material.dart';
import 'register2.dart';


class CreateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Account'), // Title of the AppBar.
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Padding around the form.
        child: CreateAccountForm(), // The form widget for account creation.
      ),
    );
  }
}

class CreateAccountForm extends StatefulWidget {
  @override
  CreateAccountFormState createState() => CreateAccountFormState();
}

class CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>(); // Key for identifying the form.

  Widget _buildTextField({required String labelText, bool isPassword = false}) {
    // Helper method to build text fields with common styling.
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Adds space between text fields.
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText, // Label text for the field.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0), // Rounded corners for the input field.
          ),
          filled: true,
          fillColor: Colors.grey[200], // Background color of the text field.
        ),
        obscureText: isPassword, // Hides text input if it's a password field.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText'; // Validation message.
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey, // Associates the form with the form key.
        child: Column(
          children: <Widget>[
            SizedBox(height: 37), // Top padding for the logo.
            Image.asset(
              'assets/images/logo.png', // Path to the logo image.
              width: 365, // Width of the logo.
              height: 90, // Height of the logo.
              fit: BoxFit.contain, // Makes sure the logo is contained properly within the box.
            ),
            SizedBox(height: 37), // Bottom padding for the logo.
            // Calls the helper method to build text fields.
            _buildTextField(labelText: 'Name'),
            _buildTextField(labelText: 'Surname'),
            _buildTextField(labelText: 'Date of Birth'),
            _buildTextField(labelText: 'Email Address'),
            _buildTextField(labelText: 'Country of Origin'),
            _buildTextField(labelText: 'Password', isPassword: true),
            _buildTextField(labelText: 'Confirm Password', isPassword: true),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0), // Adds vertical padding around the button.
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(365, 60), // Size of the button.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded edges for the button.
                  ),
                ),
                onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage2()),
                );
                },
                child: Text('Next'),
                // Text displayed on the button.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
