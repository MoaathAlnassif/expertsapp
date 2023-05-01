import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String email;
  final String role;
  final int id;
  final String token;


  User({
    @required this.name,
    @required this.email,
    @required this.role,
    @required this.id,
    @required this.token,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['data']['name'],
      email: json['data']['email'],
      role: json['data']['role'],
      id: json['data']['id'],
      token: json['token'],


    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}
