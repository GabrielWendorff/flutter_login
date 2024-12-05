class UserModel {
  final String uid;
  final String? displayName;
  final String? email;

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      displayName: map['displayName'],
      email: map['email'],
    );
  }
}