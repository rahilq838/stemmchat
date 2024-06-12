class ChatUser{
  String uid;
  String email;
  String? profileUrl;
  ChatUser({required this.uid, required this.email, this.profileUrl});

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(uid:map['uid'], email:  map['email'], profileUrl: map['profileUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'profileUrl': profileUrl,
    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, unReadMessages: $profileUrl}';
  }

}