class STEMMUser{
  String uid;
  String email;
  String? name;
  String? profileUrl;
  STEMMUser({required this.uid, required this.email, this.name, this.profileUrl});

  factory STEMMUser.fromMap(Map<String, dynamic> map) {
    return STEMMUser(uid:map['uid'], email:  map['email'], name: map['name'], profileUrl: map['profileUrl']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profileUrl': profileUrl,
    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, name: $name, profileUrl: $profileUrl}';
  }





}