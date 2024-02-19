import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RadioScreen extends StatelessWidget {
  // The URL you want to open
  final Uri _url = Uri.parse('https://www.mixcloud.com/live/BabylonRadio/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Center the content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the column content vertically
          children: <Widget>[
            const Text(
              'News Screen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24, // Increased font size for better readability
                fontWeight: FontWeight.w300,
                fontFamily: 'Lato',
              ),
            ),
            const SizedBox(height: 48), // Space between text and button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: ElevatedButton(
                onPressed: _launchURL, // Call the method to launch the URL when button is pressed
                child: const Text('Listen Babylon Radio'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 80), // Set the size of the button
                  textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'), // Apply text style
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to launch the URL
  void _launchURL() async {
    if (!await launchUrl(_url)) { // Check if the URL can be launched
      throw 'Could not launch $_url';
    }
  }
}