import "package:babylon_app/models/babylon_user.dart";
import "package:babylon_app/models/message.dart";
import "package:babylon_app/services/user/user_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class ChatService {

  static Future<QuerySnapshot<Map<String, dynamic>>> getChatMessagesStream ({required final chatUID}) async {
    try {
      return await FirebaseFirestore.instance.collection("chats").doc(chatUID).collection("messages").get();
    } catch (e) {
      throw(e);
    }
  }

  static Future<List<Message>> getMessagesFromSnapshot ({required final QuerySnapshot<Map<String, dynamic>> messagesSnapshot}) async {
    List<Message> result = List.empty(growable: true);
    try {
      await Future.forEach(messagesSnapshot.docs, (final aMessageSnapshot) async {
        final aMessageData = aMessageSnapshot.data();
        final BabylonUser? sender = await UserService.getBabylonUser(aMessageData["sender"]);
        result.add(Message(messageDocumentID: aMessageSnapshot.id, message: aMessageData["message"], sender: sender, time: aMessageData["time"]));
      });
      return result;
    } catch (e) {
      throw(e);
    }
  }
}