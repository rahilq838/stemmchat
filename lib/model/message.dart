import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  static const String fileType = "File";
  static const textType = "Text";
  String senderID;
  String senderEmail;
  String receiverID;
  String body;
  String type;
  String? downloadUrl;
  Timestamp timestamp;
  bool read = false;

  Message(
      {
        required this.read,
        required this.senderID,
      required this.senderEmail,
      this.downloadUrl,
      required this.receiverID,
      required this.body,
      required this.type,
      required this.timestamp});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        read: map['read'],
        senderID: map['senderID'],
        senderEmail: map['senderEmail'],
        receiverID: map['receiverID'],
        downloadUrl: map['downloadUrl'],
        body: map['body'],
        type: map['type'],
        timestamp: map['timestamp']);
  }

  Map<String, dynamic> toMap() {
    return {
      'read': read,
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'downloadUrl': downloadUrl,
      'body': body,
      'type': type,
      'timestamp': timestamp
    };
  }

  @override
  String toString() {
    return 'Message{senderID: $senderID, senderEmail: $senderEmail, receiverID: $receiverID, body: $body, timestamp: $timestamp, type: $type, downloadUrl: $downloadUrl, read: $read}';
  }
}
