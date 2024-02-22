import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back button
        leading: IconButton(
          icon: Icon(Icons.menu),
      onPressed: () {
        // To show a simple popup menu when the menu icon is pressed
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(25.0, kToolbarHeight, 0.0, 0.0), // Positioning the menu below the AppBar
          items: [
            PopupMenuItem<String>(
              value: 'profile',
              child: Text('Profile'),
            ),
            PopupMenuItem<String>(
              value: 'settings',
              child: Text('Settings'),
            ),
            PopupMenuItem<String>(
              value: 'logout',
              child: Text('Logout'),
            ),
            // Add more PopupMenuItems as needed
          ],
        ).then((value) {
          // Handle the selection
          if (value != null) {
            switch (value) {
              case 'profile':
              // Navigate to profile page or handle profile logic
                break;
              case 'settings':
              // Navigate to settings page or handle settings logic
                break;
              case 'logout':
              // Handle logout logic
                break;
            // Handle other menu options
    }
    }
    });
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
              child: Text(
                  'profile picture', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                // Handle edit profile picture
              },
              child: Text('edit'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Full Name', style: Theme
                            .of(context)
                            .textTheme
                            .headline6),
                        Text(
                          'short bio short bio short bio short bio short bio short bio',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text('Age', style: Theme
                      .of(context)
                      .textTheme
                      .headline6),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Interests', style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      6,
                          (index) =>
                          Chip(
                            label: Text('interest ${index + 1}'),
                          ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Languages', style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: ['language 1', 'language 2', 'language 3']
                        .map((lang) => Chip(label: Text(lang)))
                        .toList(),
                  ),
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
        ),
      ),
    );
  }
}