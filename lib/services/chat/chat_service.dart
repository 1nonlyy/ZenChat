import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/model/message.dart';
class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> sendMessage(String receiverUserID, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newmessage = Message(senderID: currentUserId, senderEmail: currentUserEmail, message: message, receiverID: receiverUserID, timestamp: timestamp);

    List<String> ids = [currentUserId, currentUserEmail];
    ids.sort();
    String chatroomID = ids.join(
      "_"
    );
    await _firebaseFirestore.collection('chat_rooms').doc(chatroomID).collection('messages').add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otheruserId) {
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chatroomID = ids.join("_");
    return _firebaseFirestore.collection('chat_rooms').doc(chatroomID).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }
}