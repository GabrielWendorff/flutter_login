class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL; // Add photoURL field

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL, // Initialize photoURL
  });

  // Convert the UserModel to a map (for database or local storage purposes)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL, // Include photoURL in the map
    };
  }

  // Create a UserModel from a map (useful for fetching from database or local storage)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      displayName: map['displayName'],
      email: map['email'],
      photoURL: map['photoURL'], // Parse photoURL from the map
    );
  }
}
