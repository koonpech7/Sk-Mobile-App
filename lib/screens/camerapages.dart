import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testflutter/components/appbar.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class CameraScreens extends StatefulWidget {
  const CameraScreens(
      {super.key, required this.cameraURL, required this.roomNumber});

  final cameraURL;
  final roomNumber;

  @override
  State<CameraScreens> createState() => _CameraScreensState();
}

class _CameraScreensState extends State<CameraScreens> {
  late VlcPlayerController controller = VlcPlayerController.network(
    "${widget.cameraURL}",
    hwAcc: HwAcc.full,
    autoPlay: true,
    options: VlcPlayerOptions(),
  );

  // final VlcPlayerController _playerController - VlcPlayerController.net

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFF1F1F39),
        appBar: SKAppBar(
          title: "Camara Room ${widget.roomNumber}",
          subtitle: "Camara ${widget.roomNumber}",
          onPressed: () {
            Navigator.pop(context);
          },
          havetactions: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 27, 27, 39),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                          child: VlcPlayer(
                        controller: controller,
                        aspectRatio: 16 / 9,
                        placeholder:
                            const Center(child: CircularProgressIndicator()),
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: height / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 27, 27, 39),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Room : ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text("${widget.roomNumber}",
                        style: const TextStyle(
                            color: Color(0xFF05FF3C),
                            fontSize: 25,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
