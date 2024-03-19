import "package:babylon_app/models/partner.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";

class PartnerService {
  static Future<List<Partner>> getPartners() async{
    final List<Partner> result = List.empty(growable: true);
    try {
      final db = FirebaseFirestore.instance;
      final snapShot = await db.collection("partners").get();
      
      await Future.forEach(snapShot.docs, (final snapShot) async {
        final partner = snapShot.data();
        final imageUrl = await FirebaseStorage.instance.ref().child(partner["picture"]).getDownloadURL();
        result.add(Partner(partner["name"],imageUrl,partner["shortDescription"],partner["fullDescription"],partner["discount"],partner["location"],snapShot.id)); 
      });
      
      print(result);
    } catch (error) {
      print(error);
    }
    return result;
  }
}