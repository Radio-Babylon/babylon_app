import 'package:babylon_app/models/babylonUser.dart';
import 'package:babylon_app/services/event/eventService.dart';
import 'package:babylon_app/services/user/userService.dart';

class Event {
  BabylonUser? Creator;
  DateTime? Date;
  String? FullDescription;
  String? PictureURL;
  String? Place;
  String? ShortDescription;
  String? Title;

  Event(this.Creator, this.Date, this.FullDescription, this.PictureURL,
      this.Place, this.ShortDescription, this.Title);

  static Future<Event> create(userUID, newDate, newFullDescription, newPictureURL, newPlace, newShortDescription, newTitle) async {
    BabylonUser? user = await UserService.getBabylonUser(userUID);
    return Event(user, newDate, newFullDescription, newPictureURL, newPlace, newShortDescription, newTitle);
  }
}




