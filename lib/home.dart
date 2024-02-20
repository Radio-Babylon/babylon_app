import 'package:flutter/material.dart';
import 'partners.dart';
import 'chats.dart';
import 'news.dart';
import 'forum.dart';
import 'events.dart';
import 'connections.dart';

// HomePage with a custom AppBar and bottom navigation
class homePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<homePage> {
  // Stateful data like currentIndex can be used for bottom navigation or other state management
  int _currentIndex = 0;

  // List of widgets for each tab content
  final List<Widget> _tabs = [
    HomeScreen(),
    NewsScreen(),
    ForumScreen(),
    EventsScreen(),
    ChatsScreen(),
    ConnectionsScreen(),
    PartnersScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,  // Number of tabs
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200.0),  // Custom height for the AppBar
          child: Column(
            children: [
              // Custom user profile section
              Container(
                color: Colors.grey.shade200,  // Background color for the profile section
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,  // Size of the profile picture
                      backgroundColor: Colors.grey.shade300,
                      // Placeholder for the profile picture
                      child: Text('PP', style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                    SizedBox(width: 20),  // Space between the avatar and the text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome,', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          Text("Person's Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    // Menu icon or button if needed
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        // Action for menu icon
                      },
                    ),
                  ],
                ),
              ),
              // AppBar with tabs below the profile section
              Material(
                color: Colors.white,  // Background color for the TabBar
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.green,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: 'Home'),
                    Tab(icon: Icon(Icons.newspaper), text: 'News'),
                    Tab(icon: Icon(Icons.forum), text: 'Forum'),
                    Tab(icon: Icon(Icons.event), text: 'Events'),
                    Tab(icon: Icon(Icons.chat), text: 'Chats'),
                    Tab(icon: Icon(Icons.connect_without_contact), text: 'Connections'),
                    Tab(icon: Icon(Icons.business), text: 'Partners'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,  // Displaying content for the selected tab
        ),
      ),
    );
  }
}

// Define other screens like HomeScreen, NewsScreen, etc., similar to the HomeScreen class
// Each screen will have its own layout and widgets

// Example HomeScreen class
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Using a ListView for scrollable content
      children: <Widget>[
        _buildUpcomingEventsSection(context),
        _buildForumsParticipationSection(context),
        _buildChatsSection(context),
        // Add more sections or widgets here if needed
      ],
    );
  }

  Widget _buildUpcomingEventsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'UPCOMING EVENTS',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                ),
                child: Icon(Icons.image, color: Colors.white), // Placeholder icon
              ),
              title: Text('EVENT NAME'),
              subtitle: Text('DATE\nTIME\nDescription...'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Info button action
                },
                child: Text('+ info'),
              ),
            ),
          ),
          // You can repeat the Card for more events or create a method to generate them based on data
        ],
      ),
    );
  }

  Widget _buildForumsParticipationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'FORUMS PARTICIPATION',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildForumCard('FORUM TOPIC 1', '0 Replies', true),
              _buildForumCard('FORUM TOPIC 3', '1 Reply', true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildForumCard('FORUM TOPIC 2', '3 Replies', true),
              _buildForumCard('FORUM TOPIC 4', '10 Replies', true),
            ],
          ),
          TextButton(
            onPressed: () {
              // Browse on forum action
            },
            child: Text('Browse on forum'),
          ),
        ],
      ),
    );
  }

  Widget _buildForumCard(String title, String subtitle, bool isOpen) {
    return Expanded( // Using Expanded to fill the available space in the Row
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card wrap its content
            children: <Widget>[
              Text(title),
              SizedBox(height: 4), // Add a small space between the text widgets
              Text(subtitle),
              SizedBox(height: 8), // Add some space before the button
              if (isOpen) // Only show the button if the forum is 'Open'
                ElevatedButton(
                  onPressed: () {
                    // Your button tap action here
                  },
                  child: Text('Open'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Text Color
                    backgroundColor: Colors.blue,  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'CHATS',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('PERSON\'S NAME'),
            subtitle: Text('last message sent...'),
            trailing: TextButton(
              onPressed: () {
                // Open chat action
              },
              child: Text('Open'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text Color
                backgroundColor: Colors.blue, // Button Background Color
              ),
            ),
          ),
          // You can repeat the ListTile for more chats or create a method to generate them based on data
        ],
      ),
    );
  }
}
