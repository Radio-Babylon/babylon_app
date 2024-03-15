import "package:babylon_app/services/user/userService.dart";
import "package:firebase_auth/firebase_auth.dart";

class BabylonUser {
  // Attributes

  String userUID = "";
  String fullName = "";
  String email = "";
  String? dateOfBirth;
  String? originCountry;
  String? about;
  String imagePath = "";
  List<String> listedEvents = [];

  // Constructors

  BabylonUser();
  BabylonUser.withData(
      final String userUID,
      final String fullName,
      final String email,
      final String about,
      final String? originCountry,
      final String? dataOfBirth,
      final String imagePath,
      final List<String> listedEvents);
  BabylonUser.fromUser({required final User? currentUser}) {
    imagePath = currentUser?.photoURL ?? "";
    email = currentUser?.email ?? "";
    fullName = currentUser?.displayName ?? "";
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

  // Static methods

  static BabylonUser currentBabylonUser = BabylonUser();

  static Future<void> updateCurrentBabylonUserData(
      {required final String currentUserUID}) async {
    final BabylonUser? currentUserDBData =
        await UserService.getBabylonUser(currentUserUID);
    currentBabylonUser.imagePath = currentUserDBData!.imagePath;
    currentBabylonUser.email = currentUserDBData.email;
    currentBabylonUser.fullName = currentUserDBData.fullName;
    currentBabylonUser.dateOfBirth = currentUserDBData.dateOfBirth;
    currentBabylonUser.originCountry = currentUserDBData.originCountry;
    currentBabylonUser.about = currentUserDBData.about;
    currentBabylonUser.listedEvents = currentUserDBData.listedEvents;
    currentBabylonUser.userUID = currentUserDBData.userUID;
  }
}
