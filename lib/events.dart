import 'package:babylon_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'events-info.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const PublicDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Events'),
            SizedBox(
              height: 55,
              width: 55,
              child: Image.asset('assets/images/logowhite.png'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          const Text(
            'Events Screen',
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
                  MaterialPageRoute(builder: (context) => eventsInfo()),
                );
              },
              child: const Text('See events Info'),
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
