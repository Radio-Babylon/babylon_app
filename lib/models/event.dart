import "package:babylon_app/models/babylon_user.dart";
import "package:babylon_app/services/user/userService.dart";

class Event {

  // Attributes

  String _eventDocumentID;
  String? _title;
  BabylonUser? _creator;
  String? _place;
  DateTime? _date;
  String? _fullDescription;
  String? _shortDescription;
  String? _pictureURL;
  List<BabylonUser?> _attendees = []; 

  // Getters and Setters

  get getEventDocumentID => _eventDocumentID;
  set setEventDocumentID(final String eventDocumentID) => _eventDocumentID = eventDocumentID;

  get getTitle => _title;
  set setTitle(final String title) => _title = title;

  get getCreator => _creator;
  set setCreator(final BabylonUser? creator) => _creator = creator;

  get getPlace => _place;
  set setPlace(final String? place) => _place = place;

  get getDate => _date;
  set setDate(final DateTime? date) => _date = date;

  get getFullDescription => _fullDescription;
  set setFullDescription(final String? fullDescription) => _fullDescription = fullDescription;

  get getShortDescription => _shortDescription;
  set setShortDescription(final String? shortDescription) => _shortDescription = shortDescription;

  get getPictureURL => _pictureURL;
  set setPictureURL(final String? pictureURL) => _pictureURL = pictureURL;

  get getAttendees => _attendees;
  set setAttendees(final List<BabylonUser?> attendees) => _attendees = attendees;

  Event (
    final String eventDocumentID, 
    final String title,
    final BabylonUser? creator,
    final String? place,  
    final DateTime? date, 
    final String? fullDescription, 
    final String? shortDescription, 
    final String? pictureURL,  
    final List<BabylonUser?> attendees
  ) : 
    _eventDocumentID = eventDocumentID, 
    _title = title, 
    _creator = creator,
    _place = place, 
    _date = date, 
    _fullDescription = fullDescription, 
    _shortDescription = shortDescription,
    _pictureURL = pictureURL,  
    _attendees = attendees;

  static Future<Event> create (
    final String newEventDocumentID,
    final String newTitle,  
    final String babylonUserUID, 
    final String? newPlace, 
    final DateTime? newDate, 
    final String? newFullDescription, 
    final String? newShortDescription, 
    final String? newPictureURL, 
    final List<String> attendeeIDs
  ) async {
    final BabylonUser? user = await UserService.getBabylonUser(babylonUserUID);
    final List<BabylonUser?> attendees = List.empty(growable: true);
    await Future.forEach(attendeeIDs, (final attendee) async {
        attendees.add(await UserService.getBabylonUser(attendee));
      });
    return Event (
      newEventDocumentID,
      newTitle,  
      user, 
      newPlace, 
      newDate, 
      newFullDescription, 
      newShortDescription, 
      newPictureURL, 
      attendees
    );
  }
}




