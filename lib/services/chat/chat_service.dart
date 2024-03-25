import "dart:async";

import "package:babylon_app/models/babylon_user.dart";
import "package:babylon_app/models/message.dart";
import "package:babylon_app/services/user/user_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class ChatService {

  static StreamController<List<Message>> getChatStream ({required final chatUID}) {
    try {
      StreamController<List<Message>> streamController = StreamController();
      FirebaseFirestore.instance.collection("chats").doc(chatUID).collection("messages").snapshots().listen((querySnapshot) async {
        List<Message> messages = [];
        for (var messageDoc in querySnapshot.docs) 
          messages.add(Message(
              messageDocumentID: messageDoc.id,
              message: messageDoc['message'],
              time: messageDoc['time'],
              sender: await UserService.getBabylonUser(messageDoc['sender']),
          ));
        streamController.add(messages);
      });
      return streamController;
    } 
    catch (e) {
      throw(e);
    }
  }
}