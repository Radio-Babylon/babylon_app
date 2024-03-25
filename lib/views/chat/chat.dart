import "package:flutter/material.dart";
import "package:intl/intl.dart";

// Dummy user profile class for illustration purposes
class UserProfile {
  final String profilePic;
  final String name;

  UserProfile({required this.profilePic, required this.name});
}

// ChatView class for the chat screen implemented as a StatefulWidget to handle dynamic changes
class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  // Example user data
  final UserProfile user = UserProfile(
    profilePic:
        "assets/images/profilephoto2.jpg", // Placeholder for profile picture asset
    name: "Jane Doe", // Example name
  );

  // List to hold messages with a flag to check if the message was sent by the user
  List<Map<String, dynamic>> messages = [
    {
      "text": "Hi, how are you?",
      "isSentByMe": true,
      "date": DateTime.now().subtract(Duration(minutes: 1))
    },
    {
      "text": "Good, thanks. And you?",
      "isSentByMe": false,
      "date": DateTime.now()
    },
    // Add more example messages here...
  ];

  // Controller to clear the message input field after sending a message
  final TextEditingController _messageController = TextEditingController();

  // Method to send a message and update the messages list
  void _sendMessage() {
    final String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add(
            {"text": messageText, "isSentByMe": true, "date": DateTime.now()});
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  user.profilePic), // Display the user's profile picture
            ),
            SizedBox(width: 10),
            Text(user.name), // Display the user's name
          ],
        ),
        backgroundColor: Colors.green,
        actions: [
          // Menu for additional actions
          PopupMenuButton<String>(
            onSelected: (final value) {
              // Handle action on selection
              print(value); // Replace this with actual functionality
            },
            itemBuilder: (final BuildContext context) {
              // Define menu items
              return {"Report User", "Block User"}.map((final String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Expanded widget to hold the conversation list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: messages.length,
              itemBuilder: (final context, final index) {
                final message = messages[index];
                return _buildMessage(
                    message["text"], message["isSentByMe"], message["date"]);
              },
            ),
          ),
          // Input field for typing messages
          _buildMessageInputField(),
        ],
      ),
    );
  }

  // Widget to build each individual message bubble
  Widget _buildMessage(
      final String message, final bool isSentByMe, final DateTime date) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.green.shade50 : Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment:
              isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              DateFormat("hh:mm aaa")
                  .format(date), // Formatting date to show the message time
              style: TextStyle(color: Colors.grey[600], fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the message input field
  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          // Button to send the message
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

// class chatting extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Chatting with..."),
//       ),
//       body: Center(
//         child: Text("PLACEHOLDER FOT THE PAGE"),
//       ),
//     );
//   }
// }
