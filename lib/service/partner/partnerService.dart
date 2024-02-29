import 'package:babylon_app/models/partner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartnerService {
  static Future<List<Partner>> getPartners() async{
    List<Partner> result = List.empty(growable: true);
    try {
      final db = FirebaseFirestore.instance;
      var snapShot = await db.collection('partners').get();
      snapShot.docs.forEach((snapShot) {
        final partner = snapShot.data();
        result.add(Partner(partner["name"],partner["picture"],partner["shortDescription"],partner["fullDescription"],partner["discount"],partner["location"])); 
      });
      print(result);
    } catch (error) {
      print(error);
    }
    return result;
  }
}