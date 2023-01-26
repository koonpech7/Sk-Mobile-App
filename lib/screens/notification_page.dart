import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testflutter/components/appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    List<Notifications> notification = [
      Notifications(name: "PAT", time: "04:32 pm", status: false),
      Notifications(name: "VTN", time: "06:45 pm", status: true),
      Notifications(name: "TAL", time: "09:26 am", status: false),
      Notifications(name: "SKM", time: "12:30 pm", status: true),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Notifications",
        onPressed: () {
          Navigator.pop(context);
        },
        haveleading: false,
        havetactions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: height / 1.7,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notification.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
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
                            "${notification[index].name}",
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            notification[index].status! ? "close" : "open",
                            style: TextStyle(
                              fontSize: 15,
                              color: notification[index].status!
                                  ? const Color(0xFFFF0505)
                                  : const Color(0xFF05FF3C),
                            ),
                          ),
                          trailing: Text(
                            "${notification[index].time}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
      ),
    );
  }
}
