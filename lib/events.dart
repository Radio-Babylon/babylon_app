import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: EventsScreen()));

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

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
      appBar: AppBar(
        title: const Text('Events'),
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
          _buildEventList(upcomingEvents), // Upcoming events list
          _buildEventList([upcomingEvents[0]]), // My events list (only first event for example)
        ],
      ),
    );
  }

  Widget _buildEventList(List<Event> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(events[index]);
      },
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset('assets/images/logoSquare.png', width: 100), // Event image
            title: Text(event.title), // Event title
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${event.date}  ${event.time}'), // Event date and time
                Text(event.description), // Event description
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                // TODO: Implement event info navigation or functionality
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Event data structure
class Event {
  final String title;
  final String date;
  final String time;
  final String description;

  Event(this.title, this.date, this.time, this.description);
}

// Example events
final List<Event> upcomingEvents = [
  Event('Music Concert', '25th Dec', '6:00 PM', 'An amazing music experience'),
  Event('Art Exhibition', '1st Jan', '12:00 PM', 'Explore the works of modern artists'),
  Event('Tech Conference', '15th Jan', '9:00 AM', 'Discover cutting-edge technology trends'),
];
