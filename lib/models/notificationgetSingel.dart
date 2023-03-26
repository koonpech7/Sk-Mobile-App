// To parse this JSON data, do
//
//     final notificationgetSingle = notificationgetSingleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationgetSingle notificationgetSingleFromJson(String str) =>
    NotificationgetSingle.fromJson(json.decode(str));

String notificationgetSingleToJson(NotificationgetSingle data) =>
    json.encode(data.toJson());

class NotificationgetSingle {
  NotificationgetSingle({
    required this.accurency,
    required this.airStatus,
    required this.comOnCount,
    required this.doorStatus,
    required this.id,
    required this.image,
    required this.lamp1Status,
    required this.lamp2Status,
    required this.lamp3Status,
    required this.lamp4Status,
    required this.lamp5Status,
    required this.lamp6Status,
    required this.personCount,
    required this.reportDate,
    required this.reportTime,
    required this.roomLabel,
    required this.status,
    required this.updateAt,
  });

  final String accurency;
  final String airStatus;
  final int comOnCount;
  final String doorStatus;
  final int id;
  final String image;
  final String lamp1Status;
  final String lamp2Status;
  final String lamp3Status;
  final String lamp4Status;
  final String lamp5Status;
  final String lamp6Status;
  final int personCount;
  final String reportDate;
  final String reportTime;
  final String roomLabel;
  final String status;
  final DateTime updateAt;

  factory NotificationgetSingle.fromJson(Map<String, dynamic> json) =>
      NotificationgetSingle(
        accurency: json["accurency"],
        airStatus: json["air_status"],
        comOnCount: json["com_on_count"],
        doorStatus: json["door_status"],
        id: json["id"],
        image: json["image"],
        lamp1Status: json["lamp_1_status"],
        lamp2Status: json["lamp_2_status"],
        lamp3Status: json["lamp_3_status"],
        lamp4Status: json["lamp_4_status"],
        lamp5Status: json["lamp_5_status"],
        lamp6Status: json["lamp_6_status"],
        personCount: json["person_count"],
        reportDate: json["report_date"],
        reportTime: json["report_time"],
        roomLabel: json["room_label"],
        status: json["status"],
        updateAt: DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "accurency": accurency,
        "air_status": airStatus,
        "com_on_count": comOnCount,
        "door_status": doorStatus,
        "id": id,
        "image": image,
        "lamp_1_status": lamp1Status,
        "lamp_2_status": lamp2Status,
        "lamp_3_status": lamp3Status,
        "lamp_4_status": lamp4Status,
        "lamp_5_status": lamp5Status,
        "lamp_6_status": lamp6Status,
        "person_count": personCount,
        "report_date": reportDate,
        "report_time": reportTime,
        "room_label": roomLabel,
        "status": status,
        "update_at": updateAt.toIso8601String(),
      };
}
