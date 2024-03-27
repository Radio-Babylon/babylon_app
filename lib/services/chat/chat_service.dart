import "dart:async";

import "dart:ffi";
import "dart:io";
import "package:babylon_app/models/babylon_user.dart";
import "package:babylon_app/models/chat.dart";
import "package:babylon_app/models/connected_babylon_user.dart";
import "package:babylon_app/models/message.dart";
import "package:babylon_app/services/user/user_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";

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
          .orderBy("time", descending: true)
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

  static Future<void> createChat(
      {final String? adminUID,
      final String? chatDescription,
      required final String chatName,
      final File? image,
      final List<String> usersUID = const []}) async {
    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();
      final newChatData = <String, dynamic>{
        "chatName": chatName,
      };

      if (adminUID != null) {
        newChatData["admin"] = adminUID;
      }

      if (chatDescription != null) {
        newChatData["chatDescription"] = chatDescription;
      }

      if (image != null) {
        final Reference referenceRoot = FirebaseStorage.instance.ref();
        final Reference referenceDirImages = referenceRoot.child("images");
        final String imgName =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        final Reference referenceImageToUpload =
            referenceDirImages.child(imgName);
        await referenceImageToUpload.putFile(image);

        newChatData["iconPath"] = "/images/${imgName}";
      }

      final DocumentReference chatRef =
          await db.collection("chats").add(newChatData);

      usersUID.forEach((final userUID) {
        final docRef = db
            .collection("chats")
            .doc(chatRef.id)
            .collection("users")
            .doc(userUID);
        batch.set(docRef, {"userUID": userUID});
      });
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
