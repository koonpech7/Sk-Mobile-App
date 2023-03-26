import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testflutter/components/appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:testflutter/MQTTClientManager.dart';

class LightScreens extends StatefulWidget {
  const LightScreens({super.key});

  @override
  State<LightScreens> createState() => _LightScreensState();
}

class _LightScreensState extends State<LightScreens> {
  bool isChecked = false;

  MQTTClientManager mqttClientManager = MQTTClientManager();

  final String TopicSw1 = "/Switch1";
  final String TopicSw2 = "/Switch2";
  final String TopicSw3 = "/Switch3";
  final String TopicSw4 = "/Switch4";
  final String TopicSw5 = "/Switch5";
  final String TopicSw6 = "/Switch6";

  final String subTopicSw1 = "/Update_Switch1";
  final String subTopicSw2 = "/Update_Switch2";
  final String subTopicSw3 = "/Update_Switch3";
  final String subTopicSw4 = "/Update_Switch4";
  final String subTopicSw5 = "/Update_Switch5";
  final String subTopicSw6 = "/Update_Switch6";

  bool _lampSw1 = true;
  bool _lampSw2 = true;
  bool _lampSw3 = true;
  bool _lampSw4 = true;
  bool _lampSw5 = true;
  bool _lampSw6 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupMqttClient();
    // setupUpdatesListener();
  }

  // ignore: non_constant_identifier_names
  void ChangeCheckboxTrue() {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _lampSw1 = false;
      });
      mqttClientManager.publishMessage(TopicSw1, "on");
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _lampSw2 = false;
      });
      mqttClientManager.publishMessage(TopicSw2, "on");
    });
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _lampSw3 = false;
      });
      mqttClientManager.publishMessage(TopicSw3, "on");
    });
    Timer(const Duration(seconds: 4), () {
      setState(() {
        _lampSw4 = false;
      });
      mqttClientManager.publishMessage(TopicSw4, "on");
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _lampSw5 = false;
      });
      mqttClientManager.publishMessage(TopicSw5, "on");
    });
    Timer(const Duration(seconds: 6), () {
      setState(() {
        _lampSw6 = false;
      });
      mqttClientManager.publishMessage(TopicSw6, "on");
    });
  }

  // ignore: non_constant_identifier_names
  void ChangeCheckboxFalse() async {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _lampSw1 = true;
      });
      mqttClientManager.publishMessage(TopicSw1, "off");
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _lampSw2 = true;
      });
      mqttClientManager.publishMessage(TopicSw2, "off");
    });
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _lampSw3 = true;
      });
      mqttClientManager.publishMessage(TopicSw3, "off");
    });
    Timer(const Duration(seconds: 4), () {
      setState(() {
        _lampSw4 = true;
      });
      mqttClientManager.publishMessage(TopicSw4, "off");
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _lampSw5 = true;
      });
      mqttClientManager.publishMessage(TopicSw5, "off");
    });
    Timer(const Duration(seconds: 6), () {
      setState(() {
        _lampSw6 = true;
      });
      mqttClientManager.publishMessage(TopicSw6, "off");
    });
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Room 702",
        subtitle: "Choice your feature",
        onPressed: () {
          Navigator.pop(context);
        },
        havetactions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              // color: Colors.black,
              height: height / 1.3,
              width: width,
              child: Column(
                children: [
                  SizedBox(height: height / 12),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          "Check All",
                          style: TextStyle(fontSize: 45, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: width / 8),
                      Transform.scale(
                        scale: 2,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.confirm,
                                text: 'Do you want to do this ?',
                                confirmBtnText: 'Yes',
                                cancelBtnText: 'No',
                                confirmBtnColor: Colors.green,
                                onConfirmBtnTap: () {
                                  setState(() {
                                    isChecked = value!;
                                    Navigator.pop(context);
                                    if (isChecked == true) {
                                      try {
                                        ChangeCheckboxTrue();
                                      } catch (e, stacktrace) {
                                        // TODO

                                      }
                                    } else {
                                      ChangeCheckboxFalse();
                                    }
                                  });
                                });
                          },

                          // QuickAlert.show(
                          //   context: context,
                          //   type: QuickAlertType.confirm,
                          //   text: 'Do you want to open all leamp',
                          //   confirmBtnText: 'Yes',
                          //   cancelBtnText: 'No',
                          //   confirmBtnColor: Colors.green,
                          //   onConfirmBtnTap: () {
                          //     isChecked = newBool;
                          //   },
                          // );
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 8,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _lampSw1 = !_lampSw1;
                            if (_lampSw1) {
                              mqttClientManager.publishMessage(TopicSw1, "off");
                            } else {
                              mqttClientManager.publishMessage(TopicSw1, "on");
                            }
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: _lampSw1 ? Colors.red : Colors.green,
                        iconSize: 50,
                        // iconSize: 30,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 1 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _lampSw2 = !_lampSw2;
                            if (_lampSw2) {
                              mqttClientManager.publishMessage(TopicSw2, "off");
                            } else {
                              mqttClientManager.publishMessage(TopicSw2, "on");
                            }
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: _lampSw2 ? Colors.red : Colors.green,
                        iconSize: 50,
                        // iconSize: 30,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 2 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _lampSw3 = !_lampSw3;
                            if (_lampSw3) {
                              mqttClientManager.publishMessage(TopicSw3, "off");
                            } else {
                              mqttClientManager.publishMessage(TopicSw3, "on");
                            }
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: _lampSw3 ? Colors.red : Colors.green,
                        iconSize: 50,
                        // iconSize: 30,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 3 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _lampSw4 = !_lampSw4;
                            if (_lampSw4) {
                              mqttClientManager.publishMessage(TopicSw4, "off");
                            } else {
                              mqttClientManager.publishMessage(TopicSw4, "on");
                            }
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: _lampSw4 ? Colors.red : Colors.green,
                        iconSize: 50,
                        // iconSize: 30,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 4 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _lampSw5 = !_lampSw5;
                            if (_lampSw5) {
                              mqttClientManager.publishMessage(TopicSw5, "off");
                            } else {
                              mqttClientManager.publishMessage(TopicSw5, "on");
                            }
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: _lampSw5 ? Colors.red : Colors.green,
                        iconSize: 50,
                        // iconSize: 30,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 5 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _lampSw6 = !_lampSw6;
                            if (_lampSw6) {
                              mqttClientManager.publishMessage(TopicSw6, "off");
                            } else {
                              mqttClientManager.publishMessage(TopicSw6, "on");
                            }
                          });
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: _lampSw6 ? Colors.red : Colors.green,
                        iconSize: 50,
                        // iconSize: 30,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 6 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(subTopicSw1);
    mqttClientManager.subscribe(subTopicSw2);
    mqttClientManager.subscribe(subTopicSw3);
    mqttClientManager.subscribe(subTopicSw4);
    mqttClientManager.subscribe(subTopicSw5);
    mqttClientManager.subscribe(subTopicSw6);
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
          _lampSw1 = false;
        });
      } else if (publicMess == "Off") {
        setState(() {
          _lampSw1 = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mqttClientManager.disconnect();
    super.dispose();
  }
}
