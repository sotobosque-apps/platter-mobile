// To parse this JSON data, do
//
//     final jwtToken = jwtTokenFromJson(jsonString);

import 'dart:convert';

Jwt jwtTokenFromJson(String str) => Jwt.fromJson(json.decode(str));

String jwtTokenToJson(Jwt data) => json.encode(data.toJson());

class Jwt {
    final String? jwt;
    final User? user;

    Jwt({
        this.jwt,
        this.user,
    });

    factory Jwt.fromJson(Map<String, dynamic> json) => Jwt(
        jwt: json["jwt"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "user": user?.toJson(),
    };
}

class User {
    final int? id;
    final String? username;
    final String? email;
    final String? provider;
    final bool? confirmed;
    final bool? blocked;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    User({
        this.id,
        this.username,
        this.email,
        this.provider,
        this.confirmed,
        this.blocked,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
