import 'dart:convert';

import 'package:whatsapp_clone/core/common/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name,
      required super.uid,
      required super.profilePic,
      required super.isOnline,
      required super.phoneNumber,
      required super.groupId});

  UserModel copyWith({
    String? name,
    String? uid,
    String? profilePic,
    bool? isOnline,
    String? phoneNumber,
    List<String>? groupId,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      isOnline: isOnline ?? this.isOnline,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      isOnline: map['isOnline'] as bool,
      phoneNumber: map['phoneNumber'] as String,
      groupId: List<String>.from((map['groupId'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
