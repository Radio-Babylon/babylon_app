import 'dart:io';

import 'package:babylon_app/models/babylonUser.dart';
import 'package:babylon_app/services/user/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../home.dart'; // Make sure this import is correct for your HomeScreen widget

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool firstToggle = false;
  BabylonUser user = BabylonUser.currentBabylonUser;
  
  bool _isSaving = false;
  late final TextEditingController _fullname;
  late final TextEditingController _dateOfBirth;
  late final TextEditingController _country;
  late final TextEditingController _about;
  File? _fileImage;

  String? _error;

  final Map<String, bool> toggles = {
    'Name': false,
    'Email': false,
    'Save': false,
  };

  @override
  void initState() {
    _fullname =
        TextEditingController(text: BabylonUser.currentBabylonUser.fullName);
    _dateOfBirth = TextEditingController(text: BabylonUser.currentBabylonUser.dataOfBirth);
    _country = TextEditingController(text: BabylonUser.currentBabylonUser.originCountry);
    _about = TextEditingController(text: BabylonUser.currentBabylonUser.about);
    _error = "";
    super.initState();
  }

  @override
  void dispose() {
    _fullname.dispose();
    _dateOfBirth.dispose();
    _country.dispose();
    _about.dispose();
    _error = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget saveButton() => ButtonWidget(
      text: 'Save changes',
      onClicked: () async {
        setState(() {
          _isSaving = true;
        });
        await UserService.updateUserInfo(uuid: user.UserUID, newData: {
          "name": _fullname.text,
          "originCountry": _country.text,
          "birthDate": _dateOfBirth.text,
          "about": _about.text 
        });
        await BabylonUser.updateCurrentBabylonUserData(currentUserUID: user.UserUID);
        if (_fileImage != null) UserService.addPhoto(user: FirebaseAuth.instance.currentUser!, file: _fileImage!);
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          _isSaving = false;
          user = BabylonUser.currentBabylonUser;
        });
      },
      toSave: toggles['Save'] ?? true,
    );

    return Scaffold(
      appBar: AppBar(
        // Replaced the menu icon with an arrow back icon
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to HomeScreen when the arrow is pressed
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          buildProfile(context),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(
            child: buildUpgradeButton(),
          ),
          //const SizedBox(height: 24),
          /*Center(
              child: const Text(
            'Infromation about events',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 10),*/
          //NumbersWidget(),
          const SizedBox(height: 30),
          //infoField(),_
          infoField(
              icon: Icons.person,
              hintText: 'example name',
              labelText: 'Full name',
              controller: _fullname,
              onClicked: () {}),
          infoField(
              icon: Icons.cake,
              hintText: 'Birth Date',
              labelText: 'Birth Date',
              controller: _dateOfBirth,
              onClicked: () {},
              hasDatePicker: true),
          //const SizedBox(height: 30),
          infoField(
              icon: Icons.public,
              hintText: 'Origin country',
              labelText: 'Origin country',
              controller: _country,
              onClicked: () {}),
          infoField(
              icon: Icons.chat,
              hintText: 'About',
              labelText: 'About',
              controller: _about,
              onClicked: () {}),
          Center(
            child: saveButton(),
          ),
           if(_isSaving)
            Container(
              margin: EdgeInsets.all(16),
              child: Center(
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                      color: Color(0xFF006400)),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 4, child: buildEditIcon(color, onClicked: getImage)),
        ],
      )
    );
  }

  Future getImage() async {
    activateButton();
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 70);

    if (image != null) {
      setState(() {
        _fileImage = File(image.path);
      });
    }
  }

  Widget buildImage() {
    ImageProvider image;
    if (_fileImage != null ){
      image = FileImage(_fileImage!);
    }
    else if (user.imagePath == '') {
      image = const AssetImage('assets/images/default_user_logo.png');
    } else {
      image = NetworkImage(user.imagePath);
    }
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: getImage),
        ),
      ),
    );
  }

  Widget buildName(BabylonUser user) => Column(
        children: [
          Text(
            user.fullName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  void activateButton() {
    setState(() {
      toggles['Save'] = true;
    });
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
        toSave: true,
      );

  Widget buildAbout(BabylonUser user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about!,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget infoField(
      {required IconData icon,
      required String hintText,
      required String labelText,
      required TextEditingController controller,
      required Function onClicked,
      bool hasDatePicker = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Center(
        child: Stack(children: [
          //Positioned(top: -5, right: 50, child: buildEditIcon(Colors.black)),
          Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 15),
                  Expanded( 
                    child: TextField(
                      enabled: toggles[labelText],
                      controller: controller,
                      readOnly: hasDatePicker,
                      onTap: () async {
                        activateButton();
                        if(hasDatePicker){
                          DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1901),
                            lastDate: DateTime(2101)
                          );
                                
                          if(pickedDate != null ){
                            setState(() {
                                _dateOfBirth.text = "${pickedDate.year}-${pickedDate.month < 10 ? "0${pickedDate.month}" : pickedDate.month}-${pickedDate.day}";
                            });
                          }
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(239, 237, 237, 0.5),
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(10.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1.0),
                        ),
                        //label: Icon(Icons.settings),
                        hintText: hintText,
                        labelText: labelText,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          // Positioned(
          //     top: 0,
          //     right: 5,
          //     child: buildEditIcon(Theme.of(context).colorScheme.primary,
          //         onClicked: () {
          //       toggles[labelText] = true;
          //       toggles['Save'] = true;
          //       setState(() {
          //         this.toggles[labelText] = toggles[labelText]!;
          //         for (MapEntry<String, bool> toggle in toggles.entries) {
          //           if (toggle.key != labelText) {
          //             if (toggle.value) {
          //               if (toggle.key == 'Name') {
          //                 if (_fullname.text ==
          //                     BabylonUser.currentBabylonUser.fullName) {
          //                   toggles[toggle.key] = false;
          //                 }
          //               }
          //             }
          //           }
          //         }
          //         //activateButton();
          //       });
          //     })),
        ]),
      ),
    );
  }

  Widget buildEditIcon1(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(Icons.edit, color: Colors.white, size: 12),
        ),
      );
  Widget buildEditIcon(Color color, {required onClicked}) => ClipOval(
        child: Material(
          color: Colors.white,
          child: Ink.image(
            image: AssetImage('assets/images/iconEdit.png'),
            fit: BoxFit.cover,
            width: 30,
            height: 30,
            child: InkWell(onTap: onClicked),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
  // Refactored profile section into a method for better readability

  // Method to build interests chips

  // Method to build languages chips
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onClicked;
  final bool toSave;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.toSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: toSave ? onClicked : null,
      );
}

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, 'admin'),
          buildDivider(),
          buildButton(context, 'member'),
          //buildDivider(),
          //buildButton(context, '50', 'Followers'),
        ],
      );

  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(
            //color: Colors.black,
            ),
      );

  Widget buildButton(BuildContext context, String text) => SizedBox(
        width: 120,
        child: MaterialButton(
          shape: StadiumBorder(),
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.symmetric(vertical: 4),
          onPressed: () {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      );
}

/*
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade300,
              child: Text('profile picture',
                  style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                // Handle edit profile picture
              },
              child: Text('edit'),
            ),
            // Profile information and interests
            _buildProfileSection(context),
            // Adding the Logout button at the bottom of the page
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout logic
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color
                ),
              ),
            ),
          ],
        ),
      ),


  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name',
                        style: Theme.of(context).textTheme.headline6),
                    Text(
                      'short bio short bio short bio short bio short bio short bio',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text('Age', style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interests', style: Theme.of(context).textTheme.subtitle1),
              _buildInterests(),
              SizedBox(height: 20),
              Text('Languages', style: Theme.of(context).textTheme.subtitle1),
              _buildLanguages(),
            ],
          ),
        ),
        ListTile(
          title: Text('My Plan'),
          subtitle: Text('Monthly subscription'),
          trailing: Wrap(
            spacing: 12,
            children: [
              TextButton(
                onPressed: () {
                  // Handle change plan
                },
                child: Text('change'),
              ),
              TextButton(
                onPressed: () {
                  // Handle cancel plan
                },
                child: Text('cancel'),
              ),
            ],
          ),
        ),
      ],
    );
  }






  Widget _buildInterests() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        6,
        (index) => Chip(
          label: Text('interest ${index + 1}'),
        ),
      ),
    );
  }



  Widget _buildLanguages() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: ['language 1', 'language 2', 'language 3']
          .map((lang) => Chip(label: Text(lang)))
          .toList(),
    );
  }*/
