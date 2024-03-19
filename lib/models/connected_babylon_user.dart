import "package:babylon_app/models/babylon_user.dart";

class ConnectedBabylonUser extends BabylonUser {
  ConnectedBabylonUser._internal() : super();

  static final ConnectedBabylonUser _instance =
      ConnectedBabylonUser._internal();

  factory ConnectedBabylonUser() => _instance;

  static Future<void> setConnectedBabylonUser(
      final BabylonUser? babylonUser) async {
    _instance.imagePath = babylonUser!.imagePath;
    _instance.email = babylonUser.email;
    _instance.fullName = babylonUser.fullName;
    _instance.dateOfBirth = babylonUser.dateOfBirth;
    _instance.originCountry = babylonUser.originCountry;
    _instance.about = babylonUser.about;
    _instance.listedEvents = babylonUser.listedEvents;
    _instance.userUID = babylonUser.userUID;
  }
}
