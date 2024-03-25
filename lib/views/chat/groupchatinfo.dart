import 'package:flutter/material.dart';

class GroupChatInfo extends StatelessWidget {
  final List<Map<String, String>> joinRequests = List.generate(
    3,
        (index) => {'name': 'Request ${index + 1}', 'profilePic': 'assets/images/default_user_logo.png'},
  );

  final List<Map<String, String>> participants = List.generate(
    10,
        (index) => {'name': 'User ${index + 1}', 'profilePic': 'assets/images/default_user_logo.png'},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat Info'),
        backgroundColor: Colors.green, // Updated color for a fresh look
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  Text(
                    'Group Info',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade900),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "This group is for testing the group chat!",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Add participant action
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Add Participant', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            _buildSectionTitle('Join Requests'),
            _buildJoinRequestsList(),
            _buildSectionTitle('Participants'),
            _buildParticipantsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade900),
        ),
      ),
    );
  }

  Widget _buildJoinRequestsList() {
    return Column(
      children: joinRequests.map((request) => ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(request['profilePic']!),
        ),
        title: Text(request['name']!),
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
      )).toList(),
    );
  }

  Widget _buildParticipantsList(BuildContext context) {
    return Column(
      children: participants.asMap().entries.map((entry) {
        int idx = entry.key;
        Map<String, String> participant = entry.value;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(participant['profilePic']!),
          ),
          title: Text(participant['name']!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (idx == 0) // Assuming the first user is the admin
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Admin',
                    style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold),
                  ),
                ),
              IconButton(
                icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                onPressed: () {
                  // Show confirmation dialog when removing a participant
                  _showRemoveParticipantDialog(context, participant['name']!);
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showRemoveParticipantDialog(BuildContext context, String participantName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Remove Participant'),
    content:
    Text('Are you sure you want to remove $participantName from the group?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Yes'),
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
