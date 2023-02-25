import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? username;
  final String? email;
  final String? name;
  final String? imageProfile;
  final String? publicKey;

  const UserEntity(
      {this.userId,
      this.username,
      this.email,
      this.name,
      this.imageProfile,
      this.publicKey});

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userId: map['userId'],
      username: map['username'],
      email: map['email'],
      name: map['name'],
      imageProfile: map['imgProfile'],
      publicKey: map['publicKey'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "username": username,
      "email": email,
      "name": name,
      "imgProfile": imageProfile,
      "publicKey": publicKey,
    };
  }

  @override
  List<Object?> get props =>
      [userId, username, email, name, imageProfile, publicKey];
}
