// To parse this JSON data, do
//
//     final roomsgetSingle = roomsgetSingleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RoomsgetSingle roomsgetSingleFromJson(String str) =>
    RoomsgetSingle.fromJson(json.decode(str));

String roomsgetSingleToJson(RoomsgetSingle data) => json.encode(data.toJson());

class RoomsgetSingle {
  RoomsgetSingle({
    required this.active,
    required this.camUrl,
    required this.id,
    required this.label,
    required this.mqttTopicAir,
    required this.mqttTopicDoor,
    required this.mqttTopicLamp1,
    required this.mqttTopicLamp2,
    required this.mqttTopicLamp3,
    required this.mqttTopicLamp4,
    required this.mqttTopicLamp5,
    required this.mqttTopicLamp6,
    required this.status,
    required this.uuidCam,
  });

  final bool active;
  final String camUrl;
  final int id;
  final String label;
  final String mqttTopicAir;
  final String mqttTopicDoor;
  final String mqttTopicLamp1;
  final String mqttTopicLamp2;
  final String mqttTopicLamp3;
  final String mqttTopicLamp4;
  final String mqttTopicLamp5;
  final String mqttTopicLamp6;
  final String status;
  final String uuidCam;

  factory RoomsgetSingle.fromJson(Map<String, dynamic> json) => RoomsgetSingle(
        active: json["active"],
        camUrl: json["cam_url"],
        id: json["id"],
        label: json["label"],
        mqttTopicAir: json["mqtt_topic_air"],
        mqttTopicDoor: json["mqtt_topic_door"],
        mqttTopicLamp1: json["mqtt_topic_lamp_1"],
        mqttTopicLamp2: json["mqtt_topic_lamp_2"],
        mqttTopicLamp3: json["mqtt_topic_lamp_3"],
        mqttTopicLamp4: json["mqtt_topic_lamp_4"],
        mqttTopicLamp5: json["mqtt_topic_lamp_5"],
        mqttTopicLamp6: json["mqtt_topic_lamp_6"],
        status: json["status"],
        uuidCam: json["uuid_cam"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "cam_url": camUrl,
        "id": id,
        "label": label,
        "mqtt_topic_air": mqttTopicAir,
        "mqtt_topic_door": mqttTopicDoor,
        "mqtt_topic_lamp_1": mqttTopicLamp1,
        "mqtt_topic_lamp_2": mqttTopicLamp2,
        "mqtt_topic_lamp_3": mqttTopicLamp3,
        "mqtt_topic_lamp_4": mqttTopicLamp4,
        "mqtt_topic_lamp_5": mqttTopicLamp5,
        "mqtt_topic_lamp_6": mqttTopicLamp6,
        "status": status,
        "uuid_cam": uuidCam,
      };
}
