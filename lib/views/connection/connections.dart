import "package:flutter/material.dart";
import "package:babylon_app/views/navigation_menu.dart";
import "package:babylon_app/views/profile/other_profile.dart";
import 'package:babylon_app/views/chat/chat.dart';
import 'package:babylon_app/views/chat/groupchat.dart';

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
      searchResults = List.generate(15, (index) => Person("User $index", "Bio $index", "Interests $index", "Languages $index"))
          .where((person) => person.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text("Connections"),
            SizedBox(
              height: 55,
              width: 55,
              child: Image.asset("assets/images/logowhite.png"), // Logo asset.
            ),
          ],
        ),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "MY CONNECTIONS"),
            Tab(text: "EXPLORE THE WORLD"),
          ],        
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyConnectionsTab(), // "My Connections" tab with search and sections.
          _buildExploreWorldTab(),  // "Explore The World" tab with search functionality.
        ],
      ),
    );
  }

  // Constructs "My Connections" tab with a search bar and sections for connections.
  Widget _buildMyConnectionsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          labelText: "Search Connections",
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: _search, // Invokes the search function with the current query.
      ),
    );
  }

  // Constructs the "Friend Requests" widget with a horizontal list of profiles.
  Widget _buildFriendRequestsWidget() {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Friend Requests", style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold) ),
          ),
          Container(
            height: 200, // Fixed height for the horizontal list of friend request cards.
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Example: Five friend requests.
              itemBuilder: (context, index) {
                // Each item is a profile card with image, name, and action buttons for friend requests.
                return Container(
                  width: 240, // Adjusted width for each friend request card to accommodate horizontal buttons.
                  margin: EdgeInsets.only(left: 16.0, right: index == 4 ? 16.0 : 0), // Add right margin to the last card.
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround, // Space elements evenly within the card.
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage("assets/images/default_user_logo.png"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("Person $index", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                        // Horizontal buttons for "View Profile", "Accept", and "Decline" actions.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space buttons evenly.
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_red_eye_outlined, color: Colors.blue),
                              onPressed: () {   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OtherProfile()),
                              );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () {
                                // Placeholder for "Accept" action.
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                // Placeholder for "Decline" action.
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],

    );
  }



  // Constructs the "New Users" widget with a horizontal list of new user profiles.
  Widget _buildNewUsersWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("New Users!", style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
          ),
          Container(
            height: 200, // Fixed height for the horizontal list of profile cards.
            child: ListView.builder(

              scrollDirection: Axis.horizontal,
              itemCount: 5, // Example: Five new user profiles.
              itemBuilder: (context, index) {
                // Each item is a profile card with image, name, and action buttons for new users.
                return Container(
                  width: 160, // Fixed width for each profile card.
                  margin: EdgeInsets.only(left: 16.0, right: index == 4 ? 16.0 : 0), // Add right margin to the last card.
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage("assets/images/default_user_logo.png"),
                              ),
                              SizedBox(height: 10),
                              Text("New User $index", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_red_eye_outlined, color: Colors.blue),
                                    onPressed: () {   Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => OtherProfile()),
                                    );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.chat_bubble_outline, color: Colors.blue),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ChatView()),
                                      );
                                      // Placeholder for "Chat" action.
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],

    );
  }


  // Constructs the "Chats" widget with a horizontal list of ongoing chats.
  Widget _buildChatsWidget() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Chats", style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(), // Disables scrolling within ListView.
            shrinkWrap: true, // Allows ListView to occupy space only for its children.
            itemCount: 5, // Example: Five group chats.
            itemBuilder: (context, index) {
              // Each item represents a group chat with title, the last message preview, and a button to open the chat.
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/default_user_logo.png"), // Placeholder for group snapshot.
                  radius: 25, // Adjust the size of the CircleAvatar here.
                ),
                title: Text("User $index", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("The last message in the conversation.."),
                trailing: IconButton(
                  icon: Icon(Icons.chat_bubble_outline, color: Colors.blue),
                  onPressed: () {
                    // Placeholder function for opening the group chat.
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  // Constructs the "Group Chats" widget with a vertical list of group chats.
  Widget _buildGroupChatsWidget() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Group Chats", style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(), // Disables scrolling within ListView.
            shrinkWrap: true, // Allows ListView to occupy space only for its children.
            itemCount: 5, // Example: Five group chats.
            itemBuilder: (context, index) {
              // Each item represents a group chat with title, member details, and a button to open the chat.
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logowhite.png"), // Placeholder for group snapshot.
                  radius: 25, // Adjust the size of the CircleAvatar here.
                ),
                title: Text("Group Chat $index", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Members, Topics, etc."),
                trailing: IconButton(
                  icon: Icon(Icons.chat_bubble_outline, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (final context) => GroupChatView()),
                      // Placeholder for 'Chat' action.
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0, bottom: 16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              // Floating action button for creating a new group chat, placed at the bottom right.
              child: FloatingActionButton(
                onPressed: () {
                  // Placeholder for creating new group chat.
                },
                backgroundColor: Colors.blue, // Customize the button color to fit your app theme.
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
            children: buttonLabels.map((label) {
              // Check if the label is "View Profile" to add navigation functionality.
              if (label == "View Profile") {
                return TextButton(
                  onPressed: () {
                    // Navigating to OtherProfile when "View Profile" is tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtherProfile()),
                    );
                  },
                  child: Text(label),
                );
              } else {
                // For other buttons, just return a placeholder onPressed functionality.
                return TextButton(
                  onPressed: () {
                    // Placeholder for other buttons.
                  },
                  child: Text(label),
                );
              }
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Constructs "Explore The World" tab with a search bar and search results.
  Widget _buildExploreWorldTab() {
    // Main column for the Explore World tab, containing the search bar and the list view of profiles.
    return Column(
      children: [
        _buildSearchBar(), // Assuming this function builds the search bar widget.
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.isEmpty ? 15 : searchResults.length,
            itemBuilder: (context, index) {
              // Use "searchResults" if not empty; otherwise, generate default list items.
              final person = searchResults.isEmpty
                  ? Person("User $index", "Bio $index", "Interests $index", "Languages $index")
                  : searchResults[index];

              // Card widget for each profile with a photo, name, bio, and action buttons.
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                elevation: 3.0,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile picture on the left side of the card.
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30.0, // Adjust the size of the profile picture here.
                          backgroundImage: AssetImage("assets/images/default_user_logo.png"),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(person.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                              SizedBox(height: 5),
                              Text(person.bio, style: TextStyle(fontSize: 14.0)),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(),
                      // Buttons are stacked vertically on the right side.
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buttonOption("View Profile", Icons.visibility, context, person),
                            _buttonOption("Send Request", Icons.person_add, context, person),
                            _buttonOption("Chat", Icons.chat, context, person),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buttonOption(String title, IconData icon, BuildContext context, Person person) {
    // Function to create a small, styled button for each action.
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // Button functionality goes here, e.g., navigating to a profile page.
        },
        icon: Icon(icon, size: 18.0),
        label: Text(title, style: TextStyle(fontSize: 12.0)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue.shade200, // Text color
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners for a modern look
          ),
          textStyle: TextStyle(
            fontWeight: FontWeight.bold, // Bold text for clarity
          ),
        ),
      ),
    );
  }


// Additional helper methods for building connection cards, handling accept/decline logic, etc., can be added here.
}
