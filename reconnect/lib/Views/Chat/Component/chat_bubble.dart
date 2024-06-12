

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String senderEmail;
  final String receiverEmail;
  final bool isCurrentUser;
  final Timestamp timestamp;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.senderEmail,
    required this.receiverEmail,
    required this.isCurrentUser,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('yyyy-MM-dd, HH-mm').format(timestamp.toDate());

    return Padding(
      padding: EdgeInsets.only(
        right: isCurrentUser ? 8 : 0,
        left: isCurrentUser ? 0 : 8,
        top: 3,
      ),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: isCurrentUser ? Radius.circular(15) : Radius.circular(0),
              bottomRight: isCurrentUser ? Radius.circular(0) : Radius.circular(15),

            ),
            color: isCurrentUser ? const Color(0xFF4A563E) : Colors.grey.shade200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: isCurrentUser ? const Color(0xFFFFE8D6) : Colors.black,
                ),
              ),

              Text(
                formattedTime, // Use the formatted time
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





