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
  String? Tittle;

  Event(this.Creator, this.Date, this.FullDescription, this.PictureURL,
      this.Place, this.ShortDescription, this.Tittle);

  Event.withCreator(String userUID, DateTime newDate, String newShortDescription, String newFullDescription, String newPlace, String newTittle
  ){
    Creator = UserService.getBabylonUser(userUID);
    Date = newDate;
    FullDescription = newShortDescription;
    PictureURL = newFullDescription;
    Place = newPlace;
    ShortDescription = newShortDescription;
    Tittle = newTittle;

  }
}




