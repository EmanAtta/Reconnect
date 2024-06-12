
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderEmail;
  final String receiverEmail;
  final Timestamp timestamp;
  final String message;

  Message({
    required this.senderEmail,
    required this.receiverEmail,
    required this.timestamp,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'timestamp': timestamp,
      'message': message,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderEmail: map['senderEmail'],
      receiverEmail: map['receiverEmail'],
      timestamp: map['timestamp'],
      message: map['message'],
    );
  }

  // Override == operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.senderEmail == senderEmail &&
        other.receiverEmail == receiverEmail &&
        other.timestamp == timestamp &&
        other.message == message;
  }

  // Override hashCode
  @override
  int get hashCode {
    return senderEmail.hashCode ^
    receiverEmail.hashCode ^
    timestamp.hashCode ^
    message.hashCode;
  }
}
