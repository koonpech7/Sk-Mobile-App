// To parse this JSON data, do
//
//     final allRoomsModels = allRoomsModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllRoomsModels allRoomsModelsFromJson(String str) =>
    AllRoomsModels.fromJson(json.decode(str));

String allRoomsModelsToJson(AllRoomsModels data) => json.encode(data.toJson());

class AllRoomsModels {
  AllRoomsModels({
    required this.item,
    required this.page,
    required this.totalCount,
    required this.totalPages,
  });

  final List<Items> item;
  final int page;
  final int totalCount;
  final int totalPages;

  factory AllRoomsModels.fromJson(Map<String, dynamic> json) => AllRoomsModels(
        item: List<Items>.from(json["items"].map((x) => Items.fromJson(x))),
        page: json["page"],
        totalCount: json["total_count"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(item.map((x) => x.toJson())),
        "page": page,
        "total_count": totalCount,
        "total_pages": totalPages,
      };
}

class Items {
  Items({
    required this.id,
    required this.label,
    required this.camUrl,
    required this.uuidCam,
    required this.status,
    required this.active,
    required this.mqttTopicLamp1,
    required this.mqttTopicLamp2,
    required this.mqttTopicLamp3,
    required this.mqttTopicLamp4,
    required this.mqttTopicLamp5,
    required this.mqttTopicLamp6,
    required this.mqttTopicDoor,
    required this.mqttTopicAir,
  });

  final int id;
  final String label;
  final String camUrl;
  final String uuidCam;
  final String status;
  final bool active;
  final String mqttTopicLamp1;
  final String mqttTopicLamp2;
  final String mqttTopicLamp3;
  final String mqttTopicLamp4;
  final String mqttTopicLamp5;
  final String mqttTopicLamp6;
  final String mqttTopicDoor;
  final String mqttTopicAir;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        label: json["label"],
        camUrl: json["cam_url"],
        uuidCam: json["uuid_cam"],
        status: json["status"],
        active: json["active"],
        mqttTopicLamp1: json["mqtt_topic_lamp_1"],
        mqttTopicLamp2: json["mqtt_topic_lamp_2"],
        mqttTopicLamp3: json["mqtt_topic_lamp_3"],
        mqttTopicLamp4: json["mqtt_topic_lamp_4"],
        mqttTopicLamp5: json["mqtt_topic_lamp_5"],
        mqttTopicLamp6: json["mqtt_topic_lamp_6"],
        mqttTopicDoor: json["mqtt_topic_door"],
        mqttTopicAir: json["mqtt_topic_air"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "cam_url": camUrl,
        "uuid_cam": uuidCam,
        "status": status,
        "active": active,
        "mqtt_topic_lamp_1": mqttTopicLamp1,
        "mqtt_topic_lamp_2": mqttTopicLamp2,
        "mqtt_topic_lamp_3": mqttTopicLamp3,
        "mqtt_topic_lamp_4": mqttTopicLamp4,
        "mqtt_topic_lamp_5": mqttTopicLamp5,
        "mqtt_topic_lamp_6": mqttTopicLamp6,
        "mqtt_topic_door": mqttTopicDoor,
        "mqtt_topic_air": mqttTopicAir,
      };
}
