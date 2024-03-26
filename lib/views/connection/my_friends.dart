// my_friends.dart
import "package:flutter/material.dart";

class MyFriends extends StatelessWidget {

  final List<Map<String, String>> joinRequests = List.generate(
    3,
        (final index) => {
      "name": "Request ${index + 1}",
      "profilePic": "assets/images/default_user_logo.png"
    },
  );

  final List<Map<String, String>> participants = List.generate(
    10,
        (final index) => {
      "name": "User ${index + 1}",
      "profilePic": "assets/images/default_user_logo.png"
    },
  );



  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Friends"),
        backgroundColor: Colors.green, // Updated color for a fresh look
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSectionTitle("Friend Requests"),
            _buildJoinRequestsList(),
            _buildSectionTitle("My Friends"),
            _buildParticipantsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(final String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900),
        ),
      ),
    );
  }

  Widget _buildJoinRequestsList() {
    return Column(
      children: joinRequests
          .map((final request) => ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(request["profilePic"]!),
        ),
        title: Text(request["name"]!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: Colors.green),
              onPressed: () {
                // Accept join request action
              },
            ),
            IconButton(
              icon: Icon(Icons.cancel, color: Colors.red),
              onPressed: () {
                // Cancel join request action
              },
            ),
          ],
        ),
      ))
          .toList(),
    );
  }

  Widget _buildParticipantsList(final BuildContext context) {
    return Column(
      children: participants.asMap().entries.map((final entry) {
        final int idx = entry.key;
        final Map<String, String> participant = entry.value;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(participant["profilePic"]!),
          ),
          title: Text(participant["name"]!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (idx == 0) // Assuming the first user is the admin
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2)

                ),
              IconButton(
                icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                onPressed: () {
                  // Show confirmation dialog when removing a participant
                  _showRemoveParticipantDialog(context, participant["name"]!);
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showRemoveParticipantDialog(
      final BuildContext context, final String participantName) {
    showDialog(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: Text("Remove Friend"),
          content: Text(
              "Are you sure you want to remove $participantName from your friends?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
// Implement remove participant logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

