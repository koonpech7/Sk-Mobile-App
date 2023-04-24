import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:testflutter/MQTTClientManager.dart';
import 'package:intl/intl.dart';

import 'package:quickalert/quickalert.dart';

import 'package:testflutter/components/appbar.dart';
import 'package:testflutter/components/components.dart';
import 'package:testflutter/models/models.dart';
import 'package:testflutter/screens/screens.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class GetSingleRoom extends StatefulWidget {
  const GetSingleRoom({super.key, required this.index});

  final int index;

  @override
  State<GetSingleRoom> createState() => _GetSingleRoomState();
}

class _GetSingleRoomState extends State<GetSingleRoom> {
  MQTTClientManager mqttClientManager = MQTTClientManager();

// date and timestemp
  String cdate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String tdata = DateFormat("HH:mm:ss").format(DateTime.now());

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');
    Uri url = Uri.parse(
        'http://202.44.35.76:9091/api/dashboard/rooms/${widget.index}');

    var response = await http.get(url, headers: {'X-Token': '$token'});

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
                                SizedBox(
                                  width: width / 1.7,
                                  child: Text(
                                    roomsingle.label,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topRight,
                                      height: height / 24,
                                      width: width / 5,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                width: 1.0,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateRooms(
                                                            roomsname:
                                                                roomsingle
                                                                    .label,
                                                            index: roomsingle
                                                                .id)));
                                          },
                                          child: const Text(
                                            "Edit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )),
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
                            try {
                              setState(() {
                                doorstatus = !doorstatus;
                                if (doorstatus) {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicDoor, "off");
                                } else {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicDoor, "on");
                                }
                                sendDataLog();
                              });
                            } on Exception catch (e) {
                              // TODO
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Check you topic or MQTT Server',
                              );
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicAir,
                          name: "Air conditioner",
                          status: airstatus,
                          onPressd: () {
                            try {
                              setState(() {
                                airstatus = !airstatus;
                                if (airstatus) {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicAir, "off");
                                } else {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicAir, "on");
                                }
                                sendDataLog();
                              });
                            } on Exception catch (e) {
                              // TODO
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Check you topic or MQTT Server',
                              );
                            }
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                        topic: roomsingle.mqttTopicLamp1,
                        name: "Lamp 1",
                        status: lamp1status,
                        onPressd: () {
                          try {
                            setState(() {
                              lamp1status = !lamp1status;
                              if (lamp1status) {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp1, "off");
                              } else {
                                mqttClientManager.publishMessage(
                                    roomsingle.mqttTopicLamp1, "on");
                              }
                              sendDataLog();
                            });
                          } on Exception catch (e) {
                            // TODO
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...',
                              text: 'Check you topic or MQTT Server',
                            );
                          }
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
                            try {
                              setState(() {
                                lamp2status = !lamp2status;
                                if (lamp2status) {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp2, "off");
                                } else {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp2, "on");
                                }
                                sendDataLog();
                              });
                            } on Exception catch (e) {
                              // TODO
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Check you topic or MQTT Server',
                              );
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp3,
                          name: "Lamp 3",
                          status: lamp3status,
                          onPressd: () {
                            try {
                              setState(() {
                                lamp3status = !lamp3status;
                                if (lamp3status) {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp3, "off");
                                } else {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp3, "on");
                                }
                                sendDataLog();
                              });
                            } on Exception catch (e) {
                              // TODO
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Check you topic or MQTT Server',
                              );
                            }
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp4,
                          name: "Lamp 4",
                          status: lamp4status,
                          onPressd: () {
                            try {
                              setState(() {
                                lamp4status = !lamp4status;
                                if (lamp4status) {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp4, "off");
                                } else {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp4, "on");
                                }
                                sendDataLog();
                              });
                            } on Exception catch (e) {
                              // TODO
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Check you topic or MQTT Server',
                              );
                            }
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp5,
                          name: "Lamp 5",
                          status: lamp5status,
                          onPressd: () {
                            try {
                              setState(() {
                                lamp5status = !lamp5status;
                                if (lamp5status) {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp5, "off");
                                } else {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp5, "on");
                                }
                                sendDataLog();
                              });
                            } on Exception catch (e) {
                              // TODO
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Check you topic or MQTT Server',
                              );
                            }
                          }),
                      const SizedBox(height: 10),
                      SKRoomcard(
                          topic: roomsingle.mqttTopicLamp6,
                          name: "Lamp 6",
                          status: lamp6status,
                          onPressd: () {
                            try {
                              setState(() {
                                lamp6status = !lamp6status;
                                if (lamp6status) {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp6, "off");
                                } else {
                                  mqttClientManager.publishMessage(
                                      roomsingle.mqttTopicLamp6, "on");
                                }
                                sendDataLog();
                              });
                            } on Exception catch (e) {
                              // TODO
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Check you topic or MQTT Server',
                              );
                            }
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
                                const Text(
                                  "Camera ",
                                  style: TextStyle(
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

  Future<void> sendDataLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');

    // set data for api body

    final body = {
      "room_label": roomsingle.label,
      "report_time": "$tdata",
      "report_date": "$cdate",
      "status": "Application",
      "lamp_1_status": "$lamp1status",
      "lamp_2_status": "$lamp2status",
      "lamp_3_status": "$lamp3status",
      "lamp_4_status": "$lamp4status",
      "lamp_5_status": "$lamp5status",
      "lamp_6_status": "$lamp6status",
      "door_status": "$doorstatus",
      "air_status": "$airstatus"
    };

    // call api post method
    Uri url = Uri.parse("http://202.44.35.76:9091/api/dashboard/reports/new");
    var response = await http
        .post(url, body: jsonEncode(body), headers: {'X-Token': '$token'});

    // if success
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe("/Update_Door44-702");
    mqttClientManager.subscribe("/Update_Switch1");
    mqttClientManager.subscribe("/Update_Switch2");
    mqttClientManager.subscribe("/Update_Switch3");
    mqttClientManager.subscribe("/Update_Switch4");
    mqttClientManager.subscribe("/Update_Switch5");
    mqttClientManager.subscribe("/Update_Switch6");
    mqttClientManager.subscribe("/Update_Temp");
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
      } else if (c[0].topic == "/Update_Door44-702" && publicMess == "Unlock") {
        setState(() {
          doorstatus = false;
        });
      } else if (c[0].topic == "/Update_Door44-702" && publicMess == "lock") {
        setState(() {
          doorstatus = true;
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
