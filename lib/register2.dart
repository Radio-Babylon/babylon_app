import 'package:babylon_app/home.dart';
import 'package:babylon_app/service/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'register3.dart';

class RegisterPage2 extends StatefulWidget {
  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Profile'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 20), // Adjust overall horizontal spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(bottom: 25), // Adjust space below the logo
              child: Image.asset(
                'assets/images/logoRectangle.png',
                height: 90,
                width: 365,
              ),
            ),
            const Text(
              'Before we finish, let\'s set up your profile',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 125,
                backgroundColor: Color(0xFF006400),
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Text('Photo') : null,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: getImage,
              child: const Text('Select file'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006400),
                minimumSize: Size(365, 60), // Size of the button.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      60.0), // Rounded edges for the button.
                ),
              ),
              onPressed: () async {
                final currentUser = FirebaseAuth.instance.currentUser;

                if (currentUser != null) {
                  if (_image != null) {
                    await UserService.addPhoto(
                        user: currentUser, file: _image!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please upload an image')));
                  }
                }
                if (!mounted) return;

                // disable register's second view
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RegisterPage3()),
                // );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text(
                'Finish',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical:
                      20), // Adjust space above and below the "Skip" button
              child: TextButton(
                onPressed: () {
                  // disable 3rd register screen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => RegisterPage3()),
                  // );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text('Skip'),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(365, 60), // Set the button size
                  textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'),
                  side: const BorderSide(width: 2.0, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
