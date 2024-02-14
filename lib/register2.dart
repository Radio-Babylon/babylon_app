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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset('assets/images/logo.png', height: 120, width: 120),
          const Text(
            'Before we finish, let\'s set up your profile',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 80,
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
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage3()),
              );
            },
            child: const Text('Next'),
          ),

          TextButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage3()),
              );
            },
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}
