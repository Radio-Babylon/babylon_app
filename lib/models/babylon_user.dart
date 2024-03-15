import "package:babylon_app/services/user/userService.dart";
import "package:firebase_auth/firebase_auth.dart";

class BabylonUser {
  // Attributes

  String _userUID = "";
  String _fullName = "";
  String _email = "";
  String? _dateOfBirth;
  String? _originCountry;
  String? _about;
  String _imagePath = "";
  List<String> _listedEvents = [];

  // Getters and Setters

  String get getUserUID => _userUID;
  set setUserUID(final String userUID) => _userUID = userUID;

  String get getFullName => _fullName;
  set setFullName(final String fullName) => _fullName = fullName;

  String get getEmail => _email;
  set setEmail(final String email) => _email = email;

  String? get getDateOfBirth => _dateOfBirth;
  set setDateOfBirth(final String? dataOfBirth) => _dateOfBirth = dataOfBirth;

  String? get getOriginCountry => _originCountry;
  set setOriginCountry(final String? originCountry) =>
      _originCountry = originCountry;

  String? get getAbout => _about;
  set setAbout(final String? about) => _about = about;

  String get getImagePath => _imagePath;
  set setImagePath(final String imagePath) => _imagePath = imagePath;

  List<String> get getListedEvents => _listedEvents;
  set setListedEvents(final List<String> listedEvents) =>
      _listedEvents = listedEvents;

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
    final List<String> listedEvents
  );
  BabylonUser.fromUser({required final User? currentUser}) {
    _imagePath = currentUser?.photoURL ?? "";
    _email = currentUser?.email ?? "";
    _fullName = currentUser?.displayName ?? "";
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
    currentBabylonUser._imagePath = currentUserDBData!._imagePath;
    currentBabylonUser._email = currentUserDBData._email;
    currentBabylonUser._fullName = currentUserDBData._fullName;
    currentBabylonUser._dateOfBirth = currentUserDBData._dateOfBirth;
    currentBabylonUser._originCountry = currentUserDBData._originCountry;
    currentBabylonUser._about = currentUserDBData._about;
    currentBabylonUser._listedEvents = currentUserDBData._listedEvents;
    currentBabylonUser._userUID = currentUserDBData._userUID;
  }
}
