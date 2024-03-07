import 'package:babylon_app/services/auth/authExceptions.dart';
import 'package:babylon_app/services/auth/authService.dart';
import 'package:babylon_app/services/user/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register2.dart';

class CreateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Account'), // Title of the AppBar.
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0), // Padding around the form.
        alignment: Alignment.center,
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

  late final TextEditingController _name;
  late final TextEditingController _dateOfBirth;
  late final TextEditingController _email;
  late final TextEditingController _county;
  late final TextEditingController _password;
  late final TextEditingController _rePassword;
  String? _error;

  late final Map<String, TextEditingController> userInfoController = {
    'Name': _name,
    'Date of Birth': _dateOfBirth,
    'Email Address': _email,
    'Country of Origin': _county,
    'Password': _password,
    'Confirm Password': _rePassword,

  };

  late final Map<String, String> userInfo = {
    'Name': _name.text,
    'Date of Birth': _dateOfBirth.text,
    'Email Address': _email.text,
    'Country of Origin': _county.text,
  };

  @override
  void initState() {
    _name = TextEditingController();
    _dateOfBirth = TextEditingController();
    _email = TextEditingController();
    _county = TextEditingController();
    _password = TextEditingController();
    _rePassword = TextEditingController();
    _error = "";
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _dateOfBirth.dispose();
    _email.dispose();
    _county.dispose();
    _password.dispose();
    _rePassword.dispose();
    _error = "";
    super.dispose();
  }

  Widget _buildTextField({required String labelText, bool isPassword = false, bool hasDatePicker = false}) {
    // Helper method to build text fields with common styling.
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 16.0), // Adds space between text fields.
      child: TextFormField(
        controller: userInfoController[labelText],
        decoration: InputDecoration(
          labelText: labelText, // Label text for the field.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                5.0), // Rounded corners for the input field.
          ),
          filled: true,
          fillColor: Colors.white, // Background color of the text field.
        ),
        obscureText: isPassword, // Hides text input if it's a password field.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText'; // Validation message.
          }
          return null;
        },
        readOnly: hasDatePicker,
        onTap: () async {
          if(hasDatePicker){
            DateTime? pickedDate = await showDatePicker(
              context: context, initialDate: DateTime.now(),
              firstDate: DateTime(1901),
              lastDate: DateTime(2101)
            );
                  
            if(pickedDate != null ){
              print(pickedDate);
              setState(() {
                  _dateOfBirth.text = "${pickedDate.year}-${pickedDate.month < 10 ? "0${pickedDate.month}" : pickedDate.month}-${pickedDate.day}";
              });
            }
          }
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
            Image.asset(
              'assets/images/logoRectangle.png', // Path to the logo image.
              width: 365, // Width of the logo.
              height: 90, // Height of the logo.
              fit: BoxFit
                  .contain, // Makes sure the logo is contained properly within the box.
            ),
            SizedBox(height: 30), // Bottom padding for the logo.
            // Calls the helper method to build text fields.
            _buildTextField(labelText: 'Name'),
            _buildTextField(labelText: 'Date of Birth', hasDatePicker: true),
            _buildTextField(labelText: 'Email Address'),
            // _buildTextField(labelText: 'Country of Origin'),
            _buildTextField(labelText: 'Password', isPassword: true),
            _buildTextField(labelText: 'Confirm Password', isPassword: true),
            Padding(padding: EdgeInsets.symmetric(vertical: 8),
              child:
                Text(
                  _error!,
                  style: TextStyle(color: Colors.red),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8), // Adds vertical padding around the button.
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF006400),
                  minimumSize: Size(365, 60), // Size of the button.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        60.0), // Rounded edges for the button.
                  ),
                ),
                onPressed: () async {
                  final fullName = '${_name.text}';
                  try {
                    AuthException.validateRegisterForm(_name.text, _email.text, _password.text, _rePassword.text, _dateOfBirth.text);
                    User? currentUser =
                      await AuthService.registerUsingEmailPassword(
                          name: fullName,
                          email: _email.text,
                          password: _password.text);
                    if (currentUser is User) {
                      await UserService.fillUser(user: currentUser, userInfo: userInfo);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage2()),
                      );
                    }
                  } catch (e) {
                    if(e is FirebaseAuthException)
                      setState(() {
                        _error = (e as FirebaseAuthException).message; 
                      });
                    else
                      setState(() {
                        _error = e.toString(); 
                      });
                  }
                  if (!mounted) return;
                  //Navigator.of(context).pop();
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Lato',
                  ),
                  // Text displayed on the button.
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
