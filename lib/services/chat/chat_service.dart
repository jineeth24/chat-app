import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/message.dart';

class ChatService {
  //get firestore instance&auth
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestoreRef.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String recieverId, message) async {
    //get current user info
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    //timestamp save
    final Timestamp timestamp = Timestamp.now();

    //create a new message//create a message model
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        recieverId: recieverId,
        timestamp: timestamp,
        message: message);

    //construct chat room id for two user(sorted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); //sort to ensure chatroom id is same for any 2 people
    String chatRoomId = ids.join('_'); //joins two id with underscore=id_id

    //add new message to databse
    await firestoreRef
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return firestoreRef
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
