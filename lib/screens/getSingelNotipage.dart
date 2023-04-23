import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');
    Uri url = Uri.parse(
        'http://202.44.35.76:9091/api/dashboard/reports/${widget.index}');
    // Uri url = Uri.parse();
    var response = await http.get(url, headers: {'X-Token': '$token'});

    if (response.statusCode == HttpStatus.ok) {
      //ok
      NotificationgetSingle notilogSingel =
          notificationgetSingleFromJson(response.body);
      return notilogSingel;
    } else {
      errorMsg = "${response.statusCode}: ${response.body}";
      return NotificationgetSingle(
          accurency: "222",
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

  // Widget ConvrenUrl(
  //   url,
  // ) {
  //   String str = url;
  //   int startIndex = 23;
  //   String result = str.substring(startIndex);
  //   Uint8List bytesImage = const Base64Decoder().convert(result);
  //   return Image.memory(
  //     bytesImage,
  //     width: 600,
  //     height: 300,
  //   );
  // }

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
              ? const Center(
                  child: Text(
                  "Error",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 255, 17, 0),
                      fontWeight: FontWeight.bold),
                ))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: height / 1.4,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 27, 27, 39),
                    ),
                    child: Column(
                      children: [showwidget()],
                    ),
                  ),
                ),
    );
  }

  showwidget() {
    if (notisigel.status == "detected") {
      return Column(
        children: [
          Row(
            children: [
              const Text("Room Name ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text(notisigel.roomLabel,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Report Date ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text(notisigel.reportDate,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Report Time ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text(notisigel.reportTime,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Person Count ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text("${notisigel.personCount}",
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Comeputer On Count ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text("${notisigel.comOnCount}",
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          // ConvrenUrl(
          //   notisigel.image,
          // )
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              const Text("Room Name ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text(notisigel.roomLabel,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Report Date ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text(notisigel.reportDate,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Report Time ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              Text(notisigel.reportTime,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF05FF3C)))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Door Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.doorStatus)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Air Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.airStatus)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Lamp 1 Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.lamp1Status)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Lamp 2 Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.lamp2Status)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Lamp 3 Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.lamp3Status)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Lamp 4 Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.lamp4Status)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Lamp 5 Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.lamp5Status)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text("Lamp 6 Status ",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Spacer(),
              checkStatus(notisigel.lamp6Status)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // ConvrenUrl(
          //   notisigel.image,
          // )
        ],
      );
    }
  }

  checkStatus(String status) {
    if (status == "true") {
      return const Text("Close",
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 17, 0)));
    } else {
      return const Text("Open",
          style: TextStyle(fontSize: 18, color: Color(0xFF05FF3C)));
    }
  }
}
