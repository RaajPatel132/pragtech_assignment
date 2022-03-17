import 'dart:core';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  bool? isLiked = false;

  UserModel(
      this.id, this.name, this.username, this.email, this.phone, this.isLiked);

  factory UserModel.fromMap(map, likedUsers) {
    return UserModel(
      map['id'],
      map['name'],
      map['username'],
      map['email'],
      map['phone'],
      (likedUsers as List).contains(map['id']),
    );
  }
}
