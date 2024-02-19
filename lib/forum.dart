import 'package:flutter/material.dart';
import 'forumTopic.dart';

class ForumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text(
            'Forum Screen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato',
            ),
          ),
          const SizedBox(height: 48), // Space between catchphrase and buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => topicForum()),
                );
              },
              child: const Text('Go to Topic'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 80), // Set the button size
                textStyle: const TextStyle(fontSize: 24, fontFamily: 'Lato'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}