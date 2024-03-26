import "dart:async";

import "package:babylon_app/models/message.dart";
import "package:babylon_app/services/user/user_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class ChatService {
  static StreamController<List<Message>> getChatStream(
      {required final chatUID}) {
    try {
      final StreamController<List<Message>> streamController =
          StreamController();
      FirebaseFirestore.instance
          .collection("chats")
          .doc(chatUID)
          .collection("messages")
          .orderBy("time", descending: false)
          .snapshots()
          .listen((final querySnapshot) async {
        final List<Message> messages = [];
        for (final messageDoc in querySnapshot.docs) {
          messages.add(Message(
            messageDocumentID: messageDoc.id,
            message: messageDoc["message"],
            time: messageDoc["time"],
            sender: await UserService.getBabylonUser(messageDoc["sender"]),
          ));
        }
        streamController.add(messages);
      });
      return streamController;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> sendMessage(
      {required final String chatUID, required final Message message}) async {
    try {
      FirebaseFirestore.instance
          .collection("chats")
          .doc(chatUID)
          .collection("messages")
          .doc()
          .set({
        "message": message.message,
        "time": message.time,
        "sender": message.sender!.userUID
      });
    } catch (e) {
      rethrow;
    }
  }
}
