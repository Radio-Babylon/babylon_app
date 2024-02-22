import 'package:flutter/material.dart';
import 'home.dart'; // Make sure this import is correct for your HomeScreen widget

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Replaced the menu icon with an arrow back icon
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to HomeScreen when the arrow is pressed
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade300,
              child: Text('profile picture',
                  style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                // Handle edit profile picture
              },
              child: Text('edit'),
            ),
            // Profile information and interests
            _buildProfileSection(context),
            // Adding the Logout button at the bottom of the page
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout logic
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Refactored profile section into a method for better readability
  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name',
                        style: Theme.of(context).textTheme.headline6),
                    Text(
                      'short bio short bio short bio short bio short bio short bio',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text('Age', style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interests', style: Theme.of(context).textTheme.subtitle1),
              _buildInterests(),
              SizedBox(height: 20),
              Text('Languages', style: Theme.of(context).textTheme.subtitle1),
              _buildLanguages(),
            ],
          ),
        ),
        ListTile(
          title: Text('My Plan'),
          subtitle: Text('Monthly subscription'),
          trailing: Wrap(
            spacing: 12,
            children: [
              TextButton(
                onPressed: () {
                  // Handle change plan
                },
                child: Text('change'),
              ),
              TextButton(
                onPressed: () {
                  // Handle cancel plan
                },
                child: Text('cancel'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Method to build interests chips
  Widget _buildInterests() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        6,
        (index) => Chip(
          label: Text('interest ${index + 1}'),
        ),
      ),
    );
  }

  // Method to build languages chips
  Widget _buildLanguages() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: ['language 1', 'language 2', 'language 3']
          .map((lang) => Chip(label: Text(lang)))
          .toList(),
    );
  }
}
