import 'package:babylon_app/events.dart';
import 'package:babylon_app/forum.dart';
import 'package:babylon_app/home.dart';
import 'package:babylon_app/news.dart';
import 'package:flutter/material.dart';

class PublicDrawer extends StatefulWidget {
  const PublicDrawer({super.key});

  @override
  State<PublicDrawer> createState() => _PublicDrawerState();
}

class _PublicDrawerState extends State<PublicDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Drawer for side navigation
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              "Drawer Header",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('News'),
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FutureBuilderNews()));
              }),
          ListTile(
              leading: const Icon(Icons.forum),
              title: const Text('Forum'),
              onTap: () {
                // Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForumScreen()));
              }),
          ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Events'),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EventsScreen()),
                );
              }),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chats'),
            //onTap: () => _selectTab(4),
          ),
          ListTile(
            leading: const Icon(Icons.connect_without_contact),
            title: const Text('Connections'),
            //onTap: () => _selectTab(5),
          ),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Partners'),
            //onTap: () => _selectTab(6),
          ),
          // Repeat ListTiles for other items...
        ],
      ),
    );
  }
}
