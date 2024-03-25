import "package:babylon_app/models/babylon_user.dart";
import "package:babylon_app/models/message.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Chat {

  Message? lastMessage;
  String? adminUID;
  String? iconPath;
  String? chatName;
  List<BabylonUser>? users;

  Chat({this.chatName,this.adminUID,this.lastMessage,this.iconPath});  
}
