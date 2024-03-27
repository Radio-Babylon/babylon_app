import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class ChatException {
  static void validateUpdateOrCreateForm(
      {final String? adminUID,
      final List<String>? usersUID,
      final String? chatDescription,
      required final String chatName,
      final File? image}) {
    if (chatName == "") {
      throw ("The chat name is missing");
    }
  }
}
