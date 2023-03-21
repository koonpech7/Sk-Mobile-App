import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:testflutter/MQTTClientManager.dart';
import 'package:testflutter/screens/lightscreen.dart';
import 'package:testflutter/screens/screens.dart';

import '../components/components.dart';
import '../models/models.dart';

class SingleRoom extends StatefulWidget {
  const SingleRoom({
    super.key,
  });

  @override
  State<SingleRoom> createState() => _SingleRoomState();
}

class _SingleRoomState extends State<SingleRoom> {
  MQTTClientManager mqttClientManager = MQTTClientManager();
  final String pubTopic = "/Door44-702";
  final String pubTopic2 = "/Switch1";
  final String pubTopic3 = "/Air";
  final String pubTopic4 = "/Camera44-702";

  final String subTopic = "/Update_Door44-702";

  bool _doorstatus = true;
  bool _lamp = true;
  bool _air = true;
  bool _camera = false;

  @override
  void initState() {
    setupMqttClient();
    // setupUpdatesListener();
    super.initState();
  }

  void _onPressed(index) {
    switch (index) {
      case 1:
        setState(() {
          _doorstatus = !_doorstatus;
          if (_doorstatus) {
            mqttClientManager.publishMessage(pubTopic, "off");
          } else {
            mqttClientManager.publishMessage(pubTopic, "on");
          }
        });
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LightScreens()),
        );
        // setState(() {
        //   _lamp = !_lamp;
        //   if (_lamp) {
        //     mqttClientManager.publishMessage(pubTopic2, "off");
        //   } else {
        //     mqttClientManager.publishMessage(pubTopic2, "on");
        //   }
        // });
        break;

      case 3:
        // setState(() {
        //   _air = !_air;
        //   if (_air) {
        //     mqttClientManager.publishMessage(pubTopic3, "off");
        //   } else {
        //     mqttClientManager.publishMessage(pubTopic3, "on");
        //   }
        // });
        break;

      case 4:
        // setState(() {
        //   _camera = !_camera;
        //   mqttClientManager.publishMessage(
        //   pubTopic, "702 Camera is ${_camera}");
        // });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CameraScreens()),
        );
        break;

      default:
    }

    // print("initStatus status : " + "${room1}");
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    List<ListKey> listKey = [
      ListKey(id: 1, title: "Door", status: _doorstatus),
      ListKey(id: 2, title: "Lamp", status: _lamp),
      ListKey(id: 3, title: "Air", status: _air),
      ListKey(id: 4, title: "Camera", status: _camera)
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Room 702",
        subtitle: "Choice your feature",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: height / 8,
              width: width,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Color(0xFF8EE592),
                        radius: 30,
                        child: Text(
                          '1',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xFF797979),
                        radius: 30,
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 20),
                      CircleAvatar(
                        backgroundColor: Color(0xFF797979),
                        radius: 30,
                        child: Text(
                          '3',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 1.7,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listKey.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onPressed(index + 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        height: height / 7,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          color: const Color(0xFF2F2F42),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              title: Text(
                                "${listKey[index].title}",
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                listKey[index].status! ? "close" : "open",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: listKey[index].status!
                                      ? const Color(0xFFFF0505)
                                      : const Color(0xFF05FF3C),
                                ),
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: const Color(0xFF69696F),
                                radius: 30,
                                child: IconButton(
                                  onPressed: () {
                                    _onPressed(index + 1);
                                  },
                                  icon: listKey[index].status!
                                      ? const Icon(FontAwesomeIcons.lock)
                                      : const Icon(FontAwesomeIcons.unlock),
                                  iconSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(subTopic);
  }

  // void setupUpdatesListener() {
  //   mqttClientManager
  //       .getMessagesStream()!
  //       .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  //     final recMess = c![0].payload as MqttPublishMessage;
  //     final publicMess =
  //         MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //     // print('MQTTClient::Message received on topic: <${c[0].topic}> is $publicMess\n');

  //     if (publicMess == "On") {
  //       setState(() {
  //         _doorstatus = false;
  //       });
  //     } else if (publicMess == "Off") {
  //       setState(() {
  //         _doorstatus = true;
  //       });
  //     }
  //   });
  // }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }
}
