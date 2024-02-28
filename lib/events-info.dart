import 'package:flutter/material.dart';
import 'events.dart'; // Import the Event class from the events.dart file.

// EventInfoScreen displays detailed information about an event.
class EventInfoScreen extends StatelessWidget {
  // Event to display is passed through the constructor.
  final Event event;

  // Constructor requires an Event object when creating the widget.
  const EventInfoScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get device width for responsive design.
    double screenWidth = MediaQuery.of(context).size.width;

    // Scaffold provides the AppBar at the top and a Body for content.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.title,
          style: TextStyle(fontSize: 24), // Larger AppBar title
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Centered container for the event image with increased size.
            Container(
              width: screenWidth,
              // Make the image take the full width of the screen.
              child: Image.asset(
                'assets/images/eventexample.jpg',
                height: 200,
                // Increased height from 80 to 200 for a larger image.
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    // Increased padding for more space.
                    child: Column(
                      children: <Widget>[
                        Text(
                          event.title,
                          style: TextStyle(fontSize: 34),
                          // Larger title text
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.left,
                          event.description,
                          style: TextStyle(fontSize: 18), // Larger description text for readability.
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 30), // Calendar icon.
                      SizedBox(width: 8), // Space between icon and text.
                      Text(
                        '${event.date} at ${event.time}',
                        style: TextStyle(
                            fontSize:
                                18), // Slightly larger date and time text for readability.
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text('ATTEND', style: TextStyle(fontSize: 18)),
                    // Larger button text.
                    onPressed: () {
                      // Event attendance functionality to be implemented here.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15), // Larger button padding.
                    ),
                  ),
                  // Section showing people attending the event inside a styled container.
                  _buildPeopleAttendingSection(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Builds the 'People Attending' section with a more attractive design.
  Widget _buildPeopleAttendingSection(BuildContext context) {
    // Replace with actual data in a real app.
    List<String> attendingUsers = List.generate(
        15, (index) => 'Person ${index + 1}'); // Example list of 15 people.

    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'People Attending',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 18), // Larger text for the section title.
            ),
          ),
          // Horizontally scrollable list of avatars.
          Container(
            height: 49,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              // Show 4 for the preview
              separatorBuilder: (_, index) => SizedBox(width: 10),
              // Increased separation for the avatars.
              itemBuilder: (context, index) {
                return CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/default_user_logo.png'),
                  radius: 30, // Larger avatars for better visibility.
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: OutlinedButton.icon(
              onPressed: () {
                // Opens a dialog showing all attendees.
                _showAllAttendeesPopup(context, attendingUsers);
              },
              icon: Icon(Icons.person, size: 24), // Larger icon size.
              label: Text(
                'See all (${attendingUsers.length})',
                style: TextStyle(
                    fontSize: 16), // Larger text for 'See all' button.
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: Colors.green), // Border color to match the theme.
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show a dialog with all attending users.
  void _showAllAttendeesPopup(
      BuildContext context, List<String> attendingUsers) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('All Attendees', style: TextStyle(fontSize: 20)),
          // Larger dialog title.
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: attendingUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/default_user_logo.png'),
                    radius: 20, // Larger avatar in dialog.
                  ),
                  title: Text(attendingUsers[index],
                      style: TextStyle(
                          fontSize: 16)), // Larger text in dialog list.
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(fontSize: 16)),
              // Larger 'Close' button text.
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
