import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// import api
import 'package:testflutter/models/models.dart';
import 'package:http/http.dart' as http;

//import alert
import 'package:quickalert/quickalert.dart';

class MQTTClientManager {
  MqttServerClient client =
      MqttServerClient.withPort('202.44.35.76', "SKAPP", 1883);

  // late SettingMqttServer settingMQTT;
  // // isLoading ?
  // bool isLoading = false;
  // // error msg?
  // String errorMsg = "";

  // Future<SettingMqttServer> getDataFromApi() async {
  //   Uri url = Uri.parse("http://202.44.35.76:9091/api/settings/");
  //   var response = await http.get(url);

  //   if (response.statusCode == HttpStatus.ok) {
  //     //ok
  //     SettingMqttServer setMQTT = settingMqttServerFromJson(response.body);
  //     return setMQTT;
  //   } else {
  //     errorMsg = "${response.statusCode}: ${response.body}";
  //     return SettingMqttServer(
  //         active: false,
  //         cronjobTime: "",
  //         id: 0,
  //         modelData: "",
  //         mqttClientName: "",
  //         mqttIp: "",
  //         mqttPassword: "",
  //         mqttPort: "",
  //         mqttUsername: "",
  //         notifyAccessToken: "",
  //         updateAt: DateTime.now());
  //   }
  // }

  // assignData() async {
  //   try {
  //     settingMQTT = await getDataFromApi();
  //   } on Exception catch (e) {
  //     // TODO
  //     print("error");
  //   }
  // }

  // void initState() {
  //   // TODO: implement initState
  //   // cal api
  //   assignData();
  // }

  Future<int> connect() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .authenticateAs("sclass", "class44702");
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('MQTTClient::Client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('MQTTClient::Socket exception - $e');
      client.disconnect();
    }

    return 0;
  }

  void disconnect() {
    client.disconnect();
    print("Disconnectttttttttttttttt");
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onConnected() {
    print('MQTTClient::Connected');
    print("Connected");
  }

  Text onDisconnected() {
    print("Disconnect");
    print('MQTTClient::Disconnected');
    return const Text("Disconnect");
  }

  void onSubscribed(String topic) {
    print('MQTTClient::Subscribed to topic: $topic');
  }

  void pong() {
    print('MQTTClient::Ping response received');
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);

    // TODO
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return client.updates;
  }
}
