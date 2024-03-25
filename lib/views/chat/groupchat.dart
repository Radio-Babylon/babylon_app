import "package:flutter/material.dart";
import "package:intl/intl.dart";

// Represents a user in the chat
class User {
  final String id;
  final String name;
  final String profilePic;

  User(this.id, this.name, this.profilePic);
}

// Represents a message in the group chat
class GroupMessage {
  final User user;
  final String text;
  final DateTime date;

  GroupMessage(this.user, this.text, this.date);
}

// Main widget for the group chat, enhanced for better UI and UX
class GroupChatView extends StatefulWidget {
  const GroupChatView({super.key});

  @override
  _GroupChatViewState createState() => _GroupChatViewState();
}

class _GroupChatViewState extends State<GroupChatView> {
  final List<GroupMessage> messages = [
    // Predefined example messages to simulate a chat
    GroupMessage(
      User("1", "Alice", "assets/images/profile1.jpg"),
      "Hi everyone, what's up?",
      DateTime.now().subtract(Duration(minutes: 15)),
    ),
    GroupMessage(
      User("2", "Bob", "assets/images/profile2.jpg"),
      "Just working on my Flutter project!",
      DateTime.now().subtract(Duration(minutes: 10)),
    ),
    GroupMessage(
      User("3", "Charlie", "assets/images/profile3.jpg"),
      "Thinking about the next vacation spot.",
      DateTime.now().subtract(Duration(minutes: 5)),
    ),
    GroupMessage(
      User("4", "Diana", "assets/images/profile4.jpg"),
      "That sounds exciting, Charlie!",
      DateTime.now().subtract(Duration(minutes: 1)),
    ),
  ];

  final TextEditingController _messageController = TextEditingController();

  // Handles sending a message
  void _sendMessage() {
    final User currentUser =
        User("5", "Me", "assets/images/default_user_logo.png");
    final String messageText = _messageController.text.trim();

    if (messageText.isNotEmpty) {
      setState(() {
        messages.add(GroupMessage(currentUser, messageText, DateTime.now()));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Chat NAME"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: messages.length,
              itemBuilder: (final context, final index) {
                return _buildMessageTile(messages[index]);
              },
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  // Builds a single message tile with enhanced UI
  Widget _buildMessageTile(final GroupMessage message) {
    final bool isCurrentUser =
        message.user.id == "5"; // Check if the message is from the current user
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) // Only show profile picture for other users
            CircleAvatar(
              backgroundImage: AssetImage(message.user.profilePic),
            ),
          if (!isCurrentUser) // Add spacing only if the profile picture is displayed
            SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser) // Only show the user's name for other users
                  Text(
                    message.user.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isCurrentUser ? Colors.green[50] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.text,
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          DateFormat("hh:mm aaa").format(message.date),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Builds the message input field with enhanced UX
  Widget _buildMessageInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
