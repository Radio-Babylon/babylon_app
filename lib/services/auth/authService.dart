import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } catch (e) {
      print(e);
      throw (e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } catch (e) {
      print(e);
      throw (e);
    }
    return user;
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var signedIdUser = await FirebaseAuth.instance.signInWithCredential(credential);

    await hasCurrentUserData();
    // Once signed in, return the UserCredential
    return signedIdUser;
  }

  static Future<void> hasCurrentUserData() async{
    try {
      User currUser = FirebaseAuth.instance.currentUser!;
      final db = FirebaseFirestore.instance;
      final docUser = await db.collection('users').doc(currUser.uid).get();
      final userData = docUser.data();
      if(userData == null){
        final userNewData = <String, String>{
          "Country of Origin": "*",
          "Date of Birth": DateTime.now().toLocal().toString(),
          "Email Address": currUser.email!,
          "Name" : currUser.displayName!,          
        };
        userNewData["ImageUrl"] = currUser.photoURL!;
        await db.collection("users").doc(currUser.uid).set(userNewData);
      }
    } catch (e) {
      throw(e);
    }
  } 
}
