import 'package:flutter/material.dart';
import 'package:babylon_app/views/profile/FullScreenImage.dart';
// Importa aquí el archivo FullScreenImage si se encuentra en otro archivo
// import 'path/to/full_screen_image.dart';


// Define the UserProfile class to hold user information.
class UserProfile {
  final String profilePic;
  final String name;
  final int age;
  final String country;
  final String about;

  UserProfile({required this.profilePic, required this.name, required this.age, required this.country, required this.about});
}

// Main widget for displaying user's profile details.
class OtherProfile extends StatelessWidget {
  // Example user data.
  final UserProfile user = UserProfile(
    profilePic: 'assets/images/profilephoto2.jpg', // Placeholder for profile picture asset.
    name: 'Jane Doe',
    age: 28,
    country: 'Canada',
    about: 'Passionate traveler and photography enthusiast. Love to explore new cultures and meet new people.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.green, // AppBar background color.
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            GestureDetector(
              // Tapping on the profile picture opens the FullScreenImage view.
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FullScreenImage(imagePath: user.profilePic, name: user.name)),

              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(user.profilePic), // Display user's profile picture.
              ),
            ),
            SizedBox(height: 10),
            Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // Display user's name.
            Text('${user.age} years old, from ${user.country}', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)), // Display user's age and country.
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(user.about, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)), // Display user's about section.
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Button to send a friend request.
                ElevatedButton.icon(
                  icon: Icon(Icons.person_add),
                  label: Text('Add Friend'),
                  onPressed: () {
                    // TODO: Implement functionality to send friend request.
                  },
                  style: ElevatedButton.styleFrom( foregroundColor:Colors.white, backgroundColor: Colors.blue),
                ),
                // Button to start a chat.
                ElevatedButton.icon(
                  icon: Icon(Icons.chat),
                  label: Text('Chat'),
                  onPressed: () {
                    // TODO: Implement functionality to start chatting.
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
