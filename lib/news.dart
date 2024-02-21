import 'package:babylon_app/service/wpGraphQL/wpGraphQLService.dart';
import 'package:flutter/material.dart';
import 'reading_news.dart';

class NewsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Text(
            'News Screen',
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
                WpGraphQLService.getNewPosts();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => readingNews()),
                );
              },
              child: const Text('Read the news'),
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