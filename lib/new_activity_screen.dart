import 'package:babylon_app/main.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

var selectedIndex = 0;

class NewActivityScreen extends StatelessWidget {
  final int counterValue;

  NewActivityScreen({required this.counterValue});

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: true,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.newspaper),
                  label: Text('News'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.forum),
                  label: Text('Forum'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.event),
                  label: Text('Events'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.chat),
                  label: Text('Chats'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.connect_without_contact),
                  label: Text('Connections'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.business),
                  label: Text('Partners'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primaryContainer,

            ),
          ),
        ],
      ),
    );
  }
}
  void setState(Null Function() param0) {}
