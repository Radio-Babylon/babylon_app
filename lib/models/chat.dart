import "package:babylon_app/models/babylon_user.dart";
import "package:babylon_app/models/message.dart";

class Chat {
  Message? lastMessage;
  String? adminUID;
  String? iconPath;
  String? chatName;
  List<BabylonUser>? users;

  Chat({this.chatName, this.adminUID, this.lastMessage, this.iconPath});
}
