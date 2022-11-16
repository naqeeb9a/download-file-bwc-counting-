// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.meta,
    required this.data,
  });

  final Meta? meta;
  final Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta == null ? null : meta!.toJson(),
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    required this.oauth,
    required this.member,
  });

  final Oauth? oauth;
  final Member? member;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        oauth: json["oauth"] == null ? null : Oauth.fromJson(json["oauth"]),
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "oauth": oauth == null ? null : oauth!.toJson(),
        "member": member == null ? null : member!.toJson(),
      };
}

class Member {
  Member({
    required this.id,
    required this.username,
    required this.authKey,
    required this.passwordHash,
    required this.passwordResetToken,
    required this.email,
    required this.status,
    required this.role,
    required this.userLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLoginToken,
    required this.createdDate,
    required this.phone,
    required this.deleteCode,
  });

  final int? id;
  final String? username;
  final String? authKey;
  final String? passwordHash;
  final dynamic passwordResetToken;
  final String? email;
  final int? status;
  final int? role;
  final dynamic userLevel;
  final int? createdAt;
  final int? updatedAt;
  final String? lastLoginToken;
  final dynamic createdDate;
  final String? phone;
  final dynamic deleteCode;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        username: json["username"],
        authKey: json["auth_key"],
        passwordHash: json["password_hash"],
        passwordResetToken: json["password_reset_token"],
        email: json["email"],
        status: json["status"],
        role: json["role"],
        userLevel: json["user_level"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        lastLoginToken: json["last_login_token"],
        createdDate: json["created_date"],
        phone: json["phone"],
        deleteCode: json["delete_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "auth_key": authKey,
        "password_hash": passwordHash,
        "password_reset_token": passwordResetToken,
        "email": email,
        "status": status,
        "role": role,
        "user_level": userLevel,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "last_login_token": lastLoginToken,
        "created_date": createdDate,
        "phone": phone,
        "delete_code": deleteCode,
      };
}

class Oauth {
  Oauth({
    required this.accessToken,
  });

  final String? accessToken;

  factory Oauth.fromJson(Map<String, dynamic> json) => Oauth(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}

class Meta {
  Meta({
    required this.success,
    required this.code,
  });

  final bool? success;
  final int? code;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
      };
}
