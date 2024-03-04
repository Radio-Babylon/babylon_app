import 'package:babylon_app/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        result.add(await Event.create(event["creator"], (event["date"] as Timestamp).toDate(), event["fullDescription"], imageUrl, event["place"], event["shortDescription"], event["title"]));
      });
    } catch (error) {
      print(error);
    }
    return result;
  }
}
