import 'package:babylon_app/models/partner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PartnerService {
  static Future<List<Partner>> getPartners() async{
    List<Partner> result = List.empty(growable: true);
    try {
      final db = FirebaseFirestore.instance;
      var snapShot = await db.collection('partners').get();
      snapShot.docs.forEach((snapShot) async{
        final partner = snapShot.data();
        final imageUrl = await FirebaseStorage.instance.ref().child(partner["picture"]).getDownloadURL();
        result.add(Partner(partner["name"],imageUrl,partner["shortDescription"],partner["fullDescription"],partner["discount"],partner["location"])); 
      });
      print(result);
    } catch (error) {
      print(error);
    }
    return result;
  }
}