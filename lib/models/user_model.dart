class UserModel {
  String email;
  String imageUrl;
  String username;
  String userId;

  UserModel({
    required this.email,
    required this.imageUrl,
    required this.username,
    required this.userId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      imageUrl: map['imageUrl'],
      username: map['username'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'imageUrl': imageUrl,
      'username': username,
      'userId': userId,
    };
  }
}
