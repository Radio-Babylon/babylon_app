import 'package:flutter/material.dart';
import 'package:babylon_app/views/navigation_menu.dart';

// Define the Person class to hold necessary information about a person.
class Person {
  final String name;
  final String bio;
  final String interests;
  final String languages;

  Person(this.name, this.bio, this.interests, this.languages);
}

// Define ConnectionsScreen as a StatefulWidget to manage dynamic content.
class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

// Define the corresponding State class for ConnectionsScreen with a TabController for navigation.
class _ConnectionsScreenState extends State<ConnectionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController(); // For search functionality.
  List<Person> searchResults = []; // Holds the search results.

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

  // Placeholder for search logic, currently updates searchResults based on query.
  void _search(String query) {
    setState(() {
      // Future implementation of search logic.
      searchResults = [
        // Filtered list based on search query.
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
              child: Image.asset('assets/images/logowhite.png'), // Logo asset.
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
          _buildMyConnectionsTab(), // 'My Connections' tab with search and sections.
          _buildExploreWorldTab(),  // 'Explore The World' tab with search functionality.
        ],
      ),
    );
  }

  // Constructs 'My Connections' tab with a search bar and sections for connections.
  Widget _buildMyConnectionsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchBar(),
          _buildFriendRequestsWidget(), // Friend Requests section.
          _buildNewUsersWidget(),      // New Users section.
          _buildChatsWidget(),         // Chats section.
          _buildGroupChatsWidget(),    // Group Chats section.
        ],
      ),
    );
  }

  // Constructs the search bar widget.
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search Connections',
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: _search, // Invokes the search function with the current query.
      ),
    );
  }

  // Constructs the 'Friend Requests' widget with a horizontal list of profiles.
  Widget _buildFriendRequestsWidget() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Friend Requests', style: Theme.of(context).textTheme.headline6),
          ),
          Container(
            height: 200, // Fixed height for the horizontal list.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Five exemplary profiles.
              itemBuilder: (context, index) {
                // Each item is a profile card with image, name, and action buttons.
                return _buildProfileCard('assets/images/default_user_logo.png', 'Person $index', ['View Profile', 'Accept', 'Decline']);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Constructs the 'New Users' widget with a horizontal list of new user profiles.
  Widget _buildNewUsersWidget() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('New Users', style: Theme.of(context).textTheme.headline6),
          ),
          Container(
            height: 200, // Fixed height for the horizontal list.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Five exemplary profiles.
              itemBuilder: (context, index) {
                // Each item is a profile card with image, name, and action buttons.
                return _buildProfileCard('assets/images/default_user_logo.png', 'New User $index', ['View Profile', 'Chat']);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Constructs the 'Chats' widget with a horizontal list of ongoing chats.
  Widget _buildChatsWidget() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Chats', style: Theme.of(context).textTheme.headline6),
          ),
          Container(
            height: 200, // Fixed height for the horizontal list.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Five ongoing chats.
              itemBuilder: (context, index) {
                // Each item is a chat card with image, name, and action buttons.
                return _buildProfileCard('assets/images/default_user_logo.png', 'Chat $index', ['View Profile', 'Chat']);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Constructs the 'Group Chats' widget with a vertical list of group chats.
  Widget _buildGroupChatsWidget() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Group Chats', style: Theme.of(context).textTheme.headline6),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(), // Disables scrolling within ListView.
            shrinkWrap: true, // Allows ListView to occupy space only for its children.
            itemCount: 5, // Five group chats.
            itemBuilder: (context, index) {
              // Each item represents a group chat with title and member snapshot.
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logowhite.png'), // Placeholder for group snapshot.
                ),
                title: Text('Group Chat $index'),
                subtitle: Text('Members, Topics, etc.'),
                trailing: IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {
                    // Placeholder for opening group chat.
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Placeholder for creating new group chat.
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to construct a profile card with image, name, and action buttons.
  Widget _buildProfileCard(String imagePath, String name, List<String> buttonLabels) {
    return Card(
      child: Column(
        children: [
          Image.asset(imagePath, height: 100, width: 100), // User profile picture.
          Text(name), // User name.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttonLabels.map((label) => TextButton(onPressed: () {}, child: Text(label))).toList(),
          ),
        ],
      ),
    );
  }

  // Constructs 'Explore The World' tab with a search bar and search results.
  Widget _buildExploreWorldTab() {
    return Column(
      children: [
        _buildSearchBar(), // Reuses the same search bar builder.
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length, // Number of search results.
            itemBuilder: (context, index) {
              return _buildProfileCard('assets/images/logowhite.png', 'Result $index', ['View Profile', 'Chat']); // Replace with actual data.
            },
          ),
        ),
      ],
    );
  }

// Additional helper methods for building connection cards, handling accept/decline logic, etc., can be added here.
}
