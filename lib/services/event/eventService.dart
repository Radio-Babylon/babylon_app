import 'package:babylon_app/models/babylonUser.dart';
import 'package:babylon_app/models/event.dart';
import 'package:babylon_app/services/user/userService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventService {
  static Future<List<Event>> getEvents() async{
    List<Event> result = List.empty(growable: true);
    try {
      final db = FirebaseFirestore.instance;
      var snapShot = await db.collection('events').get();
      
      await Future.forEach(snapShot.docs, (snapShot) async {
        final event = snapShot.data();
        final imageUrl = await FirebaseStorage.instance.ref().child(event["picture"]).getDownloadURL();
        result.add(await Event.create(event["creator"], (event["date"] as Timestamp).toDate(), event["fullDescription"], imageUrl, event["place"], event["shortDescription"], event["title"], snapShot.reference.id));
      });
    } catch (error) {
      print(error);
    }
    return result;
  }

  static Future<List<Event>> getListedEventsOfUser(String uuid) async{
    BabylonUser? babylonUser = await UserService.getBabylonUser(uuid);
    List<Event> result = List.empty(growable: true);
    try {
      final db = FirebaseFirestore.instance;
      var snapShot = await db.collection('events').get();
      await Future.forEach(snapShot.docs, (snapShot) async {
        final event = snapShot.data();
        if(babylonUser!.listedEvents.contains(snapShot.reference.id)){
          final imageUrl = await FirebaseStorage.instance.ref().child(event["picture"]).getDownloadURL();
          result.add(await Event.create(event["creator"], (event["date"] as Timestamp).toDate(), event["fullDescription"], imageUrl, event["place"], event["shortDescription"], event["title"], snapShot.reference.id));
        }
      });
    } catch (error) {
      print(error);
    }
    return result;
  }

  static Future<void> addUserToEvent(Event event) async{
    try {
      User currUser = FirebaseAuth.instance.currentUser!;
      final db = FirebaseFirestore.instance;
      final docUserListedEvents = await db.collection('users').doc(currUser.uid).collection('listedEvents').get();
      final userListedEvents = docUserListedEvents.docs;
      await db.collection("users").doc(currUser.uid).collection('listedEvents').doc(event.EventDocumentID).set({});
    } catch (e) {
      print(e);
      throw(e);
    }
  } 
}
