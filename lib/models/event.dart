import "package:babylon_app/models/babylonUser.dart";
import "package:babylon_app/services/event/eventService.dart";
import "package:babylon_app/services/user/userService.dart";

class Event {
  String EventDocumentID;
  BabylonUser? Creator;
  DateTime? Date;
  String? FullDescription;
  String? PictureURL;
  String? Place;
  String? ShortDescription;
  String? Title;
  List<BabylonUser?> Attendees = []; 

  Event(this.Creator, this.Date, this.FullDescription, this.PictureURL,
      this.Place, this.ShortDescription, this.Title, this.EventDocumentID, this.Attendees);

  static Future<Event> create(userUID, newDate, newFullDescription, newPictureURL, newPlace, newShortDescription, newTitle, newEventDocumentID, List<String> attendeesID) async {
    BabylonUser? user = await UserService.getBabylonUser(userUID);
    List<BabylonUser?> attendees = List.empty(growable: true);
    await Future.forEach(attendeesID, (attendee) async {
        attendees.add(await UserService.getBabylonUser(attendee));
      });
    return Event(user, newDate, newFullDescription, newPictureURL, newPlace, newShortDescription, newTitle, newEventDocumentID, attendees);
  }
}




