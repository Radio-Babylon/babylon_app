import 'dart:convert';
import 'dart:typed_data';
import 'package:babylon_app/models/babylonUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserService {
  static Future<void> fillUser(
      {required User user, required Map<String, String> userInfo}) async {
    final db = FirebaseFirestore.instance;

    final docUser = db.collection('users').doc(user.uid);

    try {
      await docUser.set(userInfo);
    } catch (e) {
      print("Error writing document: $e");
    }
  }

  static Future<void> addPhoto({required User user, required File file}) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    final String imgName = '${user.uid}.jpg';
    Reference referenceImageToUpload = referenceDirImages.child(imgName);
    String imgUrl = '';
    try {
      await referenceImageToUpload.putFile(file);
      imgUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
    if (imgUrl.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'ImageUrl': imgUrl})
          .then((value) => print("User Updated and photo added"))
          .catchError((error) => print("Failed to add the photo: $error"));

      try {
        await user.updatePhotoURL(imgUrl);
      } catch (error) {
        print("Failed to add the photo to user in auth: $error");
      }
    }
  }

  static Future<void> updateUserInfo(
      {required String uuid,
      Map<String, String>? newData,
      Map<String, bool>? activities,
      Map<String, bool>? music,
      Map<String, bool>? hobbies}) async {
    final userActivities = [], userMusic = [], userHobbies = [];

    if(activities != null)
      for (final activity in activities.entries) {
        if (activity.value) userActivities.add(activity.key);
      }

    if(music != null)
      for (final music in music.entries) {
        if (music.value) userMusic.add(music.key);
      }

    if(hobbies != null)
      for (final hobby in hobbies.entries) {
        if (hobby.value) userHobbies.add(hobby.key);
      }

    if (userActivities.isNotEmpty ||
        userMusic.isNotEmpty ||
        userHobbies.isNotEmpty || newData!.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uuid)
          .update({
            'activities': userActivities,
            'music': userMusic,
            'hobbies': userHobbies,
            'Country of Origin' : newData!.containsKey("originCountry") ? newData["originCountry"] : "",
            'Date of Birth' : newData.containsKey("birthDate") ? newData["birthDate"] : "",
            'About' : newData.containsKey("about") ? newData["about"] : "",
            'Name' : newData.containsKey("name") ? newData["name"] : "",
          })
          .then((value) => print("User Updated and additionalInfo added"))
          .catchError(
              (error) => print("Failed to add the additionalInfo: $error"));
    }
  }

  static Future<void> getUserImgUrl({required User user}) async {
    final db = FirebaseFirestore.instance;

    final docUser = db.collection('users').doc(user.uid);
  }

  static Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }

  static Future<BabylonUser?> getBabylonUser(String userUID) async {
    BabylonUser? result;
    Map<String, String> userInfo = {};

    try {
      List<String> eventsLists = List.empty(growable: true);
      final db = FirebaseFirestore.instance;
      final docUser = await db.collection('users').doc(userUID).get();
      final userData = docUser.data();
      userInfo["name"] = userData!.containsKey("Name") ? userData["Name"]: "" ;
      userInfo["email"] = userData.containsKey("Email Address") ? userData["Email Address"] : "" ;
      userInfo["imgURL"] = userData.containsKey("ImageUrl") ? userData["ImageUrl"] : "" ;
      userInfo["UUID"] = docUser.id;
      userInfo["about"] =  userData.containsKey("About") ? userData["About"] : "";
      userInfo["country"] = userData.containsKey("Country of Origin") ? userData["Country of Origin"] : "";
      userInfo["birthDate"] = userData.containsKey("Date of Birth") ? userData["Date of Birth"] : "";

      final docsListedEvents = await db.collection('users').doc(userUID).collection('listedEvents').get();
      await Future.forEach(docsListedEvents.docs, (snapShot) async {
        eventsLists.add(snapShot.reference.id);
      });
      result = BabylonUser.withData(
        userInfo["name"]!, 
        userInfo["email"]!, 
        userInfo["imgURL"]!, 
        eventsLists,
        userInfo["UUID"]!,
        userInfo["about"]!,
        userInfo["country"]!,
        userInfo["birthDate"]!
      );
      print(userData);
    } catch (e) {
      print(e);
    }
    return result;
  }
}
