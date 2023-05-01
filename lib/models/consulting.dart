import 'package:flutter/cupertino.dart';

class Consulting {
  final String name;
  final int id;

  Consulting({
    @required this.name,
    @required this.id,
  });

  factory Consulting.fromJson(Map<String, dynamic> json) {
    return Consulting(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;

    data['id'] = this.id;

    return data;
  }
}
