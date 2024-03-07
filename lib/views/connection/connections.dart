import 'package:flutter/material.dart';
import 'package:babylon_app/views/navigation_menu.dart';

// Define the Person class with all necessary information about a person.
class Person {
  final String name;
  final String bio;
  final String interests;
  final String languages;

  Person(this.name, this.bio, this.interests, this.languages);
}

// Define the ConnectionsScreen as a StatefulWidget to handle dynamic content like user connections.
class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

// Define the corresponding State class for ConnectionsScreen with TabController for tab navigation.
class _ConnectionsScreenState extends State<ConnectionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // Initialize the TextEditingController for the search functionality.
  TextEditingController searchController = TextEditingController();
  List<Person> searchResults = []; // This will hold the search results.

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // Implement the search logic here.
  // For now, it's just a placeholder that sets the searchResults list based on the search query.
  void _search(String query) {
    // Implement your search logic and set the state to display the results.
    setState(() {
      searchResults = [
        // This should be a filtered list based on the search query.
      ];
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('Connections'),
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
            Tab(text: 'MY CONNECTIONS'),
            Tab(text: 'EXPLORE THE WORLD'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyConnectionsTab(), // Build 'My Connections' tab with search and sections.
          _buildExploreWorldTab(),  // Build 'Explore The World' tab with search.
        ],
      ),
    );
  }

  // Build 'My Connections' tab which includes a search bar, 'New Connections', and 'My Connections' sections.
  Widget _buildMyConnectionsTab() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: ListView(
            children: [
              _buildNewConnectionsSection(),
              _buildMyConnectionsSection(),
            ],
          ),
        ),
      ],
    );
  }

  // Build the search bar widget.
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search Connections',
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: _search, // Call the search function with the current query.
      ),
    );
  }

  // Build the 'New Connections' section with title and placeholder for connection requests.
  Widget _buildNewConnectionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('New Connections', style: Theme.of(context).textTheme.headline6),
        ),
        // Here you would build a list of connection request cards.
        // Placeholder for one connection request.
        _buildConnectionRequestCard(),
        // Add more cards...
      ],
    );
  }

  // Build a placeholder for a connection request card.
  Widget _buildConnectionRequestCard() {
    // This should be a list of connection requests.
    return ListTile(
      leading: CircleAvatar(), // Placeholder for profile picture.
      title: Text('Person\'s Name'),
      subtitle: Text('Person\'s Bio'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text('Profile'),
            onPressed: () {
              // Implement profile viewing logic.
            },
          ),
          TextButton(
            child: Text('Accept'),
            onPressed: () {
              // Implement accept connection logic.
            },
          ),
          TextButton(
            child: Text('Decline'),
            onPressed: () {
              // Implement decline connection logic.
            },
          ),
        ],
      ),
    );
  }

  // Build the 'My Connections' section with title and placeholder for existing connections.
  Widget _buildMyConnectionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('My Connections', style: Theme.of(context).textTheme.headline6),
        ),
        // Here you would build a list of existing connection cards.
        // Placeholder for one existing connection.
        _buildConnectionCard(),
        // Add more cards...
      ],
    );
  }

  // Build a placeholder for an existing connection card.
  Widget _buildConnectionCard() {
    // This should be a list of existing connections.
    return ListTile(
      leading: CircleAvatar(), // Placeholder for profile picture.
      title: Text('Person\'s Name'),
      subtitle: Text('Person\'s Bio'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text('Profile'),
            onPressed: () {
              // Implement profile viewing logic.
            },
          ),
          TextButton(
            child: Text('Chat'),
            onPressed: () {
              // Implement chat logic.
            },
          ),
        ],
      ),
    );
  }

  // Build 'Explore The World' tab which includes a search bar and placeholder content.
  Widget _buildExploreWorldTab() {
    return Column(
      children: [
        _buildSearchBar(), // Re-use the same search bar builder.
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length, // Number of search results.
            itemBuilder: (context, index) {
              // Build a card for each search result.
              return _buildConnectionCard(); // Replace with actual data.
            },
          ),
        ),
      ],
    );
  }

// Add other helper methods for building connection cards, handling accept/decline logic, etc., here.
}
