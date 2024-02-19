import 'package:flutter/material.dart';
import 'partners.dart';
import 'chats.dart';
import 'news.dart';
import 'forum.dart';
import 'events.dart';
import 'connections.dart';
import 'radio.dart';

class homePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//==============================================
//==============MENU ON TOP=====================
//==============================================

class _MyHomePageState extends State<homePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    RadioScreen(),
    NewsScreen(),
    ForumScreen(),
    EventsSceen(),
    ChatsScreen(),
    ConnectionsScreen(),
    PartnersScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.green,
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.radio), text: 'Radio'),
              Tab(icon: Icon(Icons.newspaper), text: 'News'),
              Tab(icon: Icon(Icons.forum), text: 'Forum'),
              Tab(icon: Icon(Icons.event), text: 'Events'),
              Tab(icon: Icon(Icons.chat), text: 'Chats'),
              Tab(icon: Icon(Icons.connect_without_contact), text: 'Connections'),
              Tab(icon: Icon(Icons.business), text: 'Partners'),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}

//==============================================
//==============END OF MENU=====================
//==============================================

// ===========================================
//==============HOME SCREEN===================
//============================================
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

