//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:reconnect/Views/Chat/Model/message.dart';
//
// class ChatService extends ChangeNotifier {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> sendMessage(
//       String receiverId,
//       String message,
//       String receiverEmail,
//       ) async {
//     final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
//     final Timestamp timestamp = Timestamp.now();
//
//     Message newMessage = Message(
//       senderEmail: currentUserEmail,
//       timestamp: timestamp,
//       message: message,
//       receiverEmail: receiverEmail,
//     );
//
//     try {
//       // Add message to sender's sub-collection
//       await _firestore
//           .collection('Email_Message_Rooms')
//           .doc(currentUserEmail)
//           .collection(receiverEmail)
//           .add(newMessage.toMap());
//
//       // Add message to receiver's sub-collection
//       await _firestore
//           .collection('Email_Message_Rooms')
//           .doc(receiverEmail)
//           .collection(currentUserEmail)
//           .add(newMessage.toMap());
//
//
//       // Add receiver's email to a new collection
//       await _firestore
//           .collection('Receiver_Emails')
//           .doc(currentUserEmail)
//           .collection('Emails')
//           .doc(receiverEmail)
//           .set({
//         'email': receiverEmail,
//         'timestamp': timestamp,
//       });
//
//       await _firestore
//           .collection('Receiver_Emails')
//           .doc(receiverEmail)
//           .collection('Emails')
//           .doc(currentUserEmail)
//           .set({
//         'email': currentUserEmail,
//         'timestamp': timestamp,
//       });
//
//
//       // print('Message sent from $currentUserEmail to $receiverEmail');
//     } catch (e) {
//       throw Exception("Failed to send message: $e");
//     }
//   }
//
//
//   Stream<List<Message>> getMessages(String currentUserEmail, String receiverEmail) {
//     // Fetch messages from sender's sub-collection
//     var senderStream = _firestore
//         .collection('Email_Message_Rooms')
//         .doc(currentUserEmail)
//         .collection(receiverEmail)
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//
//     // Fetch messages from receiver's sub-collection
//     var receiverStream = _firestore
//         .collection('Email_Message_Rooms')
//         .doc(receiverEmail)
//         .collection(currentUserEmail)
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//
//     // Combine the two streams and sort messages by timestamp
//     return senderStream.asyncExpand((senderSnapshot) {
//       return receiverStream.map((receiverSnapshot) {
//         // Combine sender and receiver documents into one list
//         List<QueryDocumentSnapshot> allMessages = []
//           ..addAll(senderSnapshot.docs)
//           ..addAll(receiverSnapshot.docs);
//
//         // Convert QueryDocumentSnapshot to Message
//         List<Message> messages = allMessages.map((doc) {
//           return Message.fromMap(doc.data() as Map<String, dynamic>);
//         }).toList();
//
//         // Remove duplicates based on a unique property
//         messages = messages.toSet().toList();
//
//         // Sort the combined messages by timestamp
//         messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//         return messages;
//       });
//     });
//   }
//
//
//
//
//
// }
//
//
//
//
//
//
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reconnect/Views/Chat/Model/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String receiverId,
      String message,
      String receiverEmail,
      ) async {
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderEmail: currentUserEmail,
      timestamp: timestamp,
      message: message,
      receiverEmail: receiverEmail,
    );

    try {
      // Add message to sender's sub-collection
      await _firestore
          .collection('Email_Message_Rooms')
          .doc(currentUserEmail)
          .collection(receiverEmail)
          .add(newMessage.toMap());

      // Add message to receiver's sub-collection
      await _firestore
          .collection('Email_Message_Rooms')
          .doc(receiverEmail)
          .collection(currentUserEmail)
          .add(newMessage.toMap());

      // Add receiver's email to a new collection
      await _firestore
          .collection('Receiver_Emails')
          .doc(currentUserEmail)
          .collection('Emails')
          .doc(receiverEmail)
          .set({
        'email': receiverEmail,
        'timestamp': timestamp,
      });

      await _firestore
          .collection('Receiver_Emails')
          .doc(receiverEmail)
          .collection('Emails')
          .doc(currentUserEmail)
          .set({
        'email': currentUserEmail,
        'timestamp': timestamp,
      });

      // print('Message sent from $currentUserEmail to $receiverEmail');
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }

  Stream<Message?> getLastMessage(String currentUserEmail, String receiverEmail) {
    var senderStream = _firestore
        .collection('Email_Message_Rooms')
        .doc(currentUserEmail)
        .collection(receiverEmail)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();

    var receiverStream = _firestore
        .collection('Email_Message_Rooms')
        .doc(receiverEmail)
        .collection(currentUserEmail)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();

    return senderStream.asyncExpand((senderSnapshot) {
      return receiverStream.map((receiverSnapshot) {
        List<QueryDocumentSnapshot> allMessages = []
          ..addAll(senderSnapshot.docs)
          ..addAll(receiverSnapshot.docs);

        if (allMessages.isEmpty) {
          return null;
        }

        List<Message> messages = allMessages.map((doc) {
          return Message.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return messages.first;
      });
    });
  }

  Stream<List<Message>> getMessages(String currentUserEmail, String receiverEmail) {
    var senderStream = _firestore
        .collection('Email_Message_Rooms')
        .doc(currentUserEmail)
        .collection(receiverEmail)
        .orderBy('timestamp', descending: false)
        .snapshots();

    var receiverStream = _firestore
        .collection('Email_Message_Rooms')
        .doc(receiverEmail)
        .collection(currentUserEmail)
        .orderBy('timestamp', descending: false)
        .snapshots();

    return senderStream.asyncExpand((senderSnapshot) {
      return receiverStream.map((receiverSnapshot) {
        List<QueryDocumentSnapshot> allMessages = []
          ..addAll(senderSnapshot.docs)
          ..addAll(receiverSnapshot.docs);

        List<Message> messages = allMessages.map((doc) {
          return Message.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        messages = messages.toSet().toList();
        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

        return messages;
      });
    });
  }

  String formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('yyyy-MM-dd, HH-mm');
    return formatter.format(dateTime);
  }
}
