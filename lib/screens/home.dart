import 'package:flutter/material.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:testflutter/MQTTClientManager.dart';
import 'package:testflutter/screens/screens.dart';

import '../components/components.dart';




class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
   MQTTClientManager mqttClientManager = MQTTClientManager();
  final String pubTopic = "/test";

  bool _doorstatus = false;

   @override
  void initState() {
    setupMqttClient();
    setupUpdatesListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var a = 1;
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Hi Admin",
        subtitle: "good morning",
        onPressed: () {
          Navigator.pop(context);
        },
        haveleading: false,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                SwitchListTile(
                      title: Text("Open The Door"),
                      subtitle:
                          a != 2 ? Text("Please Open The Door") : Text("test"),
                      value: _doorstatus,
                      onChanged: (bool value) {
                        setState(() {
                          _doorstatus = value;
                          mqttClientManager.publishMessage(
                              pubTopic, "You Door Status is ${_doorstatus}");
                        });
                      }),

                Container(
                  child: ElevatedButton(
                    child: Text("to single page"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndexRoom()),
                      );
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: Text("Notification Pages"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
 Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(pubTopic);
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
      //  final pt2 =
      //     MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      // print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt2\n');
    });
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }


}
