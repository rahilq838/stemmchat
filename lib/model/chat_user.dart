class ChatUser{
  String uid;
  String email;
  String? unReadMessages = "0";
  ChatUser({required this.uid, required this.email, this.unReadMessages});

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(uid:map['uid'], email:  map['email'], unReadMessages: map['unReadMessages']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'unReadMessages': unReadMessages,
    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, unReadMessages: $unReadMessages}';
  }

}