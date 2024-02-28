import 'package:flutter/material.dart';
import 'events-info.dart'; // Make sure this file exists with the EventInfoScreen class
// If you have a custom drawer, make sure 'navigation_menu.dart' exists with the PublicDrawer class.
// Otherwise, comment out or remove the line below.
import 'navigation_menu.dart';


// Define the Event class with all necessary information about an event.
class Event {
  final String title;
  final String date;
  final String time;
  final String description;

  Event(this.title, this.date, this.time, this.description);
}

// Define the EventsScreen as a StatefulWidget.
class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

// Define the corresponding State class for EventsScreen.
class _EventsScreenState extends State<EventsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Initialize the TabController.
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Dispose of the TabController when it's no longer needed.
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Build the UI for the EventsScreen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // If you don't have a custom drawer, comment out or remove the line below.
      drawer: const PublicDrawer(), // Replace with your drawer widget
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Events'),
            SizedBox(
              height: 55,
              width: 55,
              child: Image.asset('assets/images/logowhite.png'), // Replace with your logo asset
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
          _buildEventList([upcomingEvents[0]]),
        ],
      ),
    );
  }

  // Build a ListView of event cards.
  Widget _buildEventList(List<Event> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(events[index]);
      },
    );
  }

  // Build a single event card.
  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset('assets/images/logoSquare.png', width: 100), // Replace with your event image asset
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${event.date}  ${event.time}'),
            Text(event.description),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            // Navigate to the EventInfoScreen when the info button is pressed.
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


// Define a list of example events.
final List<Event> upcomingEvents = [
  Event('Music Concert', '25th Dec', '6:00 PM', 'An amazing music experience'),
  Event('Art Exhibition', '1st Jan', '12:00 PM', 'Explore the works of modern artists'),
  Event('Tech Conference', '15th Jan', '9:00 AM', 'Discover cutting-edge technology trends'),
];

