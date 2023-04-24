import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testflutter/components/appbar.dart';
import 'package:testflutter/models/models.dart';

// package lib
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:testflutter/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateRooms extends StatefulWidget {
  const UpdateRooms({
    super.key,
    required this.index,
    required this.roomsname,
  });

  final int index;
  final String roomsname;

  @override
  State<UpdateRooms> createState() => _UpdateRoomsState();
}

TextEditingController roomName = TextEditingController();
TextEditingController doorTopic = TextEditingController();
TextEditingController airTopic = TextEditingController();
TextEditingController lamp1Topic = TextEditingController();
TextEditingController lamp2Topic = TextEditingController();
TextEditingController lamp3Topic = TextEditingController();
TextEditingController lamp4Topic = TextEditingController();
TextEditingController lamp5Topic = TextEditingController();
TextEditingController lamp6Topic = TextEditingController();
TextEditingController camUrl = TextEditingController();

class _UpdateRoomsState extends State<UpdateRooms> {
  late RoomsgetSingle roomdetail;

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
    roomdetail = await getDataFromApi();
    setState(() {
      isLoading = true;
      ConvertdatatoTextfiled();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // cal api
    assignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Edit Rooms ${widget.roomsname}",
        subtitle: "You can modify or edit topic",
        onPressed: () {
          Navigator.pop(context);
        },
        haveleading: true,
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
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 27, 27, 39),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Input you MQTT Topic and Camera Url",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                              controller: roomName,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Roomname",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: doorTopic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Door Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: airTopic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Air Conditioner Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: lamp1Topic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Lamp 1 Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: lamp2Topic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Lamp 2 Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: lamp3Topic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Lamp 3 Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: lamp4Topic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Lamp 4 Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: lamp5Topic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Lamp 5 Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: lamp6Topic,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                labelText: "Lamp 6 Topic",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          TextField(
                              controller: camUrl,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255), //<-- SEE HERE
                                ),
                                hintText:
                                    "rtsp://202.44.35.76:5541/c319f57f-6db1-4ada-9ca4-f0fdb38c13f2/0",
                                labelText: "Camera Url",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            height: height / 12,
                            width: width,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 1.0, color: Colors.white),
                                ),
                                onPressed: summitupdateData,
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  ConvertdatatoTextfiled() {
    roomName.text = roomdetail.label;
    doorTopic.text = roomdetail.mqttTopicDoor;
    airTopic.text = roomdetail.mqttTopicAir;
    lamp1Topic.text = roomdetail.mqttTopicLamp1;
    lamp2Topic.text = roomdetail.mqttTopicLamp2;
    lamp3Topic.text = roomdetail.mqttTopicLamp3;
    lamp4Topic.text = roomdetail.mqttTopicLamp4;
    lamp5Topic.text = roomdetail.mqttTopicLamp5;
    lamp6Topic.text = roomdetail.mqttTopicLamp6;
    camUrl.text = roomdetail.camUrl;
  }

  ClearTextfield() {
    roomName.clear();
    doorTopic.clear();
    airTopic.clear();
    lamp1Topic.clear();
    lamp2Topic.clear();
    lamp3Topic.clear();
    lamp4Topic.clear();
    lamp5Topic.clear();
    lamp6Topic.clear();
    camUrl.clear();
  }

  Future<void> summitupdateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');
    if (roomName.text.isEmpty || camUrl.text.isEmpty) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Please Input Roomname and Cam Url',
      );
    }

    final roomname = roomName.text;
    final doortopic = doorTopic.text;
    final airtopic = airTopic.text;
    final lamp1topic = lamp1Topic.text;
    final lamp2topic = lamp2Topic.text;
    final lamp3topic = lamp3Topic.text;
    final lamp4topic = lamp4Topic.text;
    final lamp5topic = lamp5Topic.text;
    final lamp6topic = lamp6Topic.text;
    final camurl = camUrl.text;

    final body = {
      "label": roomname,
      "mqtt_topic_door": doortopic,
      "mqtt_topic_air": airtopic,
      "mqtt_topic_lamp_1": lamp1topic,
      "mqtt_topic_lamp_2": lamp2topic,
      "mqtt_topic_lamp_3": lamp3topic,
      "mqtt_topic_lamp_4": lamp4topic,
      "mqtt_topic_lamp_5": lamp5topic,
      "mqtt_topic_lamp_6": lamp6topic,
      "cam_url": camurl,
    };

    // call api post method
    Uri url = Uri.parse(
        "http://202.44.35.76:9091/api/dashboard/rooms/edit/${widget.index}");
    var response = await http
        .put(url, body: jsonEncode(body), headers: {'X-Token': '$token'});

    ClearTextfield();

    // if success
    if (response.statusCode == 200) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'You room update success',
      );
    } else {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Please check you server',
      );
    }
  }
}
