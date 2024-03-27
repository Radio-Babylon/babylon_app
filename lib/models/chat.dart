import "package:babylon_app/models/babylon_user.dart";
import "package:babylon_app/models/message.dart";

class Chat {
  String chatUID;
  Message? lastMessage;
  String? adminUID;
  String? iconPath;
  String? chatName;
  List<BabylonUser>? users;

  Chat(
      {required this.chatUID,
      this.chatName,
      this.adminUID,
      this.lastMessage,
      this.iconPath});
}
