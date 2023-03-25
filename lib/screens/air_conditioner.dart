import 'package:flutter/material.dart';
import 'package:testflutter/components/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:testflutter/MQTTClientManager.dart';

class AirConditioner extends StatefulWidget {
  const AirConditioner({super.key});

  @override
  State<AirConditioner> createState() => _AirConditionerState();
}

class _AirConditionerState extends State<AirConditioner> {
  MQTTClientManager mqttClientManager = MQTTClientManager();

  final String AirTopic = "/Air";

  final String subAirTopic = "/Update_Air";

  bool _airstatus = true;

  String? item = "25";

  String valueItem = "";
  // final _listItems = ["18", "19", "20", "21", "22", "23"];

  List items = [
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupMqttClient();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Air Conditioner 702",
        subtitle: "Select You Temperature",
        onPressed: () {
          Navigator.pop(context);
        },
        havetactions: false,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              borderRadius: BorderRadius.circular(20),
              dropdownColor: Colors.black,
              value: item,
              items: items.map((value) {
                return DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  item = value.toString();
                });
              },
            ),
            SizedBox(
              width: width / 15,
            ),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.check),
              color: _airstatus ? Colors.red : Colors.green,
              iconSize: 50,
              onPressed: () {
                setState(() {
                  valueItem = item.toString();
                  _airstatus = true;
                  mqttClientManager.publishMessage(AirTopic, valueItem);
                });
              },
            ),
            SizedBox(
              width: width / 15,
            ),
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.x),
              color: _airstatus ? Colors.green : Colors.red,
              iconSize: 50,
              onPressed: () {
                setState(() {
                  _airstatus = false;
                  mqttClientManager.publishMessage(AirTopic, "off");
                });
              },
            ),
            // Text(
            //   valueItem,
            //   style: TextStyle(color: Colors.white),
            // )
          ],
        ),
      ),
    );
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(subAirTopic);
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final publicMess =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (publicMess == "On") {
        setState(() {
          _airstatus = false;
        });
      } else if (publicMess == "Off") {
        setState(() {
          _airstatus = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mqttClientManager.disconnect();
  }
}
