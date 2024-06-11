// To parse this JSON data, do
//
//     final currentIp = currentIpFromJson(jsonString);

import 'dart:convert';

CurrentIp currentIpFromJson(String str) => CurrentIp.fromJson(json.decode(str));

String currentIpToJson(CurrentIp data) => json.encode(data.toJson());

class CurrentIp {
    final String? ip;

    CurrentIp({
        this.ip,
    });

    factory CurrentIp.fromJson(Map<String, dynamic> json) => CurrentIp(
        ip: json["ip"],
    );

    Map<String, dynamic> toJson() => {
        "ip": ip,
    };
}
