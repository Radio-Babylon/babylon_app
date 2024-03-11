import 'package:babylon_app/services/user/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BabylonUser {
  String imagePath = '';
  String fullName = '';
  String email = '';
  String? dataOfBirth = '';
  String? originCountry = '';
  String? about = '';
  List<String> listedEvents = [];
  String UserUID = '';

  BabylonUser();
  BabylonUser.withData(this.fullName,this.email,this.imagePath,this.listedEvents,this.UserUID,this.about,this.originCountry,this.dataOfBirth);
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

  static void updateCurrentBabylonUserData({required User? currentUser}) async {
    BabylonUser? currentUserDBData = await UserService.getBabylonUser(currentUser!.uid);
    currentBabylonUser.imagePath = currentUserDBData!.imagePath;
    currentBabylonUser.email = currentUserDBData.email;
    currentBabylonUser.fullName = currentUserDBData.fullName;
    currentBabylonUser.dataOfBirth = currentUserDBData.dataOfBirth;
    currentBabylonUser.originCountry = currentUserDBData.originCountry;
    currentBabylonUser.about = currentUserDBData.about;
    currentBabylonUser.listedEvents = currentUserDBData.listedEvents;
    currentBabylonUser.UserUID = currentUserDBData.UserUID;
  }
}
