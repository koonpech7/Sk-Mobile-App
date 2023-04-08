import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:testflutter/MQTTClientManager.dart';

import 'package:quickalert/quickalert.dart';

import 'package:testflutter/components/appbar.dart';
import 'package:testflutter/components/components.dart';
import 'package:testflutter/models/models.dart';
import 'package:testflutter/screens/screens.dart';

import 'package:http/http.dart' as http;

class GetSingleRoom extends StatefulWidget {
  const GetSingleRoom({super.key, required this.index});

  final int index;

  @override
  State<GetSingleRoom> createState() => _GetSingleRoomState();
}

class _GetSingleRoomState extends State<GetSingleRoom> {
  MQTTClientManager mqttClientManager = MQTTClientManager();

  String doorTopic = "";

  bool roomst = true;
  bool doorstatus = true;
  bool lamp1status = true;
  bool lamp2status = true;
  bool lamp3status = true;
  bool lamp4status = true;
  bool lamp5status = true;
  bool lamp6status = true;
  bool airstatus = true;

  late RoomsgetSingle roomsingle;

  bool isLoading = false;
  // error msg?
  String errorMsg = "";

  Future<RoomsgetSingle> getDataFromApi() async {
    Uri url = Uri.parse('http://202.44.35.76:9091/api/rooms/${widget.index}');

    var response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      //ok
      RoomsgetSingle roomSingel = roomsgetSingleFromJson(response.body);
      return roomSingel;
    } else {
      errorMsg = "${response.statusCode}: ${response.body}";
      return RoomsgetSingle(
          active: false,
          camUrl: "",
          id: 1,
          label: "",
          mqttTopicAir: "",
          mqttTopicDoor: "",
          mqttTopicLamp1: "",
          mqttTopicLamp2: "",
          mqttTopicLamp3: "",
          mqttTopicLamp4: "",
          mqttTopicLamp5: "",
          mqttTopicLamp6: "",
          status: "",
          uuidCam: "");
    }
  }

  assignData() async {
    roomsingle = await getDataFromApi();
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // cal api
    assignData();
    setupMqttClient();
    setupUpdatesListener();
    super.initState();
  }

  Future getError(String title, String subtext) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: title,
      text: subtext,
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Room ",
        subtitle: "Select you feture",
        onPressed: () {
          Navigator.pop(context);
        },
        havetactions: false,
      ),
      body: !isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMsg.isNotEmpty
              ? const Center(
                  child: Text(
                  "error",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 255, 17, 0),
                      fontWeight: FontWeight.bold),
                ))
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: height / 10,
                        width: width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 27, 27, 39),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Room " "${roomsingle.label}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                      "Status : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      doorstatus ? "Close" : "Open",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: doorstatus
                                            ? const Color(0xFFFF0505)
                                            : const Color(0xFF05FF3C),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicDoor,
                          name: "Door",
                          status: doorstatus,
                          onPressd: () {
                            setState(() {
                              doorstatus = !doorstatus;
                              if (doorstatus) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicDoor, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp1, "on");
                              }
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicAir,
                          name: "Air conditioner",
                          status: airstatus,
                          onPressd: () {
                            setState(() {
                              airstatus = !airstatus;
                              if (airstatus) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicAir, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicAir, "on");
                              }
                            });
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                        topic: roomsingle.mqttTopicLamp1,
                        name: "Lamp 1",
                        status: lamp1status,
                        onPressd: () {
                          setState(() {
                            lamp1status = !lamp1status;
                            if (lamp1status) {
                              mqttClientManager.publishMessage(
                                  roomsingle.mqttTopicLamp1, "off");
                            } else {
                              mqttClientManager.publishMessage(
                                  roomsingle.mqttTopicLamp1, "on");
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp2,
                          name: "Lamp 2",
                          status: lamp2status,
                          onPressd: () {
                            setState(() {
                              lamp2status = !lamp2status;
                              if (lamp2status) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp2, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp2, "on");
                              }
                            });
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp3,
                          name: "Lamp 3",
                          status: lamp3status,
                          onPressd: () {
                            setState(() {
                              lamp3status = !lamp3status;
                              if (lamp3status) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp3, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp3, "on");
                              }
                            });
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp4,
                          name: "Lamp 4",
                          status: lamp4status,
                          onPressd: () {
                            setState(() {
                              lamp4status = !lamp4status;
                              if (lamp4status) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp4, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp4, "on");
                              }
                            });
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp5,
                          name: "Lamp 5",
                          status: lamp5status,
                          onPressd: () {
                            setState(() {
                              lamp5status = !lamp5status;
                              if (lamp5status) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp5, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp5, "on");
                              }
                            });
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp6,
                          name: "Lamp 6",
                          status: lamp6status,
                          onPressd: () {
                            setState(() {
                              lamp6status = !lamp6status;
                              if (lamp6status) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp6, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp6, "on");
                              }
                            });
                          }),
                      const SizedBox(height: 10),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 27, 27, 39),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Camera ",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFF69696F),
                                      radius: 30,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CameraScreens(
                                                          cameraURL:
                                                              roomsingle.camUrl,
                                                          roomNumber: roomsingle
                                                              .label)));
                                        },
                                        icon: const Icon(
                                            FontAwesomeIcons.rightLong),
                                        iconSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ]),
    );
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe("/Update_Switch2");
    mqttClientManager.subscribe("/Update_Switch1");
    mqttClientManager.subscribe("/Update_Switch3");
    mqttClientManager.subscribe("/Update_Switch4");
    mqttClientManager.subscribe("/Update_Switch5");
    mqttClientManager.subscribe("/Update_Switch6");
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final publicMess =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      // print("Logggggggggg" "${c[0].topic}" "${publicMess}");

      if (c[0].topic == "/Update_Switch1" && publicMess == "On") {
        setState(() {
          lamp1status = false;
        });
      } else if (c[0].topic == "/Update_Switch1" && publicMess == "Off") {
        setState(() {
          lamp1status = true;
        });
      } else if (c[0].topic == "/Update_Switch2" && publicMess == "On") {
        setState(() {
          lamp2status = false;
        });
      } else if (c[0].topic == "/Update_Switch2" && publicMess == "Off") {
        setState(() {
          lamp2status = true;
        });
      } else if (c[0].topic == "/Update_Switch3" && publicMess == "On") {
        setState(() {
          lamp3status = false;
        });
      } else if (c[0].topic == "/Update_Switch3" && publicMess == "Off") {
        setState(() {
          lamp3status = true;
        });
      } else if (c[0].topic == "/Update_Switch4" && publicMess == "On") {
        setState(() {
          lamp4status = false;
        });
      } else if (c[0].topic == "/Update_Switch4" && publicMess == "Off") {
        setState(() {
          lamp4status = true;
        });
      } else if (c[0].topic == "/Update_Switch5" && publicMess == "On") {
        setState(() {
          lamp5status = false;
        });
      } else if (c[0].topic == "/Update_Switch5" && publicMess == "Off") {
        setState(() {
          lamp5status = true;
        });
      } else if (c[0].topic == "/Update_Switch6" && publicMess == "On") {
        setState(() {
          lamp6status = false;
        });
      } else if (c[0].topic == "/Update_Switch6" && publicMess == "Off") {
        setState(() {
          lamp6status = true;
        });
      }
    });

    // } else if (c[0].topic == "/Update_Switch2") {
    //   if (publicMess == "on") {
    //     setState(() {
    //       lamp1status = false;
    //     });
    //   } else if (publicMess == "Off") {
    //     setState(() {
    //       lamp2status = true;
    //     });
    //   }
    // }
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }
}
