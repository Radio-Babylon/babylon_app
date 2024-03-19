import 'dart:io';

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
        List<String> attendeesID = List.empty(growable: true);
        var attendeesSnapshot = await db.collection('events').doc(snapShot.id).collection("attendees").get();
        attendeesSnapshot.docs.forEach((anAttendee) {
          attendeesID.add(anAttendee.id);  
        });

        final event = snapShot.data();
        final imageUrl = await FirebaseStorage.instance.ref().child(event["picture"]).getDownloadURL();
        result.add(await Event.create(event["creator"], (event["date"] as Timestamp).toDate(), event["fullDescription"], imageUrl, event["place"], event["shortDescription"], event["title"], snapShot.reference.id, attendeesID));
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
          List<String> attendeesID = List.empty(growable: true);
          var attendeesSnapshot = await db.collection('events').doc(snapShot.id).collection("attendees").get();
          attendeesSnapshot.docs.forEach((anAttendee) {
            attendeesID.add(anAttendee.id);  
          });

          final imageUrl = await FirebaseStorage.instance.ref().child(event["picture"]).getDownloadURL();
          result.add(await Event.create(event["creator"], (event["date"] as Timestamp).toDate(), event["fullDescription"], imageUrl, event["place"], event["shortDescription"], event["title"], snapShot.reference.id, attendeesID));
        }
      });
    } catch (error) {
      print(error);
    }
    return result;
  }

  static Future<bool> addUserToEvent(Event event) async{
    try {
      User currUser = FirebaseAuth.instance.currentUser!;
      final db = FirebaseFirestore.instance;
      await db.collection("users").doc(currUser.uid).collection('listedEvents').doc(event.EventDocumentID).set({});
      await db.collection("events").doc(event.EventDocumentID).collection('attendees').doc(currUser.uid).set({});
      return true;
    } catch (e) {
      print(e);
      throw(e);
    }
  }

  static Future<void> createEvent(String eventName, File image, Timestamp eventTimeStamp, String shortDescription, String description, String place) async{
    try {
      User currUser = FirebaseAuth.instance.currentUser!;
      final db = FirebaseFirestore.instance;
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      final String imgName = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      Reference referenceImageToUpload = referenceDirImages.child(imgName);
      await referenceImageToUpload.putFile(image);
      
      final newEvent = <String, dynamic>{
        "title": eventName,
        "creator": currUser.uid,
        "shortDescription": shortDescription,
        "fullDescription": description,
        "date": eventTimeStamp,
        "place": place,
        "picture": "/images/"+imgName
      };
      db.collection("events").doc().set(newEvent);
    } catch (e) {
      print(e);
      throw(e);
    }
  } 

  static Future<void> updateEvent(String eventUID, String eventName, File? image, Timestamp eventTimeStamp, String shortDescription, String description, String place) async{
    try {
      User currUser = FirebaseAuth.instance.currentUser!;
      final db = FirebaseFirestore.instance;
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');

      final newEventData = <String, dynamic>{
        "title": eventName,
        "creator": currUser.uid,
        "shortDescription": shortDescription,
        "fullDescription": description,
        "date": eventTimeStamp,
        "place": place,
      };

      if(image != null)
      {
        final String imgName = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        Reference referenceImageToUpload = referenceDirImages.child(imgName);
        await referenceImageToUpload.putFile(image!);
        newEventData["picture"] = "/images/"+imgName;
      }
      
      db.collection("events").doc(eventUID).update(newEventData);
    } catch (e) {
      print(e);
      throw(e);
    }
  } 
}
