import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import '../components/appbar.dart';
import '../models/notificationgetSingel.dart';

class GetSingelNoti extends StatefulWidget {
  const GetSingelNoti({
    super.key,
    required this.index,
  });
  final int index;
  // final NotificationgetSingle notisingel;

  @override
  State<GetSingelNoti> createState() => _GetSingelNotiState();
}

class _GetSingelNotiState extends State<GetSingelNoti> {
  late NotificationgetSingle notisigel;

  bool isLoading = false;
  // error msg?
  String errorMsg = "";

  Future<NotificationgetSingle> getDataFromApi() async {
    Uri url = Uri.parse('http://202.44.35.76:9091/api/reports/${widget.index}');
    // Uri url = Uri.parse();
    var response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      //ok
      NotificationgetSingle notilogSingel =
          notificationgetSingleFromJson(response.body);
      return notilogSingel;
    } else {
      errorMsg = "${response.statusCode}: ${response.body}";
      return NotificationgetSingle(
          accurency: "",
          airStatus: "",
          comOnCount: 0,
          doorStatus: "",
          id: 0,
          image: "",
          lamp1Status: "",
          lamp2Status: "",
          lamp3Status: "",
          lamp4Status: "",
          lamp5Status: "",
          lamp6Status: "",
          personCount: 0,
          reportDate: "",
          reportTime: "",
          roomLabel: "",
          status: "",
          updateAt: DateTime.now());
    }
  }

  assignData() async {
    notisigel = await getDataFromApi();
    setState(() {
      isLoading = true;
    });
  }

  Widget ConvrenUrl(url, width, height) {
    String str = url;
    int startIndex = 23;
    String result = str.substring(startIndex);
    Uint8List bytesImage = const Base64Decoder().convert(result);
    return Image.memory(
      bytesImage,
      width: width,
      height: height,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
        title: "Notifications Detail",
        onPressed: () {
          Navigator.pop(context);
        },
        subtitle: "Log Details",
        havetactions: false,
      ),
      body: !isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMsg.isNotEmpty
              ? Center(child: Text("${notisigel.id}"))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: height / 1.3,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 27, 27, 39),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Room Name ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.roomLabel,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Report Date ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.reportDate,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Report Time ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.reportTime,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Person Count ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text("${notisigel.personCount}",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Door Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.doorStatus,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Air Conditioner Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.airStatus,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Lamp 1 Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.lamp1Status,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Lamp 2 Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.lamp2Status,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Lamp 3 Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.lamp3Status,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Lamp 4 Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.lamp4Status,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Lamp 5 Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.lamp5Status,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        Row(
                          children: [
                            const Text("Lamp 6 Status ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const Spacer(),
                            Text(notisigel.lamp6Status,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ],
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        ConvrenUrl(notisigel.image, width / 0.1, height / 5.5)
                      ],
                    ),
                  ),
                ),
    );
  }
}
