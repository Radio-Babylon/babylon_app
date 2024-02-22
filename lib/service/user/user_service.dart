import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/material.dart';
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
    }
  }

  static Future<void> addAdditionalInfo(
      {required User user,
      required Map<String, bool> activities,
      required Map<String, bool> music,
      required Map<String, bool> hobbies}) async {
    final userActivities = [], userMusic = [], userHobbies = [];
    //final music = [];
    //final hobbies = [];
    for (final activity in activities.entries) {
      if (activity.value) userActivities.add(activity.key);
    }

    for (final music in music.entries) {
      if (music.value) userMusic.add(music.key);
    }

    for (final hobby in hobbies.entries) {
      if (hobby.value) userHobbies.add(hobby.key);
    }

    if (userActivities.isNotEmpty ||
        userMusic.isNotEmpty ||
        userHobbies.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'activities': userActivities,
            'music': userMusic,
            'hobbies': userHobbies
          })
          .then((value) => print("User Updated and additionalInfo added"))
          .catchError(
              (error) => print("Failed to add the additionalInfo: $error"));
    }
  }
}
