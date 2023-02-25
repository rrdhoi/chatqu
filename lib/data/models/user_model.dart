import 'package:chatqu/domain/domain.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? userId;
  final String? username;
  final String? email;
  final String? name;
  final String? imageProfile;

  const UserModel(
      {required this.userId,
      required this.username,
      required this.email,
      required this.name,
      required this.imageProfile});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "username": username,
      "email": email,
      "name": name,
      "imgProfile": imageProfile,
    };
  }

  factory UserModel.fromEntity(UserEntity user) => UserModel(
        userId: user.userId,
        username: user.username,
        email: user.email,
        name: user.name,
        imageProfile: user.imageProfile,
      );

  UserEntity toEntity() => UserEntity(
        userId: userId,
        username: username,
        email: email,
        name: name,
        imageProfile: imageProfile,
      );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      username: map['username'],
      email: map['email'],
      name: map['name'],
      imageProfile: map['imgProfile'],
    );
  }

  factory UserModel.emptyData() => const UserModel(
        userId: null,
        username: null,
        email: null,
        name: null,
        imageProfile: null,
      );

  @override
  List<Object?> get props => [userId, username, email, name, imageProfile];
}
