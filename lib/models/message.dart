import "package:babylon_app/models/babylon_user.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Message {

  String? messageDocumentID;
  String? message;
  BabylonUser? sender;
  Timestamp? time;

  Message({this.messageDocumentID,this.sender,this.message,this.time});  
}
