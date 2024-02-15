import 'package:flutter/material.dart';
import 'home.dart';
import 'chat.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text(
            'Chats Screen',
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
                  MaterialPageRoute(builder: (context) => chatting()),
                );
              },
              child: const Text('Open Chat'),
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