import 'package:flutter/cupertino.dart';

class SearchResult {
  final String name;
  final int id;
  final type;

  SearchResult( {
  @required this.type,
    @required this.name,
    @required this.id,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      name: json['name'],
      id: json['id'],
      type:json['photo']==null?'Consulting':'Expert'
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;

    data['id'] = this.id;

    return data;
  }
}
