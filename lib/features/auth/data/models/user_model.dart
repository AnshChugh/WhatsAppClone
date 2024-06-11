import 'dart:convert';

import 'package:whatsapp_clone/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.phoneNumber});
  User copyWith({
    String? id,
    String? phoneNumber,
  }) {
    return User(
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
