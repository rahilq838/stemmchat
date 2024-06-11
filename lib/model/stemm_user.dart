class STEMMUser{
  String uid;
  String email;
  STEMMUser({required this.uid, required this.email});

  factory STEMMUser.fromMap(Map<String, dynamic> map) {
    return STEMMUser(uid:map['uid'], email:  map['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email}';
  }





}