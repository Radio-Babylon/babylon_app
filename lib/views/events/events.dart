import 'package:flutter/material.dart';
import 'events-info.dart'; // This file should contain the EventInfoScreen class.

// Define the Event class with all necessary information about an event, including the host and location.
class Event {
  final String title;
  final String date;
  final String time;
  final String description;
  final String host;
  final String location;

  Event(this.title, this.date, this.time, this.description, this.host, this.location);
}

// Define the EventsScreen as a StatefulWidget to handle dynamic content like user events.
class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

// Define the corresponding State class for EventsScreen with TabController for tab navigation.
class _EventsScreenState extends State<EventsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Custom drawer widget for navigation.
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Events'),
            SizedBox(
              height: 55,
              width: 55,
              child: Image.asset('assets/images/logowhite.png'), // Your logo asset.
            ),
          ],
        ),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'UPCOMING EVENTS'),
            Tab(text: 'MY EVENTS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventList(upcomingEvents),
          // Assuming _buildEventList is a method that returns a list of event cards.
          _buildEventList([upcomingEvents[0]]), // Example for 'My Events' tab.
        ],
      ),
    );
  }

  // Method to build a list view of event cards.
  Widget _buildEventList(List<Event> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(events[index]);
      },
    );
  }

  // Method to build a single event card widget.
  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset('assets/images/logoSquare.png', width: 100),
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${event.date} at ${event.time}'),
            Text(event.description, maxLines: 3, overflow: TextOverflow.ellipsis),
            Text('Host: ${event.host}'), // Display the host of the event.
            Text('Location: ${event.location}'), // Display the location of the event.
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            // When the info button is pressed, navigate to the EventInfoScreen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventInfoScreen(event: event),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Example list of events with host and location included.
final List<Event> upcomingEvents = [
  Event('Music Concert', '25th Dec', '6:00 PM', 'An amazing music experience lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 'DJ Mike', 'The Grand Arena'),
  Event('Art Exhibition', '1st Jan', '12:00 PM', 'Explore the works of modern artists', 'Art Collective', 'Downtown Gallery'),
  Event('Tech Conference', '15th Jan', '9:00 AM', 'Discover cutting-edge technology trends', 'Tech Innovators', 'Convention Center'),
];
