import 'package:flutter/cupertino.dart';

class Appointment {
  final data;
  final time;
  final expertId;
  final userId;
  final totalprice;
  final id;

  Appointment(
      {@required this.data,
      @required this.time,
      @required this.expertId,
      @required this.userId,
      @required this.totalprice,
      @required this.id});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      data: json['data'],
      time: json['time'],
      expertId: json['expertId'],
      userId: json['userId'],
      id: json['id'],
      totalprice: json['totalprice'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['time'] = this.time;
    data['expert_id'] = this.expertId;
    data['user_id'] = this.userId;
    data['totalprice'] = this.totalprice;
    data['id'] = this.id;
    return data;
  }
}
