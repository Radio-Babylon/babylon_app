import 'package:babylon_app/events.dart';
import 'package:babylon_app/forum.dart';
import 'package:babylon_app/home.dart';
import 'package:babylon_app/myprofile.dart';
import 'package:babylon_app/news.dart';
import 'package:babylon_app/radio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          const DrawerHeaderWithUserInfo(),
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
              leading: const Icon(Icons.radio),
              title: const Text('Radio'),
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RadioScreen()));
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
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('My profile'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfile()),
              );
            },
          ),
          // Repeat ListTiles for other items...
        ],
      ),
    );
  }
}

class DrawerHeaderWithUserInfo extends StatefulWidget {
  const DrawerHeaderWithUserInfo({super.key});

  @override
  State<DrawerHeaderWithUserInfo> createState() =>
      _DrawerHeaderWithUserInfoState();
}

class _DrawerHeaderWithUserInfoState extends State<DrawerHeaderWithUserInfo> {
  late final User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    // Initialize TabController with the number of tabs
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fullName = currentUser?.displayName ?? 'Unknown user';
    String email = currentUser?.email ?? 'email';
    String? imgUrl = currentUser?.photoURL;
    final ImageProvider currentImg;

    if (imgUrl != null) {
      currentImg = NetworkImage(imgUrl);
    } else {
      currentImg = const AssetImage('assets/images/default_user_logo.png');
    }

    print(currentUser);
    // if (currentUser != null) {
    return SizedBox(
      height: 230,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        padding: const EdgeInsets.all(0),
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: CircleAvatar(
                  radius: 52,
                  backgroundImage: currentImg,
                  backgroundColor: Colors
                      .green, //AssetImage('${currentUser?.photoURL}') //currentUser?.photoURL
                ),
                // Wrap the profile section with GestureDetector
                onTap: () {
                  // Navigate to the MyProfile screen when the profile picture is tapped
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyProfile()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(fullName, style: const TextStyle(fontSize: 18)),
              const SizedBox(
                height: 5,
              ),
              Text(email, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}



/*      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        "Drawer Header",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ), */


      /*        CircleAvatar(
          radius: 52,
          backgroundImage: AssetImage('assets/images/logoSquare.png'),
        ) */




        /*else {
      return SizedBox(
        height: 220,
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(0),
          child: Container(
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage('assets/images/logoSquare.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('User name and surname', style: TextStyle(fontSize: 15)),
                SizedBox(
                  height: 5,
                ),
                Text('User email', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
      );
    } */