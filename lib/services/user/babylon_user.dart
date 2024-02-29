import 'package:firebase_auth/firebase_auth.dart';

class BabylonUser {
  String imagePath = '';
  String fullName = '';
  String email = '';
  //final String dataOfBirth;
  //final String originCountry
  String about = '';

  BabylonUser();
  BabylonUser.fromUser({required User? currentUser}) {
    imagePath = currentUser?.photoURL ?? '';
    email = currentUser?.email ?? '';
    fullName = currentUser?.displayName ?? '';
    /*
    String? photoURL = currentUser.photoURL;
    if (photoURL != null) {
      imagePath = photoURL;
    }
    String? currentUSerFullName = currentUser.displayName;
    if (currentUSerFullName != null) {
      fullName = currentUSerFullName;
    }
  */
  }

  static BabylonUser currentBabylonUser = BabylonUser();

  static void changeBabylonUserData({required User? currentUser}) {
    currentBabylonUser.imagePath = currentUser?.photoURL ?? '';
    currentBabylonUser.email = currentUser?.email ?? '';
    currentBabylonUser.fullName = currentUser?.displayName ?? '';
    currentBabylonUser.about = 'foooo baaar baaaz';
  }
}
