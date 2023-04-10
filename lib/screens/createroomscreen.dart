import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// package component
import 'package:testflutter/components/appbar.dart';

// package lib
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class CreateRooms extends StatefulWidget {
  const CreateRooms({super.key});

  @override
  State<CreateRooms> createState() => _CreateRoomsState();
}

class _CreateRoomsState extends State<CreateRooms> {
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Create You Rooms",
        subtitle: "Create rooms with you topic",
        onPressed: () {
          Navigator.pop(context);
        },
        haveleading: false,
        havetactions: false,
      ),
      body: Padding(
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
                      labelText: "Room Name",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Door Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Air Conditioner Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Lamp 1 Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Lamp 2  Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Lamp 3 Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Lamp 4 Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Lamp 5 Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      labelText: "Lamp 6 Topic",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                      hintText:
                          "rtsp://202.44.35.76:5541/c319f57f-6db1-4ada-9ca4-f0fdb38c13f2/0",
                      labelText: "Camera Url",
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                      ),
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
                        side: const BorderSide(width: 1.0, color: Colors.white),
                      ),
                      onPressed: summitData,
                      child: const Text(
                        "Create",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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

  Future<void> summitData() async {
    if (roomName.text.isEmpty || camUrl.text.isEmpty) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Please Input Roomname and Cam Url',
      );
    }

    // set data for api body
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
    Uri url = Uri.parse("http://202.44.35.76:9091/api/rooms/new");
    var response = await http.post(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // if success
    if (response.statusCode == 200) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'You room create success',
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
