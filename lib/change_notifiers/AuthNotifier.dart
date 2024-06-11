import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:platter/sources/FatsecretProvider.dart';
import 'package:platter/models/Jwt.dart';

class AuthSelector {
  final String identifier;
  final String password;
  final String email;

  const AuthSelector(this.identifier, this.password, this.email);

  String toAuthJson() =>
      '{"identifier": "$identifier","password": "$password"}';
  String toRegisterJson() =>
      '{"username": "$identifier","password": "$password","email": "$email"}';
}

class AuthNotifier extends ChangeNotifier {
  Jwt? _token;
  late final HttpClient client;
  late final DateTime closeDateTime;

  String? get userId => _token?.user?.id.toString();

  AuthNotifier() {
    client = HttpClient();
  }

  void headers(HttpClientRequest request, {body = ''}) {
    // Optionally set up headers...
    // Optionally write to the request object...
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    // request.headers.set(HttpHeaders.authorizationHeader, "Bearer Key");
    request.write(body);
    // request.
  }

  // Future<int> emailOTPAuthentication(
  //     String emailAddress, String password) async {
  //   try {
  //     HttpClientRequest request = await client.post(
  //         'https://6efd-186-120-37-14.ngrok-free.app',
  //         80,
  //         "/users/?format=json");
  //     headers(request);
  //     HttpClientResponse response = await request.close();
  //     final stringData = await response.transform(utf8.decoder).join();

  //     if (kDebugMode) {
  //       print(stringData);
  //     }
  //   } finally {
  //     // client.close();
  //   }

  //   return -1;
  // }

  Future<bool> isEmailAuthentic() async {
    return false;
  }

// $mainDomain/api/auth/local/register
  Future<bool> newSession(AuthSelector credential) async {
    try {
      HttpClientRequest request =
          await client.postUrl(Uri.parse('$mainDomain/api/auth/local/'));
      headers(request, body: credential.toAuthJson());
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();

      print(stringData);

      _token = Jwt.fromJson(jsonDecode(stringData) as Map<String, dynamic>);

      if (_token!.jwt?.isNotEmpty != null) {
        return true;
      }
    } finally {
      // client.close();
    }
    return false;
  }

  Future<bool> newRegistration(AuthSelector credential) async {
    try {
      HttpClientRequest request = await client
          .postUrl(Uri.parse('$mainDomain/api/auth/local/register'));
      headers(request, body: credential.toRegisterJson());
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();

      print(stringData);

      _token = Jwt.fromJson(jsonDecode(stringData) as Map<String, dynamic>);

      if (_token!.jwt?.isNotEmpty != null) {
        return true;
      }
    } finally {
      // client.close();
    }
    return false;
  }

  Future<bool> checkOTP({String token = "", String email = ""}) async {
    HttpClientRequest request = await client.getUrl(Uri.parse(
        "$mainDomain/api/platterauth/platterConfirmValidation/?email=$email&token=$token"));

    HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();

    print(stringData);

    Map<String, dynamic> jsonobject = jsonDecode(stringData);

    return jsonobject["Valid"] == true;
  }

  Future<bool> closeSession() async {
    try {
      HttpClientRequest request = await client.post(
          'https://6efd-186-120-37-14.ngrok-free.app',
          80,
          "/sessions/?format=json");
      headers(request, body: '{"session": {"user_id": 1}}');
      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();

      if (kDebugMode) {
        print(stringData);
      }
    } finally {
      // client.close();
    }
    return false;
  }

  bool isValid(bool isValid) {
    return false;
  }
}
