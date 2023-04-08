// To parse this JSON data, do
//
//     final settingMqttServer = settingMqttServerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SettingMqttServer settingMqttServerFromJson(String str) =>
    SettingMqttServer.fromJson(json.decode(str));

String settingMqttServerToJson(SettingMqttServer data) =>
    json.encode(data.toJson());

class SettingMqttServer {
  SettingMqttServer({
    required this.active,
    required this.cronjobTime,
    required this.id,
    required this.modelData,
    required this.mqttClientName,
    required this.mqttIp,
    required this.mqttPassword,
    required this.mqttPort,
    required this.mqttUsername,
    required this.notifyAccessToken,
    required this.updateAt,
  });

  final bool active;
  final String cronjobTime;
  final int id;
  final String modelData;
  final String mqttClientName;
  final String mqttIp;
  final String mqttPassword;
  final String mqttPort;
  final String mqttUsername;
  final String notifyAccessToken;
  final DateTime updateAt;

  factory SettingMqttServer.fromJson(Map<String, dynamic> json) =>
      SettingMqttServer(
        active: json["active"],
        cronjobTime: json["cronjob_time"],
        id: json["id"],
        modelData: json["model_data"],
        mqttClientName: json["mqtt_client_name"],
        mqttIp: json["mqtt_ip"],
        mqttPassword: json["mqtt_password"],
        mqttPort: json["mqtt_port"],
        mqttUsername: json["mqtt_username"],
        notifyAccessToken: json["notify_access_token"],
        updateAt: DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "cronjob_time": cronjobTime,
        "id": id,
        "model_data": modelData,
        "mqtt_client_name": mqttClientName,
        "mqtt_ip": mqttIp,
        "mqtt_password": mqttPassword,
        "mqtt_port": mqttPort,
        "mqtt_username": mqttUsername,
        "notify_access_token": notifyAccessToken,
        "update_at": updateAt.toIso8601String(),
      };
}
