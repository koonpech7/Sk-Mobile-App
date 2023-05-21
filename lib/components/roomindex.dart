import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SKRoomcard extends StatefulWidget {
  const SKRoomcard({
    super.key,
    required this.topic,
    required this.name,
    required this.status,
    required this.onPressd,
  });

  final String topic;
  final String name;
  final bool status;
  final VoidCallback onPressd;

  @override
  State<SKRoomcard> createState() => _SKRoomcardState();
}

class _SKRoomcardState extends State<SKRoomcard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Checktopicnull(widget.topic, height / 7, width);
  }

  Checktopicnull(
    String topic,
    double height,
    double width,
  ) {
    if (topic.isEmpty) {
      return SizedBox.shrink();
    } else {
      return Container(
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
                  widget.name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.status ? "Close" : "Open",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.status
                          ? const Color(0xFFFF0505)
                          : const Color(0xFF05FF3C)),
                ),
                // Text(
                //   "Status  " "${widget.status}",
                //   style: const TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold),
                // ),
                const Spacer(),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF69696F),
                      radius: 30,
                      child: IconButton(
                        onPressed: widget.onPressd,
                        icon: widget.status
                            ? const Icon(FontAwesomeIcons.lightbulb)
                            : const Icon(FontAwesomeIcons.solidLightbulb),
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
      );
    }
  }
}
