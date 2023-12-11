import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? id;
  String? comment;
  String? userId;
  String? postId;
  Timestamp? createdAt;
  UserModel? user;

  Comment({
    this.id,
    this.comment,
    this.userId,
    this.postId,
    this.createdAt,
    this.user,
  });

  factory Comment.fromJson(
      {required String id, required Map<String, dynamic> json}) {
    return Comment(
      id: id,
      comment: json['comment'],
      createdAt: json['created_at'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

class UserModel {
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? uid;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
      uid: json['uid'],
    );
  }
}
