import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:babylon_app/navigation_menu.dart';

class RadioScreen extends StatelessWidget {
  // The URL you want to open
  final Uri _url = Uri.parse('https://www.mixcloud.com/live/BabylonRadio/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PublicDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Radio'),
            SizedBox(
              height: 55,
              width: 55,
              child: Image.asset('assets/images/logowhite.png'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey[200], // Light grey background
      body: Center( // Center the content
        child: Column(


          mainAxisAlignment: MainAxisAlignment.center, // Center the column content vertically
          children: <Widget>[

            Image.asset('assets/images/logoRectangle.png',
                height: 90, width: 365),
            SizedBox(height: 50), // Space after logo
            // Title


            SizedBox(height: 48), // Space between text and button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: ElevatedButton.icon(
                icon: Icon(Icons.radio, size: 28), // Radio icon for the button
                label: Text('Listen Babylon Radio'),
                onPressed: _launchURL, // Call the method to launch the URL when button is pressed
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Text Color
                  backgroundColor: Color(0xFF006400), // White color for the text and icon
                  minimumSize: Size(350, 80), // Set the size of the button
                  textStyle: TextStyle(fontSize: 24, fontFamily: 'Lato'), // Apply text style
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners for the button
                  ),
                  elevation: 4, // Shadow for the button
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
