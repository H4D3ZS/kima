import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kima/src/data/models/message_model.dart';
import 'package:kima/src/utils/get_user.dart';

class MessageService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
    String receiverId,
    String message,
    BuildContext context,
  ) async {
    // Use getUserId to get the current user ID
    final currentUserId = getUserId(context);
    if (currentUserId.isEmpty) {
      // Handle the case where user ID is empty (optional)
      print('Error: User ID is empty');
      return;
    }

    //final date = DateTime.now().toString();
    final date = DateTime.now().toUtc().toIso8601String();

    Message messageData = Message(
      senderId: currentUserId,
      message: message,
      senderName:
          "senderName", //initial, change the value if you want to store the sender name
      receiverId: receiverId,
      receiverName:
          "receiverName", //initial, change the value if you want to store the receiver name
      timestamp: date,
      isHiddenUser1: false,
      isHiddenUser2: false,
      isReadUser1: receiverId != currentUserId ? true : false,
      isReadUser2: receiverId == currentUserId ? true : false,
    );

    List<String> usersIds = [currentUserId, receiverId];
    usersIds.sort();
    String chatRoomId = usersIds.join("_");
    await _firestore.collection("chatRooms").doc(chatRoomId).set({
      "documentId": chatRoomId,
      "isReadUser1": false,
      "isReadUser2": false,
      "isHiddenUser1": false,
      "isHiddenUser2": false
    });

    await _firestore
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(messageData.toMap());
  }

  Stream<QuerySnapshot> getMessages(
    String userId,
    String otherUserId,
    BuildContext context,
  ) {
    List<String> usersIds = [userId, otherUserId];
    usersIds.sort();
    String chatRoomId = usersIds.join("_");

    return _firestore
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
